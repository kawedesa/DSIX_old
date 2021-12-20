import 'package:dotted_border/dotted_border.dart';
import 'package:dsixv02app/models/player/player.dart';
import 'package:dsixv02app/models/turnOrder/turn.dart';
import 'package:dsixv02app/models/player/user.dart';
import 'package:dsixv02app/models/turnOrder/turnController.dart';
import 'package:dsixv02app/shared/app_Exceptions.dart';
import 'package:dsixv02app/shared/app_Icons.dart';
import 'package:dsixv02app/shared/widgets/uiColor.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:rive/rive.dart';
import 'package:transparent_pointer/transparent_pointer.dart';
import '../player/playerSpriteImage.dart';

class EnemyPlayerSprite extends StatefulWidget {
  final Player enemyPlayer;

  EnemyPlayerSprite({
    Key key,
    this.enemyPlayer,
  }) : super(key: key);

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
    final players = Provider.of<List<Player>>(context);

    _enemyController.checkEnemyPlayer(players, widget.enemyPlayer);

    return Positioned(
      left: widget.enemyPlayer.dx - widget.enemyPlayer.visionRange / 2,
      top: widget.enemyPlayer.dy - widget.enemyPlayer.visionRange / 2,
      child: SizedBox(
        width: widget.enemyPlayer.visionRange,
        height: widget.enemyPlayer.visionRange,
        child: Stack(
          children: [
            //VISION RANGE
            TransparentPointer(
              transparent: true,
              child: (widget.enemyPlayer.life < 1)
                  ? Container()
                  : DottedBorder(
                      dashPattern: [2, 2],
                      borderType: BorderType.Circle,
                      color: _uiColor
                          .setUIColor(widget.enemyPlayer.id, 'rangeOutline')
                          .withAlpha(150),
                      strokeWidth: 0.3,
                      child: SizedBox(
                        width: widget.enemyPlayer.visionRange,
                        height: widget.enemyPlayer.visionRange,
                      ),
                    ),
            ),
            //SHADOW
            Align(
              alignment: Alignment.center,
              child: Container(
                width: 6,
                height: 6,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: _uiColor.setUIColor(widget.enemyPlayer.id, 'shadow'),
                  border: Border.all(
                    color: _uiColor.setUIColor(
                        widget.enemyPlayer.id, 'rangeOutline'),
                    width: 0.3,
                  ),
                ),
              ),
            ),
            //IMAGE
            Align(
              alignment: Alignment.center,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 14),
                child: (widget.enemyPlayer.life < 1)
                    ? TransparentPointer(
                        child: PlayerSpriteImage(image: 'grave'))
                    : GestureDetector(
                        onTap: () {
                          if (user.playerMode != 'attack') {
                            return;
                          }

                          if (players[user.selectedPlayerIndex].cantAttack(
                              Offset(widget.enemyPlayer.dx,
                                  widget.enemyPlayer.dy))) {
                            return;
                          }

                          _enemyController.takeDamage(
                              players[user.selectedPlayerIndex],
                              widget.enemyPlayer);

                          try {
                            turnController.takeTurn(turnOrder);
                          } on PlayerTurnException {
                            user.walkMode();
                          } on NotPlayerTurnException {
                            user.endPlayerTurn();
                          }

                          setState(() {});
                        },
                        child:
                            PlayerSpriteImage(image: widget.enemyPlayer.race),
                      ),
              ),
            ),

            //  TEMP EFFECTS
            Align(
              alignment: Alignment.center,
              child: TransparentPointer(
                transparent: true,
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 26),
                  child: AnimatedContainer(
                    duration: Duration(milliseconds: 250),
                    width: (widget.enemyPlayer.tempArmor > 0) ? 3 : 0,
                    height: (widget.enemyPlayer.tempArmor > 0) ? 3 : 0,
                    child: SvgPicture.asset(
                      AppIcons.tempArmor,
                      color: Color.fromRGBO(250, 50, 10, 1),
                    ),
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
            ),
          ],
        ),
      ),
    );
  }
}

class EnemyPlayerSpriteController {
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

  void checkEnemyPlayer(List<Player> players, Player enemyPlayer) {
    players.forEach((player) {
      if (player.id != enemyPlayer.id) {
        return;
      }
      checkTempArmor(player.tempArmor, enemyPlayer.tempArmor);
      checkLife(player.life, enemyPlayer.life);
      enemyPlayer = player;
    });
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

  void takeDamage(Player selectedPlayer, Player enemy) {
    int attackDamage = selectedPlayer.attack();
    int itemDamage = selectedPlayer.pDamage + selectedPlayer.mDamage;
    int totalAttackDamage = attackDamage + itemDamage;

    enemy.takeDamage(
        attackDamage, selectedPlayer.pDamage, selectedPlayer.mDamage);

    playDamageAnimation(totalAttackDamage);
  }
}
