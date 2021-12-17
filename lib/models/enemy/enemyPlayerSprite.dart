import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:dsixv02app/models/gameController.dart';
import 'package:dsixv02app/models/player/player.dart';
import 'package:dsixv02app/models/turnOrder/turn.dart';
import 'package:dsixv02app/models/player/user.dart';
import 'package:dsixv02app/models/turnOrder/turnController.dart';
import 'package:dsixv02app/shared/widgets/uiColor.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:rive/rive.dart';
import 'package:transparent_pointer/transparent_pointer.dart';
import '../player/playerSpriteImage.dart';

// ignore: must_be_immutable
class EnemyPlayerSprite extends StatefulWidget {
  String enemyID;
  double dx;
  double dy;
  String race;
  double vision;
  int life;
  EnemyPlayerSprite(
      {Key key,
      this.enemyID,
      this.dx,
      this.dy,
      this.race,
      this.vision,
      this.life})
      : super(key: key);

  @override
  State<EnemyPlayerSprite> createState() => _EnemyPlayerSpriteState();
}

class _EnemyPlayerSpriteState extends State<EnemyPlayerSprite> {
  UIColor _uiColor = UIColor();
  EnemyPlayerSpriteController _enemyController = EnemyPlayerSpriteController();

  @override
  void initState() {
    setState(() {
      _enemyController.loadRiverFile();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    final turnController = Provider.of<TurnController>(context);
    final turnOrder = Provider.of<List<Turn>>(context);
    final gameController = Provider.of<GameController>(context);
    final players = Provider.of<List<Player>>(context);

    _enemyController.updateEnemyLife(
        _enemyController.getEnemyPlayer(players, widget.enemyID), widget.life);

    return Positioned(
      left: widget.dx - widget.vision / 2,
      top: widget.dy - widget.vision / 2,
      child: SizedBox(
        width: widget.vision,
        height: widget.vision,
        child: Stack(
          children: [
            TransparentPointer(
              transparent: true,
              child: (widget.life < 1)
                  ? Container()
                  : DottedBorder(
                      dashPattern: [2, 2],
                      borderType: BorderType.Circle,
                      color: _uiColor
                          .setUIColor(widget.enemyID, 'rangeOutline')
                          .withAlpha(150),
                      strokeWidth: 0.3,
                      child: SizedBox(
                        width: widget.vision,
                        height: widget.vision,
                      ),
                    ),
            ),
            Align(
              alignment: Alignment.center,
              child: Container(
                width: 6,
                height: 6,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: _uiColor.setUIColor(widget.enemyID, 'shadow'),
                  border: Border.all(
                    color: _uiColor.setUIColor(widget.enemyID, 'rangeOutline'),
                    width: 0.3,
                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment.center,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 14),
                child: (widget.life < 1)
                    ? TransparentPointer(
                        child: PlayerSpriteImage(image: 'grave'))
                    : GestureDetector(
                        onTap: () {
                          switch (user.playerMode) {
                            case 'attack':
                              if (players[user.selectedPlayerIndex]
                                  .cantAttack(Offset(widget.dx, widget.dy))) {
                                return;
                              }

                              _enemyController.takeDamage(
                                  players[user.selectedPlayerIndex],
                                  _enemyController.getEnemyPlayer(
                                      players, widget.enemyID));

                              turnController.takeTurn(
                                  gameController, players, turnOrder, user);

                              user.setPlayerModeBasedOnPlayerTurn(
                                  turnController.isPlayerTurn(
                                      turnOrder, user.selectedPlayer.id));

                              break;
                          }
                          setState(() {});
                        },
                        child: PlayerSpriteImage(image: widget.race),
                      ),
              ),
            ),
            Align(
              alignment: Alignment.center,
              child: TransparentPointer(
                transparent: true,
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 25),
                  child: (_enemyController.artboard != null)
                      ? SizedBox(
                          width: 10,
                          height: 20,
                          child: Rive(
                            artboard: _enemyController.artboard,
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
    );
  }
}

class EnemyPlayerSpriteController {
  final db = FirebaseFirestore.instance;
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

  // ignore: missing_return
  Player getEnemyPlayer(List<Player> players, String enemyID) {
    Player enemyPlayer;

    players.forEach((player) {
      if (player.id == enemyID) {
        enemyPlayer = player;
      }
    });
    return enemyPlayer;
  }

  void updateEnemyLife(Player enemyPlayer, int localLife) {
    if (enemyPlayer.life != localLife) {
      int damage = localLife - enemyPlayer.life;
      playDamageAnimation(damage);
    }
  }

  void takeDamage(Player selectedPlayer, Player enemy) {
    int damage = enemy.takeDamage(selectedPlayer.damageDiceRoll(),
        selectedPlayer.pDamage, selectedPlayer.mDamage);
    playDamageAnimation(damage);
  }
}
