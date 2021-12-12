import 'package:dsixv02app/models/game.dart';
import 'package:dsixv02app/models/player.dart';
import 'package:dsixv02app/models/turnOrder.dart';
import 'package:dsixv02app/models/user.dart';
import 'package:dsixv02app/pages/shared/widgets/uiColor.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:rive/rive.dart';
import 'package:transparent_pointer/transparent_pointer.dart';
import 'spriteImage.dart';

// ignore: must_be_immutable
class PlayerSprite extends StatefulWidget {
  Function() refresh;
  PlayerTemporaryLocation temporaryLocation;
  Player player;
  PlayerSprite({
    Key key,
    this.refresh,
    @required this.temporaryLocation,
    @required this.player,
  }) : super(key: key);

  @override
  State<PlayerSprite> createState() => _PlayerSpriteState();
}

class _PlayerSpriteState extends State<PlayerSprite> {
  PlayerController playerController = PlayerController();

  Artboard _artboard;

  @override
  void initState() {
    _loadRiverFile();
    super.initState();
  }

  void _loadRiverFile() async {
    final bytes = await rootBundle.load('assets/animation/damage.riv');
    final file = RiveFile.import(bytes);
    setState(() {
      _artboard = file.mainArtboard;
      _offAnimation();
    });
  }

  _offAnimation() {
    _artboard.addController(SimpleAnimation('off'));
  }

  _playDamageAnimation(int damage) {
    _artboard.addController(OneShotAnimation(
      '$damage',
    ));
  }

  void updatePlayerLife(Player player, User user) {
    if (player.life != widget.player.life) {
      int damage = widget.player.life - player.life;
      _playDamageAnimation(damage);
      user.updateSelectedPlayer(player);
    }
  }

  @override
  Widget build(BuildContext context) {
    final game = Provider.of<Game>(context);
    final players = Provider.of<List<Player>>(context);
    final turnManager = Provider.of<TurnManager>(context);
    final turnOrder = Provider.of<List<Turn>>(context);
    final user = Provider.of<User>(context);

    updatePlayerLife(players[user.selectedPlayerIndex], user);

    return Positioned(
      left: playerController
          .calculateSpritePosition(
              widget.temporaryLocation, widget.player.visionRange)
          .dx,
      top: playerController
          .calculateSpritePosition(
              widget.temporaryLocation, widget.player.visionRange)
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
                  walkRange: playerController.calculateWalkedDistance(
                      widget.temporaryLocation,
                      widget.player.getLocation(),
                      widget.player.walkRange),
                ),
              ),
              Align(
                alignment: Alignment.center,
                child: AttackRange(
                  attackRange: widget.player.attackRange,
                ),
              ),
              Align(
                alignment: Alignment.center,
                child: GestureDetector(
                    onTap: () {
                      user.openOrCloseMenu(
                          turnOrder.first.isPlayerTurn(user.selectedPlayer.id));
                      widget.refresh();
                    },
                    onPanUpdate: (details) {
                      playerController.walk(
                          widget.temporaryLocation,
                          widget.player.getLocation(),
                          Offset(details.delta.dx, details.delta.dy),
                          widget.player.walkRange,
                          user.playerMode);
                    },
                    onPanEnd: (details) {
                      playerController.endWalk(
                        user,
                        widget.temporaryLocation,
                      );

                      turnManager.takeTurn(game, players, turnOrder, user);

                      widget.refresh();
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 12),
                      child: (players[user.selectedPlayerIndex].life < 1)
                          ? SpriteImage(image: 'grave')
                          : SpriteImage(image: widget.player.race),
                    )),
              ),
              Align(
                alignment: Alignment.center,
                child: TransparentPointer(
                  transparent: true,
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 25),
                    child: (_artboard != null)
                        ? SizedBox(
                            width: 10,
                            height: 20,
                            child: Rive(
                              artboard: _artboard,
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

class PlayerController {
  Offset calculateSpritePosition(
      PlayerTemporaryLocation temporaryLocation, double visionRange) {
    return Offset(temporaryLocation.dx - visionRange / 2,
        temporaryLocation.dy - visionRange / 2);
  }

  double calculateWalkedDistance(PlayerTemporaryLocation temporaryLocation,
      playerLocation, double walkRange) {
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

  void walk(PlayerTemporaryLocation temporaryLocation, Offset playerLocation,
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
    PlayerTemporaryLocation temporaryLocation,
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
  double attackRange;
  AttackRange({
    Key key,
    @required this.attackRange,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    double setAttackRange(String mode) {
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
          return attackRange;
          break;
      }

      return 0.0;
    }

    return AnimatedContainer(
      curve: Curves.fastLinearToSlowEaseIn,
      duration: Duration(milliseconds: 250),
      width: setAttackRange(user.playerMode),
      height: setAttackRange(user.playerMode),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Color.fromRGBO(200, 25, 25, 1).withAlpha(35),
        border: Border.all(
          color: Color.fromRGBO(200, 25, 25, 1).withAlpha(125),
          width: 0.3,
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
