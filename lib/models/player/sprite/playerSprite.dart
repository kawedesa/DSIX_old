import 'package:dsixv02app/models/game/game.dart';
import 'package:dsixv02app/models/game/gameController.dart';
import 'package:dsixv02app/models/player/user.dart';
import 'package:dsixv02app/models/turn/turnController.dart';
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
import 'playerTempLocation.dart';

//  ignore: must_be_immutable
class PlayerSprite extends StatefulWidget {
  final Function()? refresh;
  PlayerTempLocation? tempLocation;
  PlayerSprite({
    Key? key,
    @required this.refresh,
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

    try {
      playerSpriteController.updatePlayer(
          players[user.selectedPlayer!.index!], user.selectedPlayer!);
    } on UpdatePlayerException {
      user.updateSelectedPlayer(players[user.selectedPlayer!.index!]);
    }

    return Positioned(
      left: playerSpriteController
          .calculateSpritePosition(
              widget.tempLocation, user.selectedPlayer!.vision!.getRange())
          .dx,
      top: playerSpriteController
          .calculateSpritePosition(
              widget.tempLocation, user.selectedPlayer!.vision!.getRange())
          .dy,
      child: TransparentPointer(
        transparent: true,
        child: SizedBox(
          width: user.selectedPlayer!.vision!.getRange(),
          height: user.selectedPlayer!.vision!.getRange(),
          child: Stack(
            children: [
              //VISION RANGE
              Align(
                  alignment: Alignment.center,
                  child: PlayerSpriteVisionRange()),
              //WALK RANGE
              Align(
                alignment: Alignment.center,
                child: WalkRange(
                  tempLocation: widget.tempLocation,
                  oldLocation: user.selectedPlayer!.location,
                  maxWalkRange: user.selectedPlayer!.walkRange!.max,
                  heightMap: game.map!.heightMap,
                ),
              ),

              //ATTACK RANGE
              Align(
                alignment: Alignment.center,
                child: AttackRange(),
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
                              if (widget.tempLocation!.distanceLeftOver(
                                      user.selectedPlayer!.location!,
                                      user.selectedPlayer!.walkRange!.max!)! <=
                                  0) {
                                return;
                              }

                              widget.tempLocation!.walk(details.delta.dx,
                                  details.delta.dy, game.map!.heightMap!);
                            },
                            onPanEnd: (details) {
                              try {
                                user.selectedPlayer!.location!.endWalk(
                                  game.id!,
                                  user.selectedPlayer!.index!.toString(),
                                  widget.tempLocation!,
                                  game.map!.tallGrass!,
                                  game.map!.heightMap!,
                                );
                              } on CantPassException {
                                widget.tempLocation!.updatePlayerLocation(
                                    user.selectedPlayer!.location!);
                                widget.refresh!();
                                return;
                              }

                              user.selectedPlayer!.action!.takeAction(
                                game.id!,
                                user.selectedPlayer!.index!.toString(),
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
                    image: user.selectedPlayer!.race,
                    isDead: user.selectedPlayer!.life!.isDead()),
              ),

              //TEMP EFFECTS
              Align(
                  alignment: Alignment.center,
                  child: PlayerSpriteTempEffects(
                    tempArmor: user.selectedPlayer!.armor!.tempArmor,
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

  void updatePlayer(
    Player newPlayer,
    Player selectedPlayeruser,
  ) {
    if (checkTempArmor(newPlayer.armor!.tempArmor!,
            selectedPlayeruser.armor!.tempArmor!) ||
        checkLife(
            newPlayer.life!.current!, selectedPlayeruser.life!.current!)) {
      throw UpdatePlayerException();
    }
  }

  bool checkTempArmor(int newArmor, oldArmor) {
    if (oldArmor != newArmor) {
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
}
