import 'package:dsixv02app/models/game/game.dart';
import 'package:dsixv02app/models/player/player.dart';
import 'package:dsixv02app/models/player/user.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:rive/rive.dart';
import 'package:transparent_pointer/transparent_pointer.dart';
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
    final game = Provider.of<Game>(context);
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
                  if (user.playerMode != 'attack') {
                    return;
                  }
                  _enemyController.receiveAnAttack(
                      game, user.selectedPlayer!, widget.enemyPlayer!);

                  user.setPlayerMode();
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
                  tempArmor: widget.enemyPlayer!.equipment!.armor!.tempArmor,
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

  void receiveAnAttack(Game game, Player player, Player enemyPlayer) {
    if (player.equipment!.attackRange!.canAttack(enemyPlayer.location!,
            player.location!, player.equipment!.rangedAttack()) ==
        false) {
      return;
    }

    player.action!.takeAction(
      game.id!,
      player.id!,
    );

    if (player.action!.outOfActions()) {
      game.round!.passTurn(game.id!, player.id!);
    }

    takeDamage(game, player, enemyPlayer);
  }

  void takeDamage(Game game, Player player, Player enemy) {
    int attackDamage = player.attack();
    int itemDamage =
        player.equipment!.damage!.pDamage! + player.equipment!.damage!.mDamage!;
    int totalAttackDamage = attackDamage + itemDamage;

    enemy.takeDamage(game.id!, attackDamage, player.equipment!.damage!.pDamage,
        player.equipment!.damage!.mDamage);

    if (enemy.life!.isDead()) {
      game.round!.removeDeadPlayer(game.id!, enemy.id!);
    }

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
