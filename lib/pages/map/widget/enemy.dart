import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dotted_border/dotted_border.dart';
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
class Enemy extends StatefulWidget {
  String enemyID;
  double dx;
  double dy;
  String race;
  double vision;
  int life;
  Enemy(
      {Key key,
      this.enemyID,
      this.dx,
      this.dy,
      this.race,
      this.vision,
      this.life})
      : super(key: key);

  @override
  State<Enemy> createState() => _EnemyState();
}

class _EnemyState extends State<Enemy> {
  UIColor _uiColor = UIColor();
  EnemyController _enemyController = EnemyController();

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

  void updateEnemyLife(List<Player> player) {
    player.forEach((player) {
      if (player.id != widget.enemyID) {
        return;
      }

      if (player.life != widget.life) {
        int damage = widget.life - player.life;
        _playDamageAnimation(damage);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    final turnManager = Provider.of<TurnManager>(context);
    final turnOrder = Provider.of<List<Turn>>(context);
    final game = Provider.of<Game>(context);
    final players = Provider.of<List<Player>>(context);

    updateEnemyLife(players);

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
                width: 8,
                height: 8,
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
                padding: const EdgeInsets.only(bottom: 12),
                child: (widget.life < 1)
                    ? TransparentPointer(child: SpriteImage(image: 'grave'))
                    : GestureDetector(
                        onTap: () {
                          if (user.playerMode == 'attack') {
                            if (_enemyController.enemyOutOfReach(
                                Offset(widget.dx, widget.dy),
                                players[user.selectedPlayerIndex].getLocation(),
                                players[user.selectedPlayerIndex]
                                    .attackRange)) {
                              return;
                            }

                            int damage =
                                players[user.selectedPlayerIndex].dealDamage();

                            _enemyController.receiveDamage(
                              players,
                              widget.enemyID,
                              damage,
                            );

                            _playDamageAnimation(damage);

                            turnManager.takeTurn(
                                game, players, turnOrder, user);

                            setState(() {});
                          }
                        },
                        child: SpriteImage(image: widget.race),
                      ),
              ),
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
    );
  }
}

class EnemyController {
  final db = FirebaseFirestore.instance;

  // ignore: non_constant_identifier_names
  bool enemyOutOfReach(
      Offset enemyLocation, Offset playerLocation, double playerAttackRange) {
    double distance = (enemyLocation - playerLocation).distance;
    if (distance > playerAttackRange / 2) {
      return true;
    } else {
      return false;
    }
  }

  void receiveDamage(
    List<Player> players,
    String enemyID,
    int damage,
  ) {
    players.forEach((player) {
      if (player.id != enemyID) {
        return;
      }

      player.reduceCurrentLife(damage);
    });
  }
}
