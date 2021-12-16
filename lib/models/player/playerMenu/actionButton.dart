import 'package:dsixv02app/models/turnOrder/turn.dart';
import 'package:dsixv02app/models/turnOrder/turnController.dart';
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
  String action;
  String playerMode;
  Function() onTap;
  ActionButton({
    Key key,
    @required this.action,
    @required this.playerMode,
    this.onTap,
  }) : super(key: key);

  @override
  _ActionButtonState createState() => _ActionButtonState();
}

class _ActionButtonState extends State<ActionButton> {
  Artboard _artboard;
  UIColor _uiColor = UIColor();

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
    _artboard.addController(SimpleAnimation('reflection'));
  }

  _playOnTapAnimation() {
    _artboard.addController(OneShotAnimation(
      'onTap',
    ));
  }

  String setIcon(String action) {
    switch (action) {
      case 'attack':
        return AppIcons.attack;
        break;
      case 'defend':
        return AppIcons.defend;
        break;
      case 'look':
        return AppIcons.look;
        break;
    }
    return AppIcons.attack;
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    final turnController = Provider.of<TurnController>(context);
    final turnOrder = Provider.of<List<Turn>>(context);
    return AnimatedContainer(
      curve: Curves.fastLinearToSlowEaseIn,
      duration: Duration(milliseconds: 500),
      width: (user.playerMode == 'menu')
          ? MediaQuery.of(context).size.height * 0.025
          : 0,
      height: (user.playerMode == 'menu')
          ? MediaQuery.of(context).size.height * 0.025
          : 0,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: (turnController.isPlayerTurn(turnOrder, user.selectedPlayer.id))
            ? _uiColor
                .setUIColor(user.selectedPlayer.id, 'secondary')
                .withAlpha(215)
            : AppColors.grey02.withAlpha(215),
        border: Border.all(
          color:
              (turnController.isPlayerTurn(turnOrder, user.selectedPlayer.id))
                  ? _uiColor
                      .setUIColor(user.selectedPlayer.id, 'secondary')
                      .withAlpha(250)
                  : AppColors.grey02.withAlpha(250),
          width: 0.5,
        ),
      ),
      child: GestureDetector(
        onTap: (turnController.isPlayerTurn(turnOrder, user.selectedPlayer.id))
            ? () {
                setState(() {
                  widget.onTap();
                  _playOnTapAnimation();
                });
              }
            : () {
                setState(() {
                  _playOnTapAnimation();
                });
              },
        child: Stack(
          children: [
            Align(
              alignment: Alignment.center,
              child: Padding(
                padding: const EdgeInsets.all(3),
                child: SvgPicture.asset(
                  setIcon(widget.action),
                  color: (turnController.isPlayerTurn(
                          turnOrder, user.selectedPlayer.id))
                      ? _uiColor.setUIColor(user.selectedPlayer.id, 'primary')
                      : AppColors.grey04,
                ),
              ),
            ),
            (_artboard != null)
                ? ClipOval(
                    child: Rive(
                      artboard: _artboard,
                      fit: BoxFit.fill,
                    ),
                  )
                : Container(),
          ],
        ),
      ),
    );
  }
}
