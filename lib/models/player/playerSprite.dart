import 'package:dsixv02app/models/gameController.dart';
import 'package:dsixv02app/models/turnOrder/turn.dart';
import 'package:dsixv02app/models/player/user.dart';
import 'package:dsixv02app/models/turnOrder/turnController.dart';
import 'package:dsixv02app/shared/widgets/uiColor.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:rive/rive.dart';
import 'package:transparent_pointer/transparent_pointer.dart';
import 'playerSpriteImage.dart';
import 'player.dart';
import 'playerTempLocation.dart';

// ignore: must_be_immutable
class PlayerSprite extends StatefulWidget {
  Function() refresh;
  PlayerTempLocation tempLocation;
  Player player;
  PlayerSprite({
    Key key,
    this.refresh,
    @required this.tempLocation,
    @required this.player,
  }) : super(key: key);

  @override
  State<PlayerSprite> createState() => _PlayerSpriteState();
}

class _PlayerSpriteState extends State<PlayerSprite> {
  PlayerSpriteController playerSpriteController = PlayerSpriteController();

  @override
  void initState() {
    playerSpriteController.loadRiverFile();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final gameController = Provider.of<GameController>(context);
    final players = Provider.of<List<Player>>(context);
    final turnController = Provider.of<TurnController>(context);
    final turnOrder = Provider.of<List<Turn>>(context);
    final user = Provider.of<User>(context);

    playerSpriteController.updatePlayer(
        players[user.selectedPlayerIndex], user);

    return Positioned(
      left: playerSpriteController
          .calculateSpritePosition(
              widget.tempLocation, widget.player.visionRange)
          .dx,
      top: playerSpriteController
          .calculateSpritePosition(
              widget.tempLocation, widget.player.visionRange)
          .dy,
      child: TransparentPointer(
        transparent: true,
        child: SizedBox(
          width: widget.player.visionRange,
          height: widget.player.visionRange,
          child: Stack(
            children: [
              Align(
                  alignment: Alignment.center,
                  child: VisionRange(vision: widget.player.visionRange)),
              Align(
                alignment: Alignment.center,
                child: WalkRange(
                  walkRange: playerSpriteController.calculateWalkedDistance(
                      widget.tempLocation,
                      widget.player.getLocation(),
                      widget.player.walkRange),
                ),
              ),
              Align(
                alignment: Alignment.center,
                child: AttackRange(
                  maxAttackRange: widget.player.maxAttackRange,
                  minAttackRange: widget.player.minAttackRange,
                ),
              ),
              Align(
                alignment: Alignment.center,
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 9),
                  child: Container(
                    width: 5,
                    height: 10,
                    child: GestureDetector(
                      onTap: () {
                        user.openOrCloseMenu(turnController.isPlayerTurn(
                            turnOrder, user.selectedPlayer.id));
                        widget.refresh();
                      },
                      onPanUpdate: (details) {
                        playerSpriteController.walk(
                            widget.tempLocation,
                            widget.player.getLocation(),
                            Offset(details.delta.dx, details.delta.dy),
                            widget.player.walkRange,
                            user.playerMode);
                      },
                      onPanEnd: (details) {
                        playerSpriteController.endWalk(
                          user,
                          widget.tempLocation,
                        );

                        turnController.takeTurn(
                            gameController, players, turnOrder, user);

                        widget.refresh();
                      },
                    ),
                  ),
                ),
              ),
              Align(
                alignment: Alignment.center,
                child: TransparentPointer(
                  transparent: true,
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 14),
                    child: (players[user.selectedPlayerIndex].life < 1)
                        ? PlayerSpriteImage(image: 'grave')
                        : PlayerSpriteImage(image: widget.player.race),
                  ),
                ),
              ),
              Align(
                alignment: Alignment.center,
                child: TransparentPointer(
                  transparent: true,
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 25),
                    child: (playerSpriteController.artboard != null)
                        ? SizedBox(
                            width: 10,
                            height: 20,
                            child: Rive(
                              artboard: playerSpriteController.artboard,
                              fit: BoxFit.fill,
                            ),
                          )
                        : SizedBox(),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class PlayerSpriteController {
  Artboard artboard;

  void loadRiverFile() async {
    final bytes = await rootBundle.load('assets/animation/damage.riv');
    final file = RiveFile.import(bytes);

    artboard = file.mainArtboard;
    offAnimation();
  }

  offAnimation() {
    artboard.addController(SimpleAnimation('off'));
  }

  playDamageAnimation(int damage) {
    artboard.addController(OneShotAnimation(
      '$damage',
    ));
  }

  void updatePlayer(Player player, User user) {
    if (player.life == user.selectedPlayer.life) {
      return;
    }
    int damage = user.selectedPlayer.life - player.life;
    playDamageAnimation(damage);
    user.updateSelectedPlayer(player);
  }

  Offset calculateSpritePosition(
      PlayerTempLocation temporaryLocation, double visionRange) {
    return Offset(temporaryLocation.dx - visionRange / 2,
        temporaryLocation.dy - visionRange / 2);
  }

  double calculateWalkedDistance(
      PlayerTempLocation temporaryLocation, playerLocation, double walkRange) {
    double totalWalkDistance =
        (Offset(temporaryLocation.dx, temporaryLocation.dy) - playerLocation)
                .distance *
            2;

    if (walkRange - totalWalkDistance < 0) {
      totalWalkDistance = 0;
    } else {
      totalWalkDistance = walkRange - totalWalkDistance;
    }
    return totalWalkDistance;
  }

  void walk(PlayerTempLocation temporaryLocation, Offset playerLocation,
      Offset newLocation, walkRange, String playerMode) {
    if (calculateWalkedDistance(temporaryLocation, playerLocation, walkRange) <
            1 ||
        playerMode != 'walk') {
      return;
    }

    temporaryLocation.walk(newLocation.dx, newLocation.dy);
  }

  void endWalk(
    User user,
    PlayerTempLocation temporaryLocation,
  ) {
    if (user.playerMode != 'walk') {
      return;
    }

    temporaryLocation.endWalk(user.selectedPlayer.id);
    user.updateSelectedPlayerLocation(
        temporaryLocation.dx, temporaryLocation.dy);
  }
}

// ignore: must_be_immutable
class AttackRange extends StatelessWidget {
  double maxAttackRange;
  double minAttackRange;
  AttackRange({
    Key key,
    @required this.maxAttackRange,
    @required this.minAttackRange,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    double setMaxAttackRange(String mode) {
      switch (mode) {
        case 'walk':
          return 0;
          break;
        case 'wait':
          return 0;
          break;
        case 'menu':
          return 0;
          break;
        case 'attack':
          return maxAttackRange;
          break;
      }

      return 0.0;
    }

    double setMinAttackRange(String mode) {
      switch (mode) {
        case 'walk':
          return 0;
          break;
        case 'wait':
          return 0;
          break;
        case 'menu':
          return 0;
          break;
        case 'attack':
          return minAttackRange;
          break;
      }

      return 0.0;
    }

    return (setMaxAttackRange(user.playerMode) < 1)
        ? SizedBox()
        : CustomPaint(
            painter: AttackArea(
              minRange: setMinAttackRange(user.playerMode),
              maxRange: setMaxAttackRange(user.playerMode),
            ),
            child: AnimatedContainer(
              curve: Curves.fastLinearToSlowEaseIn,
              duration: Duration(milliseconds: 250),
              width: setMaxAttackRange(user.playerMode),
              height: setMaxAttackRange(user.playerMode),
            ),
          );
  }
}

class AttackArea extends CustomPainter {
  double minRange;
  double maxRange;

  AttackArea({double minRange, double maxRange}) {
    this.minRange = minRange;
    this.maxRange = maxRange;
  }

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(maxRange / 2, maxRange / 2);

    final fillColor = Paint()
      ..color = Color.fromRGBO(200, 25, 25, 1).withAlpha(35);

    canvas.drawPath(
      Path.combine(
        PathOperation.difference,
        Path()..addOval(Rect.fromCircle(center: center, radius: maxRange / 2)),
        Path()
          ..addOval(Rect.fromCircle(center: center, radius: minRange / 2))
          ..close(),
      ),
      fillColor,
    );

    final strokeColor = Paint()
      ..color = Color.fromRGBO(200, 25, 25, 1).withAlpha(125)
      ..strokeWidth = 0.3
      ..style = PaintingStyle.stroke;

    canvas.drawPath(
      Path.combine(
        PathOperation.difference,
        Path()..addOval(Rect.fromCircle(center: center, radius: maxRange / 2)),
        Path()
          ..addOval(Rect.fromCircle(center: center, radius: minRange / 2))
          ..close(),
      ),
      strokeColor,
    );
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return null;
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
          return 6;
          break;
        case 'menu':
          return 6;
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
          return 6;
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
