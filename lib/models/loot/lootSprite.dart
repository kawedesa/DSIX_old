import 'package:dsixv02app/models/gameController.dart';
import 'package:dsixv02app/models/loot/lootSpriteImage.dart';
import 'package:dsixv02app/models/player/player.dart';
import 'package:dsixv02app/models/turnOrder/turn.dart';
import 'package:dsixv02app/models/player/user.dart';
import 'package:dsixv02app/models/turnOrder/turnController.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'lootController.dart';
import 'lootDialog.dart';

// ignore: must_be_immutable
class LootSprite extends StatelessWidget {
  int lootIndex;
  double dx;
  double dy;
  bool isClosed;
  LootSprite({Key key, this.lootIndex, this.dx, this.dy, this.isClosed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final gameController = Provider.of<GameController>(context);
    final players = Provider.of<List<Player>>(context);
    final turnController = Provider.of<TurnController>(context);
    final turnOrder = Provider.of<List<Turn>>(context);
    final lootController = Provider.of<LootController>(context);
    final user = Provider.of<User>(context);

    return Positioned(
        left: dx - 7,
        top: dy - 7,
        child: GestureDetector(
          onTap: () {
            if (user.playerMode != 'walk') {
              return;
            }
            if (user.selectedPlayer.cantReach(Offset(dx, dy))) {
              return;
            }
            if (isClosed) {
              lootController.openLoot(lootIndex);
              showDialog(
                barrierDismissible: false,
                context: context,
                builder: (BuildContext context) {
                  return LootDialog(
                    lootIndex: lootIndex,
                  );
                },
              );
            } else {
              showDialog(
                barrierDismissible: false,
                context: context,
                builder: (BuildContext context) {
                  return LootDialog(
                    lootIndex: lootIndex,
                  );
                },
              );
            }

            turnController.takeTurn(gameController, players, turnOrder, user);
          },
          child: LootSpriteImage(isClosed: isClosed),
        ));
  }
}
