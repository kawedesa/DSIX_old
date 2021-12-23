import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:dsixv02app/models/player/player.dart';
import 'package:dsixv02app/models/turn.dart';
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
import '../gameController.dart';
import '../player/playerSpriteImage.dart';

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

    final turnController = Provider.of<TurnController>(context);
    // final turnOrder = Provider.of<List<Turn>>(context);
    final players = Provider.of<List<Player>>(context);

    // _enemyController.checkEnemyPlayer(players, widget.enemyPlayer);

    return Positioned(
      left: widget.enemyPlayer!.location!.dx! -
          widget.enemyPlayer!.visionRange!.max! / 2,
      top: widget.enemyPlayer!.location!.dy! -
          widget.enemyPlayer!.visionRange!.max! / 2,
      child: SizedBox(
        width: widget.enemyPlayer!.visionRange!.max,
        height: widget.enemyPlayer!.visionRange!.max,
        child: Stack(
          children: [
            //VISION RANGE
            Align(
              alignment: Alignment.center,
              child: EnemySpriteVisionRange(
                enemyID: widget.enemyPlayer!.id,
                visionRange: widget.enemyPlayer!.visionRange!.max,
                isDead: widget.enemyPlayer!.life!.isDead(),
              ),
            ),
            //SHADOW
            Align(
              alignment: Alignment.center,
              child: EnemySpriteShadow(
                enemyID: widget.enemyPlayer!.id,
                isDead: widget.enemyPlayer!.life!.isDead(),
              ),
            ),
            //HITBOX
            Align(
              alignment: Alignment.center,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 9),
                child: (widget.enemyPlayer!.life!.isDead())
                    ? SizedBox()
                    : Container(
                        width: 5,
                        height: 10,
                        child: GestureDetector(onTap: () {
                          _enemyController.receiveAnAttack(gameController,
                              turnController, user, widget.enemyPlayer!);
                        }),
                      ),
              ),
            ),
            //IMAGE
            Align(
              alignment: Alignment.center,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 14),
                child: TransparentPointer(
                  child: PlayerSpriteImage(
                      image: widget.enemyPlayer!.race,
                      isDead: widget.enemyPlayer!.life!.isDead()),
                ),
              ),
            ),

            // //  TEMP EFFECTS
            // Align(
            //   alignment: Alignment.center,
            //   child: TransparentPointer(
            //     transparent: true,
            //     child: Padding(
            //       padding: const EdgeInsets.only(bottom: 26),
            //       child: AnimatedContainer(
            //         duration: Duration(milliseconds: 250),
            //         width: (widget.enemyPlayer.tempArmor > 0) ? 3 : 0,
            //         height: (widget.enemyPlayer.tempArmor > 0) ? 3 : 0,
            //         child: SvgPicture.asset(
            //           AppIcons.tempArmor,
            //           color: Color.fromRGBO(250, 50, 10, 1),
            //         ),
            //       ),
            //     ),
            //   ),
            // ),

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
  final firebase = FirebaseFirestore.instance.collection('game');
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

    if (user.selectedPlayer!.cantAttack(enemyPlayer.location!.getLocation())) {
      return;
    }

    takeDamage(user.selectedPlayer!, enemyPlayer);

    reduceEnemyPlayerLife(gameController.gameID, enemyPlayer);

    user.takeAction(
      gameController.gameID,
    );

    if (user.selectedPlayer!.action!.outOfActions()) {
      turnController.passTurnWhere(
          gameController.gameID, user.selectedPlayerID!);
    } else {
      user.openCloseMenu();
    }
  }

  void takeDamage(Player selectedPlayer, Player enemy) {
    int attackDamage = selectedPlayer.attack();
    int itemDamage = selectedPlayer.pDamage! + selectedPlayer.mDamage!;
    int totalAttackDamage = attackDamage + itemDamage;

    enemy.takeDamage(
        attackDamage, selectedPlayer.pDamage, selectedPlayer.mDamage);

    playDamageAnimation(totalAttackDamage);
  }

  void reduceEnemyPlayerLife(String gameID, Player player) async {
    await firebase
        .doc(gameID)
        .collection('players')
        .doc('${player.index}')
        .update({'life': player.life!.toMap()});
  }

  // void checkEnemyPlayer(List<Player> players, Player enemyPlayer) {
  //   players.forEach((player) {
  //     if (player.id != enemyPlayer.id) {
  //       return;
  //     }
  //     checkTempArmor(player.tempArmor, enemyPlayer.tempArmor);
  //     checkLife(player.life, enemyPlayer.life);
  //     enemyPlayer = player;
  //   });
  // }

  // void checkTempArmor(int newArmor, oldArmor) {
  //   if (oldArmor != newArmor) {
  //     int damage = oldArmor - newArmor;
  //     playDamageAnimation(damage);
  //   }
  // }

  // void checkLife(int newLife, oldLife) {
  //   if (oldLife != newLife) {
  //     int damage = oldLife - newLife;
  //     playDamageAnimation(damage);
  //   }
  // }

}

// ignore: must_be_immutable
class EnemySpriteVisionRange extends StatelessWidget {
  String? enemyID;
  double? visionRange;
  bool? isDead;
  EnemySpriteVisionRange(
      {Key? key,
      @required this.enemyID,
      @required this.visionRange,
      @required this.isDead})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    UIColor _uiColor = UIColor();

    double? setVisionRange() {
      switch (isDead) {
        case false:
          return visionRange;

        case true:
          return 0;
      }
    }

    return TransparentPointer(
      transparent: true,
      child: AnimatedContainer(
        curve: Curves.fastLinearToSlowEaseIn,
        duration: Duration(milliseconds: 700),
        width: setVisionRange(),
        height: setVisionRange(),
        child: DottedBorder(
          dashPattern: [2, 2],
          borderType: BorderType.Circle,
          //TODO comeback here to revisit the colors. To remove with alpha.
          color: _uiColor.setUIColor(enemyID, 'rangeOutline').withAlpha(150),
          strokeWidth: 0.3,
          child: SizedBox(
            width: visionRange,
            height: visionRange,
          ),
        ),
      ),
    );
  }
}

// ignore: must_be_immutable
class EnemySpriteShadow extends StatelessWidget {
  String? enemyID;
  bool? isDead;
  EnemySpriteShadow({
    Key? key,
    @required this.enemyID,
    @required this.isDead,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    UIColor _uiColor = UIColor();

    return TransparentPointer(
      transparent: true,
      child: Container(
        width: (isDead!) ? 0 : 6,
        height: (isDead!) ? 0 : 6,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: _uiColor.setUIColor(enemyID, 'shadow'),
          border: Border.all(
            color: _uiColor.setUIColor(enemyID, 'rangeOutline'),
            width: 0.3,
          ),
        ),
      ),
    );
  }
}
