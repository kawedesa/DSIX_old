import 'package:dsixv02app/models/game.dart';
import 'package:dsixv02app/models/player.dart';
import 'package:dsixv02app/models/user.dart';
import 'package:dsixv02app/pages/shared/app_Icons.dart';
import 'package:dsixv02app/pages/shared/widgets/uiColor.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:rive/rive.dart';
import 'spriteImage.dart';

// ignore: must_be_immutable
class PlayerSprite extends StatefulWidget {
  PlayerTemporaryLocation temporaryLocation;
  Player player;

  PlayerSprite({
    Key key,
    @required this.temporaryLocation,
    @required this.player,
  }) : super(key: key);

  @override
  _PlayerSpriteState createState() => _PlayerSpriteState();
}

class _PlayerSpriteState extends State<PlayerSprite> {
  Offset calculateSpritePosition() {
    return Offset(widget.temporaryLocation.dx - widget.player.vision / 2,
        widget.temporaryLocation.dy - widget.player.vision / 2);
  }

  double calculateWalkedDistance() {
    double totalWalkDistance =
        (Offset(widget.temporaryLocation.dx, widget.temporaryLocation.dy) -
                    Offset(widget.player.dx, widget.player.dy))
                .distance *
            2;

    if (widget.player.walkRange - totalWalkDistance < 0) {
      totalWalkDistance = 0;
    } else {
      totalWalkDistance = widget.player.walkRange - totalWalkDistance;
    }
    return totalWalkDistance;
  }

  @override
  Widget build(BuildContext context) {
    return PlayerSpriteController(
      temporaryLocation: widget.temporaryLocation,
      spritePosition: calculateSpritePosition(),
      vision: widget.player.vision,
      walkRange: calculateWalkedDistance(),
      image: widget.player.race,
    );
  }
}

// ignore: must_be_immutable
class PlayerSpriteController extends StatefulWidget {
  PlayerTemporaryLocation temporaryLocation;
  Offset spritePosition;
  double vision;
  double walkRange;
  String image;
  PlayerSpriteController({
    Key key,
    this.temporaryLocation,
    this.spritePosition,
    this.vision,
    this.walkRange,
    this.image,
  }) : super(key: key);

  @override
  State<PlayerSpriteController> createState() => _PlayerSpriteControllerState();
}

class _PlayerSpriteControllerState extends State<PlayerSpriteController> {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    final turnOrder = Provider.of<List<Turn>>(context);
    final game = Provider.of<Game>(context);
    final players = Provider.of<List<Player>>(context);

    return Positioned(
      left: this.widget.spritePosition.dx,
      top: this.widget.spritePosition.dy,
      child: SizedBox(
        width: this.widget.vision,
        height: this.widget.vision,
        child: Stack(
          children: [
            Align(
                alignment: Alignment.center,
                child: VisionRange(vision: this.widget.vision)),
            Align(
              alignment: Alignment.center,
              child: WalkRange(
                walkRange: this.widget.walkRange,
              ),
            ),
            Align(
              alignment: Alignment.center,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: AnimatedContainer(
                    curve: Curves.fastLinearToSlowEaseIn,
                    duration: Duration(milliseconds: 400),
                    width: (user.playerMode == 'menu') ? 55 : 0.0,
                    height: (user.playerMode == 'menu') ? 55 : 0.0,
                    child: PlayerSpriteMenu()),
              ),
            ),
            Align(
              alignment: Alignment.center,
              child: GestureDetector(
                  onTap: () {
                    setState(() {
                      user.onTapAction(turnOrder);
                    });
                  },
                  onPanUpdate:
                      (widget.walkRange < 1 || user.playerMode != 'walk')
                          ? (details) {}
                          : (details) {
                              widget.temporaryLocation.changePlayerLocation(
                                  details.delta.dx, details.delta.dy);
                            },
                  onPanEnd: (user.playerMode != 'walk')
                      ? (details) {}
                      : (details) {
                          setState(() {
                            user.changeSelectedPlayerLocation(
                              widget.temporaryLocation.dx,
                              widget.temporaryLocation.dy,
                            );
                            turnOrder.first.takeTurn();

                            if (turnOrder.first.turnIsNotOver()) {
                              return;
                            }

                            if (turnOrder.length == 1) {
                              game.newRound(game.round);
                              user.newTurnOrder(players);
                            } else {
                              user.passTurn(turnOrder.first.index);
                            }
                          });
                        },
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: SpriteImage(image: widget.image),
                  )),
            )
          ],
        ),
      ),
    );
  }
}

class PlayerSpriteMenu extends StatelessWidget {
  const PlayerSpriteMenu({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Align(
          alignment: Alignment.topCenter,
          child: ActionButton(
            action: 'attack',
            onTap: () {},
          ),
        ),
        Align(
          alignment: Alignment.centerLeft,
          child: ActionButton(
            action: 'defend',
            onTap: () {},
          ),
        ),
        Align(
          alignment: Alignment.centerRight,
          child: ActionButton(
            action: 'look',
            onTap: () {},
          ),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: ActionButton(
            action: 'move',
            onTap: () {},
          ),
        ),
      ],
    );
  }
}

// ignore: must_be_immutable
class ActionButton extends StatefulWidget {
  String action;
  Function() onTap;
  ActionButton({
    Key key,
    this.action,
    this.onTap,
  }) : super(key: key);

  @override
  _ActionButtonState createState() => _ActionButtonState();
}

class _ActionButtonState extends State<ActionButton> {
  Artboard _artboard;

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
      case 'move':
        return AppIcons.move;
        break;
    }
    return AppIcons.attack;
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    UIColor _uiColor = UIColor();

    return GestureDetector(
      onTap: () {
        setState(() {
          widget.onTap();
          _playOnTapAnimation();
        });
      },
      child: AnimatedContainer(
        curve: Curves.fastLinearToSlowEaseIn,
        duration: Duration(milliseconds: 500),
        width: (user.playerMode == 'menu') ? 17 : 0.0,
        height: (user.playerMode == 'menu') ? 17 : 0.0,
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.all(4),
              child: SvgPicture.asset(
                setIcon(widget.action),
                color: _uiColor.setUIColor(user.selectedPlayer.id, 'primary'),
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
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: _uiColor.setUIColor(user.selectedPlayer.id, 'secondary'),
          border: Border.all(
            color: _uiColor.setUIColor(user.selectedPlayer.id, 'tertiary'),
            width: .5,
          ),
        ),
      ),
    );
  }
}

// ignore: must_be_immutable
class WalkRange extends StatelessWidget {
  double walkRange;
  WalkRange({
    Key key,
    @required this.walkRange,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    UIColor _uiColor = UIColor();
    double setWalkRange(String mode) {
      switch (mode) {
        case 'walk':
          return walkRange;
          break;
        case 'wait':
          return 8;
          break;
        case 'menu':
          return 8;
          break;
        case 'attack':
          return 0.0;
          break;
      }

      return 0.0;
    }

    return AnimatedContainer(
      curve: Curves.fastLinearToSlowEaseIn,
      duration: Duration(milliseconds: 250),
      width: setWalkRange(user.playerMode),
      height: setWalkRange(user.playerMode),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: _uiColor
            .setUIColor(user.selectedPlayer.id, 'shadow')
            .withAlpha(75 - walkRange.floor()),
        border: Border.all(
          color: _uiColor.setUIColor(user.selectedPlayer.id, 'rangeOutline'),
          width: 0.3,
        ),
      ),
    );
  }
}

// ignore: must_be_immutable
class VisionRange extends StatelessWidget {
  double vision;
  VisionRange({Key key, @required this.vision}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    UIColor _uiColor = UIColor();

    double setVisionRange(String mode) {
      switch (mode) {
        case 'walk':
          return vision;
          break;
        case 'wait':
          return vision;
          break;
        case 'menu':
          return 8;
          break;
        case 'attack':
          return 0.0;
          break;
      }

      return 0.0;
    }

    return AnimatedContainer(
      curve: Curves.fastLinearToSlowEaseIn,
      duration: Duration(milliseconds: 700),
      width: setVisionRange(user.playerMode),
      height: setVisionRange(user.playerMode),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          color: _uiColor.setUIColor(user.selectedPlayer.id, 'rangeOutline'),
          width: 0.3,
        ),
      ),
    );
  }
}
