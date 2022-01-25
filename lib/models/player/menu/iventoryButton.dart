import 'package:dsixv02app/models/player/equipment/widget/equipmentPage.dart';
import 'package:dsixv02app/models/player/player.dart';
import 'package:dsixv02app/shared/app_Icons.dart';
import 'package:dsixv02app/shared/widgets/uiColor.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:rive/rive.dart';

class IventoryButton extends StatefulWidget {
  final Player? player;
  IventoryButton({
    Key? key,
    @required this.player,
  }) : super(key: key);

  @override
  _IventoryButtonState createState() => _IventoryButtonState();
}

class _IventoryButtonState extends State<IventoryButton> {
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
    _artboard!.addController(OneShotAnimation(
      'onTap',
    ));
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      curve: Curves.fastLinearToSlowEaseIn,
      duration: Duration(milliseconds: 500),
      width: (widget.player!.mode == 'menu')
          ? MediaQuery.of(context).size.height * 0.02
          : 0,
      height: (widget.player!.mode == 'menu')
          ? MediaQuery.of(context).size.height * 0.02
          : 0,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color:
            _uiColor.setUIColor(widget.player!.id, 'secondary').withAlpha(215),
        border: Border.all(
          color: _uiColor
              .setUIColor(widget.player!.id, 'secondary')
              .withAlpha(250),
          width: .5,
        ),
      ),
      child: GestureDetector(
        onTap: () {
          setState(() {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return EquipmentPage(
                  player: widget.player,
                );
              },
            );
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
                  AppIcons.bag,
                  color: _uiColor.setUIColor(widget.player!.id, 'primary'),
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
