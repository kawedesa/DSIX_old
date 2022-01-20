import 'package:dsixv02app/shared/app_Colors.dart';
import 'package:dsixv02app/shared/app_Icons.dart';
import 'package:dsixv02app/shared/widgets/uiColor.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:rive/rive.dart';
import '../user.dart';

// ignore: must_be_immutable
class ActionButton extends StatefulWidget {
  String? action;
  final Function()? onTap;
  ActionButton({
    Key? key,
    @required this.action,
    @required this.onTap,
  }) : super(key: key);

  @override
  _ActionButtonState createState() => _ActionButtonState();
}

class _ActionButtonState extends State<ActionButton> {
  UIColor _uiColor = UIColor();
  Artboard? _artboard;

  @override
  void initState() {
    _loadRiverFile();
    super.initState();
  }

  void _loadRiverFile() async {
    final bytes = await rootBundle.load('assets/animation/buttonAnimation.riv');
    final file = RiveFile.import(bytes);
    setState(() {
      _artboard = file.mainArtboard;
      _playReflectionAnimation();
    });
  }

  _playReflectionAnimation() {
    _artboard!.addController(SimpleAnimation('reflection'));
  }

  _playOnTapAnimation() {
    _artboard!.addController(SimpleAnimation(
      'onTap',
    ));
  }

  String setIcon(String action) {
    switch (action) {
      case 'attack':
        return AppIcons.attack;

      case 'defend':
        return AppIcons.defend;

      case 'look':
        return AppIcons.look;
    }
    return AppIcons.attack;
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);

    return (user.selectedPlayer!.action!.outOfActions())
        ? AnimatedContainer(
            curve: Curves.fastLinearToSlowEaseIn,
            duration: Duration(milliseconds: 500),
            width: (user.menuIsOpen)
                ? MediaQuery.of(context).size.height * 0.02
                : 0,
            height: (user.menuIsOpen)
                ? MediaQuery.of(context).size.height * 0.02
                : 0,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: AppColors.grey02!.withAlpha(215),
              border: Border.all(
                color: AppColors.grey02!.withAlpha(250),
                width: .5,
              ),
            ),
            child: Stack(
              children: [
                Align(
                  alignment: Alignment.center,
                  child: Padding(
                    padding: const EdgeInsets.all(3.0),
                    child: SvgPicture.asset(
                      setIcon(widget.action!),
                      color: AppColors.grey04,
                    ),
                  ),
                ),
              ],
            ),
          )
        : AnimatedContainer(
            curve: Curves.fastLinearToSlowEaseIn,
            duration: Duration(milliseconds: 500),
            width: (user.menuIsOpen)
                ? MediaQuery.of(context).size.height * 0.02
                : 0,
            height: (user.menuIsOpen)
                ? MediaQuery.of(context).size.height * 0.02
                : 0,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: _uiColor
                  .setUIColor(user.selectedPlayer!.id, 'secondary')
                  .withAlpha(215),
              border: Border.all(
                color: _uiColor
                    .setUIColor(user.selectedPlayer!.id, 'secondary')
                    .withAlpha(250),
                width: .5,
              ),
            ),
            child: GestureDetector(
              onTap: () {
                setState(() {
                  widget.onTap!();
                  _playOnTapAnimation();
                });
              },
              child: Stack(
                children: [
                  Align(
                    alignment: Alignment.center,
                    child: Padding(
                      padding: const EdgeInsets.all(3.0),
                      child: SvgPicture.asset(
                        setIcon(widget.action!),
                        color: _uiColor.setUIColor(
                            user.selectedPlayer!.id, 'primary'),
                      ),
                    ),
                  ),
                  (_artboard != null)
                      ? ClipOval(
                          child: Rive(
                            artboard: _artboard!,
                            fit: BoxFit.fill,
                          ),
                        )
                      : SizedBox(),
                ],
              ),
            ),
          );
  }
}
