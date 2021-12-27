import 'package:dsixv02app/models/game/gameController.dart';
import 'package:dsixv02app/models/loot/loot.dart';
import 'package:dsixv02app/models/loot/lootSpriteImage.dart';
import 'package:dsixv02app/models/player/user.dart';
import 'package:dsixv02app/models/turn/turnController.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'lootController.dart';
import 'lootDialog.dart';

// ignore: must_be_immutable
class LootSprite extends StatelessWidget {
  int? lootIndex;
  LootLocation? location;
  bool? isClosed;
  LootSprite(
      {Key? key,
      @required this.lootIndex,
      @required this.location,
      @required this.isClosed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final turnController = Provider.of<TurnController>(context);
    final lootController = Provider.of<LootController>(context);
    final gameController = Provider.of<GameController>(context);
    final user = Provider.of<User>(context);

    return Positioned(
        left: location!.dx! - 4,
        top: location!.dy! - 4,
        child: GestureDetector(
          onTap: () async {
            if (user.playerMode != 'walk') {
              return;
            }
            if (user.selectedPlayer!.cantReach(location!.getLocation())) {
              return;
            }

            user.takeAction(
              gameController.gameID,
            );

            if (user.selectedPlayer!.action!.outOfActions()) {
              turnController.passTurnWhere(
                  gameController.gameID, user.selectedPlayer!.id!);
            }

            if (isClosed!) {
              lootController.openLoot(gameController.gameID, lootIndex!);
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
          },
          child: LootSpriteImage(isClosed: isClosed),
        ));
  }
}
