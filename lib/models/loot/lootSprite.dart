import 'package:dsixv02app/models/game/game.dart';
import 'package:dsixv02app/models/loot/loot.dart';
import 'package:dsixv02app/models/loot/lootSpriteImage.dart';
import 'package:dsixv02app/models/player/user.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'lootDialog.dart';

// ignore: must_be_immutable
class LootSprite extends StatelessWidget {
  Loot? loot;
  LootSprite({
    Key? key,
    @required this.loot,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final game = Provider.of<Game>(context);
    final user = Provider.of<User>(context);

    return Positioned(
        left: loot!.location!.dx! - 4,
        top: loot!.location!.dy! - 4,
        child: GestureDetector(
          onTap: () async {
            if (user.playerMode != 'walk') {
              return;
            }
            if (user.selectedPlayer!.cantReach(loot!.location!.getLocation())) {
              return;
            }

            user.selectedPlayer!.action!.takeAction(
              game.id!,
              user.selectedPlayer!.id!,
            );

            if (user.selectedPlayer!.action!.outOfActions()) {
              game.round!.passTurn(game.id!, user.selectedPlayer!.id!);
            }

            if (loot!.isClosed!) {
              loot!.openLoot(game.id!);
              showDialog(
                barrierDismissible: false,
                context: context,
                builder: (BuildContext context) {
                  return LootDialog(
                    loot: loot,
                  );
                },
              );
            } else {
              showDialog(
                barrierDismissible: false,
                context: context,
                builder: (BuildContext context) {
                  return LootDialog(
                    loot: loot,
                  );
                },
              );
            }
          },
          child: LootSpriteImage(isClosed: loot!.isClosed),
        ));
  }
}
