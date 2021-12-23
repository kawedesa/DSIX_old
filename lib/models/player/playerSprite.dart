// import 'package:dsixv02app/models/turn.dart';
// import 'package:dsixv02app/models/player/user.dart';
// import 'package:dsixv02app/models/turnOrder/turnController.dart';
// import 'package:dsixv02app/shared/app_Colors.dart';
// import 'package:dsixv02app/shared/app_Exceptions.dart';
// import 'package:dsixv02app/shared/app_Icons.dart';
// import 'package:dsixv02app/shared/widgets/uiColor.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:provider/provider.dart';
// import 'package:rive/rive.dart';
// import 'package:transparent_pointer/transparent_pointer.dart';
// import 'playerSpriteImage.dart';
// import 'player.dart';
// import 'playerTempLocation.dart';

import 'package:dsixv02app/models/game.dart';
import 'package:dsixv02app/models/gameController.dart';
import 'package:dsixv02app/models/player/user.dart';
import 'package:dsixv02app/models/turnOrder/turnController.dart';
import 'package:dsixv02app/shared/app_Exceptions.dart';
import 'package:dsixv02app/shared/widgets/uiColor.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:transparent_pointer/transparent_pointer.dart';

import 'player.dart';
import 'playerSpriteImage.dart';

//  ignore: must_be_immutable
class PlayerSprite extends StatefulWidget {
  final Function()? refresh;
  PlayerTempLocation? tempLocation;
  Player? player;
  PlayerSprite({
    Key? key,
    @required this.refresh,
    @required this.player,
    @required this.tempLocation,
  }) : super(key: key);

  @override
  State<PlayerSprite> createState() => _PlayerSpriteState();
}

class _PlayerSpriteState extends State<PlayerSprite> {
  PlayerSpriteController playerSpriteController = PlayerSpriteController();

  // @override
  // void initState() {
  //   playerSpriteController.loadRiverFile();
  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    // final players = Provider.of<List<Player>>(context);
    final turnController = Provider.of<TurnController>(context);
    final gameController = Provider.of<GameController>(context);
    final user = Provider.of<User>(context);

    // playerSpriteController.updatePlayer(
    //     players[user.selectedPlayerIndex], user);

    return Positioned(
      left: playerSpriteController
          .calculateSpritePosition(
              widget.tempLocation, widget.player!.visionRange!.max)
          .dx,
      top: playerSpriteController
          .calculateSpritePosition(
              widget.tempLocation, widget.player!.visionRange!.max)
          .dy,
      child: TransparentPointer(
        transparent: true,
        child: SizedBox(
          width: widget.player!.visionRange!.max,
          height: widget.player!.visionRange!.max,
          child: Stack(
            children: [
              //VISION RANGE
              Align(
                  alignment: Alignment.center,
                  child: PlayerSpriteVisionRange(
                      visionRange: widget.player!.visionRange)),
              //WALK RANGE
              Align(
                alignment: Alignment.center,
                child: WalkRange(
                  walkRange: playerSpriteController.walkedDistance(
                      widget.tempLocation!,
                      widget.player!.location!,
                      widget.player!.walkRange!.max!),
                ),
              ),

              //ATTACK RANGE
              Align(
                alignment: Alignment.center,
                child: AttackRange(
                  maxAttackRange: widget.player!.attackRange!.max!,
                  minAttackRange: widget.player!.attackRange!.min!,
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
                    child: (user.playerMode != 'walk')
                        ? GestureDetector(
                            onTap: () {
                              user.openCloseMenu();
                              widget.refresh!();
                            },
                          )
                        : GestureDetector(
                            onTap: () {
                              user.openCloseMenu();
                              widget.refresh!();
                            },
                            onPanUpdate: (details) {
                              if (playerSpriteController.walkedDistance(
                                      widget.tempLocation!,
                                      widget.player!.location!,
                                      widget.player!.walkRange!.max!)! >
                                  0) {
                                widget.tempLocation!
                                    .walk(details.delta.dx, details.delta.dy);
                              }
                            },
                            onPanEnd: (details) {
                              user.endWalk(
                                gameController.gameID,
                                PlayerLocation(
                                    dx: widget.tempLocation!.dx,
                                    dy: widget.tempLocation!.dy),
                              );

                              user.takeAction(
                                gameController.gameID,
                              );
                              if (user.selectedPlayer!.action!.outOfActions()) {
                                turnController.passTurnWhere(
                                    gameController.gameID,
                                    user.selectedPlayer!.id!);
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
                    child: PlayerSpriteImage(
                        image: widget.player!.race,
                        isDead: widget.player!.life!.isDead()),
                  ),
                ),
              ),
              // //TEMP EFFECTS
              // Align(
              //   alignment: Alignment.center,
              //   child: TransparentPointer(
              //     transparent: true,
              //     child: Padding(
              //       padding: const EdgeInsets.only(bottom: 28),
              //       child: AnimatedContainer(
              //         duration: Duration(milliseconds: 250),
              //         width: (user.selectedPlayer.tempArmor > 0) ? 5 : 0,
              //         height: (user.selectedPlayer.tempArmor > 0) ? 5 : 0,
              //         child: Stack(children: [
              //           SvgPicture.asset(
              //             AppIcons.tempArmor,
              //             color: AppColors.goodEffectImage,
              //           ),
              //           Align(
              //             alignment: Alignment.center,
              //             child: FittedBox(
              //                 child: Padding(
              //               padding: const EdgeInsets.fromLTRB(0, 1, 0, 3),
              //               child: Text(
              //                 '${user.selectedPlayer.tempArmor}',
              //                 style: TextStyle(
              //                   fontFamily: 'Santana',
              //                   color: AppColors.goodEffectText,
              //                 ),
              //               ),
              //             )),
              //           ),
              //         ]),
              //       ),
              //     ),
              //   ),
              // ),
              // //DAMAGE ANIMATION
              // Align(
              //   alignment: Alignment.center,
              //   child: TransparentPointer(
              //     transparent: true,
              //     child: Padding(
              //       padding: const EdgeInsets.only(bottom: 25),
              //       child: (playerSpriteController.artboard != null)
              //           ? SizedBox(
              //               width: 10,
              //               height: 20,
              //               child: Rive(
              //                 artboard: playerSpriteController.artboard,
              //                 fit: BoxFit.fill,
              //               ),
              //             )
              //           : SizedBox(),
              //     ),
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}

class PlayerSpriteController {
  Offset calculateSpritePosition(
      PlayerTempLocation? location, double? visionRange) {
    return Offset(
        location!.dx! - visionRange! / 2, location.dy! - visionRange / 2);
  }

//   Artboard artboard;

//   void loadRiverFile() async {
//     final bytes = await rootBundle.load('assets/animation/damage.riv');
//     final file = RiveFile.import(bytes);

//     artboard = file.mainArtboard;
//     offAnimation();
//   }

//   offAnimation() {
//     artboard.addController(SimpleAnimation('off'));
//   }

//   void updatePlayer(Player player, User user) {
//     checkTempArmor(player.tempArmor, user.selectedPlayer.tempArmor);
//     checkLife(player.life, user.selectedPlayer.life);

//     user.updateSelectedPlayer(player);
//   }

//   void checkTempArmor(int newArmor, oldArmor) {
//     if (oldArmor != newArmor) {
//       int damage = oldArmor - newArmor;
//       playDamageAnimation(damage);
//     }
//   }

//   void checkLife(int newLife, oldLife) {
//     if (oldLife != newLife) {
//       int damage = oldLife - newLife;
//       playDamageAnimation(damage);
//     }
//   }

//   playDamageAnimation(int damage) {
//     artboard.addController(OneShotAnimation(
//       '$damage',
//     ));
//   }

  double? walkedDistance(PlayerTempLocation temporaryLocation,
      PlayerLocation playerLocation, double walkRange) {
    double distanceLeftOver =
        (Offset(temporaryLocation.dx!, temporaryLocation.dy!) -
                    Offset(playerLocation.dx!, playerLocation.dy!))
                .distance *
            2;

    if (walkRange - distanceLeftOver < 0) {
      distanceLeftOver = 0;
    } else {
      distanceLeftOver = walkRange - distanceLeftOver;
    }
    return distanceLeftOver;
  }
}

// ignore: must_be_immutable
class AttackRange extends StatelessWidget {
  double? maxAttackRange;
  double? minAttackRange;
  AttackRange({
    Key? key,
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

        case 'wait':
          return 0;

        case 'menu':
          return 0;

        case 'attack':
          if (maxAttackRange! > user.selectedPlayer!.visionRange!.max!) {
            return user.selectedPlayer!.visionRange!.max!;
          } else {
            return maxAttackRange!;
          }
      }

      return 0.0;
    }

    double setMinAttackRange(String mode) {
      switch (mode) {
        case 'walk':
          return 0;

        case 'wait':
          return 0;

        case 'menu':
          return 0;

        case 'attack':
          return minAttackRange!;
      }

      return 0.0;
    }

    return CustomPaint(
      painter: AttackArea(
        minRange: setMinAttackRange(user.playerMode!),
        maxRange: setMaxAttackRange(user.playerMode!),
      ),
      child: SizedBox(
        width: setMaxAttackRange(user.playerMode!),
        height: setMaxAttackRange(user.playerMode!),
      ),
    );
  }
}

class AttackArea extends CustomPainter {
  double? minRange;
  double? maxRange;

  AttackArea({double? minRange, double? maxRange}) {
    this.minRange = minRange;
    this.maxRange = maxRange;
  }

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(maxRange! / 2, maxRange! / 2);

    final fillColor = Paint()
      ..color = Color.fromRGBO(200, 25, 25, 1).withAlpha(35);

    canvas.drawPath(
      Path.combine(
        PathOperation.difference,
        Path()
          ..addOval(
              Rect.fromCircle(center: center, radius: maxRange! / 2 + 0.02)),
        Path()
          ..addOval(
              Rect.fromCircle(center: center, radius: minRange! / 2 + 0.01))
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
              Rect.fromCircle(center: center, radius: maxRange! / 2 + 0.02)),
        Path()
          ..addOval(
              Rect.fromCircle(center: center, radius: minRange! / 2 + 0.01))
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
  double? walkRange;
  WalkRange({
    Key? key,
    @required this.walkRange,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    UIColor _uiColor = UIColor();
    double? setWalkRange(String mode) {
      if (user.selectedPlayer!.life!.isDead()) {
        return 0.0;
      }

      switch (mode) {
        case 'walk':
          return walkRange!;

        case 'wait':
          return 6;

        case 'menu':
          return 6;

        case 'attack':
          return 0.0;
      }
    }

    return AnimatedContainer(
      curve: Curves.fastLinearToSlowEaseIn,
      duration: Duration(milliseconds: 250),
      width: setWalkRange(user.playerMode!),
      height: setWalkRange(user.playerMode!),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: _uiColor
            .setUIColor(user.selectedPlayerID, 'shadow')
            .withAlpha(75 - walkRange!.floor()),
        border: Border.all(
          color: _uiColor.setUIColor(user.selectedPlayerID, 'rangeOutline'),
          width: 0.3,
        ),
      ),
    );
  }
}

// ignore: must_be_immutable
class PlayerSpriteVisionRange extends StatelessWidget {
  PlayerVisionRange? visionRange;
  PlayerSpriteVisionRange({Key? key, @required this.visionRange})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    UIColor _uiColor = UIColor();

    double? setVisionRange(String? mode) {
      switch (mode) {
        case 'walk':
          return visionRange!.max;

        case 'wait':
          return visionRange!.max;

        case 'menu':
          return 6;

        case 'attack':
          return 0.0;
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
          color: _uiColor.setUIColor(user.selectedPlayer!.id, 'rangeOutline'),
          width: 0.3,
        ),
      ),
    );
  }
}
