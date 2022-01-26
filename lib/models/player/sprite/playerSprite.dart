import 'package:dsixv02app/models/game/game.dart';
import 'package:dsixv02app/shared/app_Exceptions.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:rive/rive.dart';
import 'package:transparent_pointer/transparent_pointer.dart';
import '../player.dart';
import 'playerSpriteAttackRange.dart';
import 'playerSpriteImage.dart';
import 'playerSpriteTempEffects.dart';
import 'playerSpriteVisionRange.dart';
import 'playerSpriteWalkRange.dart';
import '../playerTempLocation.dart';

//  ignore: must_be_immutable
class PlayerSprite extends StatefulWidget {
  final Function()? refresh;
  Player? player;
  PlayerTempLocation? tempLocation;
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
  PlayerSpriteController _playerSpriteController = PlayerSpriteController();

  @override
  void initState() {
    _playerSpriteController.loadRiverFile();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final game = Provider.of<Game>(context);

    _playerSpriteController.updateAnimationCounter(widget.player!);
    _playerSpriteController.playDamageAnimation(widget.player!);

    return Positioned(
      left: _playerSpriteController
          .calculateSpritePosition(
              widget.tempLocation, widget.player!.vision!.getRange())
          .dx,
      top: _playerSpriteController
          .calculateSpritePosition(
              widget.tempLocation, widget.player!.vision!.getRange())
          .dy,
      child: TransparentPointer(
        transparent: true,
        child: SizedBox(
          width: widget.player!.vision!.getRange(),
          height: widget.player!.vision!.getRange(),
          child: Stack(
            children: [
              //VISION RANGE
              Align(
                  alignment: Alignment.center,
                  child: PlayerSpriteVisionRange(
                    player: widget.player,
                  )),
              //WALK RANGE
              Align(
                alignment: Alignment.center,
                child: WalkRange(
                  tempLocation: widget.tempLocation,
                  oldLocation: widget.player!.location,
                  maxWalkRange: widget.player!.walkRange!.max,
                  heightMap: game.map!.heightMap,
                  player: widget.player,
                ),
              ),

              //ATTACK RANGE
              Align(
                alignment: Alignment.center,
                child: AttackRange(
                  player: widget.player,
                ),
              ),

              //IMAGE
              Align(
                alignment: Alignment.center,
                child: PlayerSpriteImage(
                    image: widget.player!.race,
                    isDead: widget.player!.life!.isDead()),
              ),

              //HITBOX CONTROLLER
              Align(
                alignment: Alignment.center,
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 9),
                  child: Container(
                    width: 6,
                    height: 10,
                    child: (widget.player!.mode == 'menu' ||
                            widget.player!.mode == 'dead')
                        ? GestureDetector(
                            onTap: () {
                              widget.player!.menuMode();
                              widget.refresh!();
                            },
                          )
                        : GestureDetector(
                            onTap: () {
                              widget.player!.menuMode();
                              widget.refresh!();
                            },
                            onPanUpdate: (details) {
                              if (widget.player!.action!.outOfActions()) {
                                return;
                              }
                              widget.tempLocation!.walk(
                                  details.delta.dx,
                                  details.delta.dy,
                                  game.map!.heightMap!,
                                  widget.player!.walkRange!.max!);
                            },
                            onPanEnd: (details) {
                              try {
                                widget.player!.endWalk(
                                  widget.tempLocation!,
                                  game.map!.tallGrass!,
                                  game.map!.heightMap!,
                                );
                              } on CantPassException {
                                widget.tempLocation!.updatePlayerLocation(
                                    widget.player!.location!);
                                widget.refresh!();
                                return;
                              }
                              game.round!.takeTurn(game.id!, widget.player!);
                            },
                          ),
                  ),
                ),
              ),

              //TEMP EFFECTS
              Align(
                  alignment: Alignment.center,
                  child: PlayerSpriteTempEffects(
                    tempArmor: widget.player!.equipment!.armor!.tempArmor,
                  )),
              //DAMAGE ANIMATION
              Align(
                alignment: Alignment.center,
                child: TransparentPointer(
                  transparent: true,
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 25),
                    child: (_playerSpriteController.artboard != null)
                        ? SizedBox(
                            width: 10,
                            height: 20,
                            child: Rive(
                              artboard: _playerSpriteController.artboard!,
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

  int? damageAnimationCounter;
  void updateAnimationCounter(Player player) {
    if (damageAnimationCounter == null) {
      this.damageAnimationCounter = player.animation!.damage!.length;
    }
  }

  playDamageAnimation(Player player) {
    if (player.animation!.damage!.length == damageAnimationCounter!) {
      return;
    }
    artboard!.addController(OneShotAnimation(
      '${player.animation!.damage!.last}',
    ));

    damageAnimationCounter = player.animation!.damage!.length;
  }

  Offset calculateSpritePosition(
      PlayerTempLocation? location, double? visionRange) {
    return Offset(location!.newLocation!.dx - visionRange! / 2,
        location.newLocation!.dy - visionRange / 2);
  }
}
