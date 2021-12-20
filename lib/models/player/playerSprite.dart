import 'package:dsixv02app/models/turnOrder/turn.dart';
import 'package:dsixv02app/models/player/user.dart';
import 'package:dsixv02app/models/turnOrder/turnController.dart';
import 'package:dsixv02app/shared/app_Colors.dart';
import 'package:dsixv02app/shared/app_Exceptions.dart';
import 'package:dsixv02app/shared/app_Icons.dart';
import 'package:dsixv02app/shared/widgets/uiColor.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
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
              //VISION RANGE
              Align(
                  alignment: Alignment.center,
                  child: VisionRange(vision: widget.player.visionRange)),
              //WALK RANGE
              Align(
                alignment: Alignment.center,
                child: WalkRange(
                  walkRange: playerSpriteController.calculateWalkedDistance(
                      widget.tempLocation,
                      widget.player.getLocation(),
                      widget.player.walkRange),
                ),
              ),

              //ATTACK RANGE
              Align(
                alignment: Alignment.center,
                child: AttackRange(
                  maxAttackRange: widget.player.maxAttackRange,
                  minAttackRange: widget.player.minAttackRange,
                ),
              ),
              //HITBOX CONTROLLER
              Align(
                alignment: Alignment.center,
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 9),
                  child: Container(
                    width: 5,
                    height: 10,
                    child: GestureDetector(
                      onTap: () {
                        user.openOrCloseMenu();
                        widget.refresh();
                      },
                      onPanUpdate: (details) {
                        if (user.playerMode != 'walk') {
                          return;
                        }
                        playerSpriteController.walk(
                            widget.tempLocation,
                            widget.player.getLocation(),
                            Offset(details.delta.dx, details.delta.dy),
                            widget.player.walkRange);
                      },
                      onPanEnd: (details) async {
                        user.endWalk(
                            widget.tempLocation.dx, widget.tempLocation.dy);

                        try {
                          turnController.takeTurn(turnOrder);
                        } on PlayerTurnException {
                          user.walkMode();
                        } on NotPlayerTurnException {
                          user.endPlayerTurn();
                        }
                      },
                    ),
                  ),
                ),
              ),
              //IMAGE
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
              //TEMP EFFECTS
              Align(
                alignment: Alignment.center,
                child: TransparentPointer(
                  transparent: true,
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 28),
                    child: AnimatedContainer(
                      duration: Duration(milliseconds: 250),
                      width: (user.selectedPlayer.tempArmor > 0) ? 5 : 0,
                      height: (user.selectedPlayer.tempArmor > 0) ? 5 : 0,
                      child: Stack(children: [
                        SvgPicture.asset(
                          AppIcons.tempArmor,
                          color: AppColors.goodEffectImage,
                        ),
                        Align(
                          alignment: Alignment.center,
                          child: FittedBox(
                              child: Padding(
                            padding: const EdgeInsets.fromLTRB(0, 1, 0, 3),
                            child: Text(
                              '${user.selectedPlayer.tempArmor}',
                              style: TextStyle(
                                fontFamily: 'Santana',
                                color: AppColors.goodEffectText,
                              ),
                            ),
                          )),
                        ),
                      ]),
                    ),
                  ),
                ),
              ),
              //DAMAGE ANIMATION
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
              ),
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

  void updatePlayer(Player player, User user) {
    checkTempArmor(player.tempArmor, user.selectedPlayer.tempArmor);
    checkLife(player.life, user.selectedPlayer.life);

    user.updateSelectedPlayer(player);
  }

  void checkTempArmor(int newArmor, oldArmor) {
    if (oldArmor != newArmor) {
      int damage = oldArmor - newArmor;
      playDamageAnimation(damage);
    }
  }

  void checkLife(int newLife, oldLife) {
    if (oldLife != newLife) {
      int damage = oldLife - newLife;
      playDamageAnimation(damage);
    }
  }

  playDamageAnimation(int damage) {
    artboard.addController(OneShotAnimation(
      '$damage',
    ));
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
      Offset newLocation, walkRange) {
    if (calculateWalkedDistance(temporaryLocation, playerLocation, walkRange) <
        1) {
      return;
    }

    temporaryLocation.walk(newLocation.dx, newLocation.dy);
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
          if (maxAttackRange > user.selectedPlayer.visionRange) {
            return user.selectedPlayer.visionRange;
          } else {
            return maxAttackRange;
          }

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

    return CustomPaint(
      painter: AttackArea(
        minRange: setMinAttackRange(user.playerMode),
        maxRange: setMaxAttackRange(user.playerMode),
      ),
      child: SizedBox(
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
        Path()
          ..addOval(
              Rect.fromCircle(center: center, radius: maxRange / 2 + 0.02)),
        Path()
          ..addOval(
              Rect.fromCircle(center: center, radius: minRange / 2 + 0.01))
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
        Path()
          ..addOval(
              Rect.fromCircle(center: center, radius: maxRange / 2 + 0.02)),
        Path()
          ..addOval(
              Rect.fromCircle(center: center, radius: minRange / 2 + 0.01))
          ..close(),
      ),
      strokeColor,
    );
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
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
