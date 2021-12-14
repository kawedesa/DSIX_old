import 'package:dsixv02app/models/turnOrder.dart';
import 'package:dsixv02app/models/user.dart';
import 'package:dsixv02app/pages/map/widget/iventory.dart';
import 'package:dsixv02app/pages/shared/app_Colors.dart';
import 'package:dsixv02app/pages/shared/app_Icons.dart';
import 'package:dsixv02app/pages/shared/widgets/uiColor.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:rive/rive.dart';

// ignore: must_be_immutable
class PlayerMenu extends StatelessWidget {
  final User user;
  final Function() refresh;
  PlayerMenu({Key key, this.user, this.refresh}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    UIColor _uiColor = UIColor();

    return Positioned(
      left: user.selectedPlayer.dx - MediaQuery.of(context).size.height * 0.05,
      top: user.selectedPlayer.dy - MediaQuery.of(context).size.height * 0.05,
      child: SizedBox(
        width: MediaQuery.of(context).size.height * 0.1,
        height: MediaQuery.of(context).size.height * 0.1,
        child: Center(
          child: AnimatedContainer(
            curve: Curves.fastLinearToSlowEaseIn,
            duration: Duration(milliseconds: 400),
            height: (user.playerMode == 'menu')
                ? MediaQuery.of(context).size.height * 0.1
                : 0.0,
            width: (user.playerMode == 'menu')
                ? MediaQuery.of(context).size.height * 0.1
                : 0.0,
            child: Stack(
              children: [
                Align(
                  alignment: Alignment.topCenter,
                  child: ActionButton(
                    action: 'attack',
                    playerMode: user.playerMode,
                    onTap: () {
                      user.attackMode();
                      refresh();
                    },
                  ),
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: ActionButton(
                    action: 'defend',
                    playerMode: user.playerMode,
                    onTap: () {
                      refresh();
                    },
                  ),
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: ActionButton(
                    action: 'look',
                    playerMode: user.playerMode,
                    onTap: () {
                      refresh();
                    },
                  ),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: AnimatedContainer(
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
                      color: _uiColor
                          .setUIColor(user.selectedPlayer.id, 'secondary')
                          .withAlpha(215),
                      border: Border.all(
                        color: _uiColor
                            .setUIColor(user.selectedPlayer.id, 'secondary')
                            .withAlpha(250),
                        width: .5,
                      ),
                    ),
                    child: IventoryButton(),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

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

// ignore: must_be_immutable
class IventoryButton extends StatefulWidget {
  IventoryButton({
    Key key,
  }) : super(key: key);

  @override
  _IventoryButtonState createState() => _IventoryButtonState();
}

class _IventoryButtonState extends State<IventoryButton> {
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

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);

    return GestureDetector(
      onTap: () {
        setState(() {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return Iventory(
                player: user.selectedPlayer,
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
              padding: const EdgeInsets.all(4.0),
              child: SvgPicture.asset(
                AppIcons.bag,
                color: _uiColor.setUIColor(user.selectedPlayer.id, 'primary'),
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
    );
  }
}
