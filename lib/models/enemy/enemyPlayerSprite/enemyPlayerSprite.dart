import 'package:dsixv02app/models/game/game.dart';
import 'package:dsixv02app/models/player/player.dart';
import 'package:dsixv02app/shared/app_Exceptions.dart';
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
  final Player? player;
  EnemyPlayerSprite({
    Key? key,
    @required this.enemyPlayer,
    @required this.player,
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
    final game = Provider.of<Game>(context);

    _enemyController.updateAnimationCounter(widget.enemyPlayer!);
    _enemyController.playDamageAnimation(widget.enemyPlayer!);

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
                  if (widget.player!.mode! != 'attack') {
                    return;
                  }

                  if (widget.player!
                      .cantAttack(widget.enemyPlayer!.location!)) {
                    return;
                  }

                  try {
                    widget.enemyPlayer!
                        .receiveAnAttack(widget.player!.attack());
                  } on PlayerIsDeadException {
                    game.round!.removeDeadPlayer(widget.enemyPlayer!);
                  }
                  game.round!.takeTurn(game.id!, widget.player!);
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

  int? damageAnimationCounter;
  void updateAnimationCounter(Player enemyPlayer) {
    if (damageAnimationCounter == null) {
      this.damageAnimationCounter = enemyPlayer.animation!.damage!.length;
    }
  }

  playDamageAnimation(Player enemyPlayer) {
    if (enemyPlayer.animation!.damage!.length == damageAnimationCounter!) {
      return;
    }
    artboard!.addController(OneShotAnimation(
      '${enemyPlayer.animation!.damage!.last}',
    ));

    damageAnimationCounter = enemyPlayer.animation!.damage!.length;
  }
}
