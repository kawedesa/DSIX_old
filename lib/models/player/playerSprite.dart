import 'package:dsixv02app/models/game/game.dart';
import 'package:dsixv02app/models/game/gameController.dart';
import 'package:dsixv02app/models/player/user.dart';
import 'package:dsixv02app/models/turn/turnController.dart';
import 'package:dsixv02app/shared/app_Colors.dart';
import 'package:dsixv02app/shared/app_Icons.dart';
import 'package:dsixv02app/shared/widgets/uiColor.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:rive/rive.dart';
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

  @override
  void initState() {
    playerSpriteController.loadRiverFile();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final players = Provider.of<List<Player>>(context);
    final turnController = Provider.of<TurnController>(context);
    final gameController = Provider.of<GameController>(context);
    final game = Provider.of<Game>(context);
    final user = Provider.of<User>(context);

    playerSpriteController.updatePlayer(
        players[user.selectedPlayer!.index!], user);

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
                                  game.id!,
                                  PlayerLocation(
                                      dx: widget.tempLocation!.dx,
                                      dy: widget.tempLocation!.dy),
                                  game.map!.tallGrass!);

                              user.takeAction(
                                game.id!,
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
                child: PlayerSpriteImage(
                    image: widget.player!.race,
                    isDead: widget.player!.life!.isDead()),
              ),

              //TEMP EFFECTS
              Align(
                  alignment: Alignment.center,
                  child: PlayerSpriteTempEffects(
                    tempArmor: widget.player!.tempArmor,
                  )),
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
                              artboard: playerSpriteController.artboard!,
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
  Artboard? artboard;

  void loadRiverFile() async {
    final bytes = await rootBundle.load('assets/animation/damage.riv');
    final file = RiveFile.import(bytes);

    artboard = file.mainArtboard;
    offAnimation();
  }

  offAnimation() {
    artboard!.addController(SimpleAnimation('off'));
  }

  playDamageAnimation(int damage) {
    artboard!.addController(OneShotAnimation(
      '$damage',
    ));
  }

  void updatePlayer(Player player, User user) {
    if (checkTempArmor(player.tempArmor!, user.selectedPlayer!.tempArmor!) ||
        checkLife(player.life!.current!, user.selectedPlayer!.life!.current!)) {
      user.updateSelectedPlayer(player);
    }
  }

  bool checkTempArmor(int newArmor, oldArmor) {
    if (oldArmor != newArmor) {
      int damage = oldArmor - newArmor;
      playDamageAnimation(damage);
      return true;
    }
    return false;
  }

  bool checkLife(int newLife, oldLife) {
    if (oldLife != newLife) {
      int damage = oldLife - newLife;
      playDamageAnimation(damage);
      return true;
    }
    return false;
  }

  Offset calculateSpritePosition(
      PlayerTempLocation? location, double? visionRange) {
    return Offset(
        location!.dx! - visionRange! / 2, location.dy! - visionRange / 2);
  }

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

    final fillColor = Paint()..color = AppColors.attackRangeArea;

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
      ..color = AppColors.attackRangeOutline
      ..strokeWidth = 0.5
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

// ignore: must_be_immutable
class PlayerSpriteTempEffects extends StatelessWidget {
  int? tempArmor;
  PlayerSpriteTempEffects({Key? key, @required this.tempArmor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TransparentPointer(
      transparent: true,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 28),
        child: AnimatedContainer(
          duration: Duration(milliseconds: 250),
          width: (tempArmor! > 0) ? 5 : 0,
          height: (tempArmor! > 0) ? 5 : 0,
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
                  '$tempArmor',
                  style: TextStyle(
                    letterSpacing: 1,
                    fontFamily: 'Santana',
                    color: AppColors.goodEffectText,
                  ),
                ),
              )),
            ),
          ]),
        ),
      ),
    );
  }
}
