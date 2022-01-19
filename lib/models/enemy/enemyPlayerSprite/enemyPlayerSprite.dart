import 'package:dsixv02app/models/player/player.dart';
import 'package:dsixv02app/models/player/user.dart';
import 'package:dsixv02app/models/turn/turnController.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:rive/rive.dart';
import 'package:transparent_pointer/transparent_pointer.dart';
import '../../game/gameController.dart';
import '../../player/sprite/playerSpriteImage.dart';
import 'enemyPlayerSpriteHitBox.dart';
import 'enemyPlayerSpriteShadow.dart';
import 'enemyPlayerSpriteTempEffects.dart';
import 'enemyPlayerSpriteVisionRange.dart';

class EnemyPlayerSprite extends StatefulWidget {
  final Player? enemyPlayer;

  EnemyPlayerSprite({
    Key? key,
    this.enemyPlayer,
  }) : super(key: key);

  @override
  State<EnemyPlayerSprite> createState() => _EnemyPlayerSpriteState();
}

class _EnemyPlayerSpriteState extends State<EnemyPlayerSprite> {
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
    final gameController = Provider.of<GameController>(context);
    // final turnController = Provider.of<TurnController>(context);
    final players = Provider.of<List<Player>>(context);

    _enemyController.checkEnemyPlayer(players, widget.enemyPlayer!);

    return Positioned(
      left: widget.enemyPlayer!.location!.dx! -
          widget.enemyPlayer!.vision!.getRange() / 2,
      top: widget.enemyPlayer!.location!.dy! -
          widget.enemyPlayer!.vision!.getRange() / 2,
      child: SizedBox(
        width: widget.enemyPlayer!.vision!.getRange(),
        height: widget.enemyPlayer!.vision!.getRange(),
        child: Stack(
          children: [
            //VISION RANGE
            Align(
              alignment: Alignment.center,
              child: EnemyPlayerSpriteVisionRange(
                enemyID: widget.enemyPlayer!.id,
                visionRange: widget.enemyPlayer!.vision!.getRange(),
                isDead: widget.enemyPlayer!.life!.isDead(),
              ),
            ),
            //SHADOW
            Align(
              alignment: Alignment.center,
              child: EnemyPlayerSpriteShadow(
                enemyID: widget.enemyPlayer!.id,
                isDead: widget.enemyPlayer!.life!.isDead(),
              ),
            ),
            //HITBOX
            Align(
              alignment: Alignment.center,
              child: EnemyPlayerSpriteHitBox(
                isDead: widget.enemyPlayer!.life!.isDead(),
                onTap: () async {
                  // _enemyController.receiveAnAttack(gameController,
                  //     turnController, user, widget.enemyPlayer!);
                },
              ),
            ),
            //IMAGE
            Align(
              alignment: Alignment.center,
              child: PlayerSpriteImage(
                  image: widget.enemyPlayer!.race,
                  isDead: widget.enemyPlayer!.life!.isDead()),
            ),

            //  TEMP EFFECTS
            Align(
                alignment: Alignment.center,
                child: EnemySpriteTempEffects(
                  tempArmor: widget.enemyPlayer!.armor!.tempArmor,
                )),

            //DAMAGE ANIMATION
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
                            artboard: _enemyController.artboard!,
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
    );
  }
}

class EnemyPlayerSpriteController {
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

  void receiveAnAttack(GameController gameController,
      TurnController turnController, User user, Player enemyPlayer) {
    if (user.playerMode != 'attack') {
      return;
    }

    if (user.selectedPlayer!.attackRange!.canAttack(
            enemyPlayer.location!,
            user.selectedPlayer!.location!,
            user.selectedPlayer!.iventory!.rangedAttack()) ==
        false) {
      return;
    }

    takeDamage(gameController.gameID, user.selectedPlayer!, enemyPlayer);

    user.selectedPlayer!.action!.takeAction(
      gameController.gameID,
      user.selectedPlayer!.id!,
    );

    if (user.selectedPlayer!.action!.outOfActions()) {
      turnController.passTurnWhere(
          gameController.gameID, user.selectedPlayerID!);
    } else {
      user.openCloseMenu();
    }
  }

  void takeDamage(String gameID, Player selectedPlayer, Player enemy) {
    int attackDamage = selectedPlayer.attack();
    int itemDamage =
        selectedPlayer.damage!.pDamage! + selectedPlayer.damage!.mDamage!;
    int totalAttackDamage = attackDamage + itemDamage;

    enemy.takeDamage(gameID, attackDamage, selectedPlayer.damage!.pDamage,
        selectedPlayer.damage!.mDamage);

    playDamageAnimation(totalAttackDamage);
  }

  void checkEnemyPlayer(List<Player> players, Player enemyPlayer) {
    players.forEach((player) {
      if (player.id != enemyPlayer.id) {
        return;
      }
      checkLife(player.life!.current!, enemyPlayer.life!.current);
      enemyPlayer = player;
    });
  }

  void checkLife(int newLife, oldLife) {
    if (oldLife != newLife) {
      int damage = oldLife - newLife;
      playDamageAnimation(damage);
    }
  }
}
