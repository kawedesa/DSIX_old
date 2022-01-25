import 'package:dsixv02app/models/game/game.dart';
import 'package:dsixv02app/models/player/equipment/widget/equipmentPage.dart';

import 'package:dsixv02app/models/player/player.dart';
import 'package:dsixv02app/shared/app_Exceptions.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'chest.dart';
import 'chestSpriteImage.dart';

// ignore: must_be_immutable
class ChestSprite extends StatelessWidget {
  Chest? chest;
  Player? player;
  ChestSprite({
    Key? key,
    @required this.chest,
    @required this.player,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final game = Provider.of<Game>(context);

    return Positioned(
        left: chest!.location!.dx! - 4,
        top: chest!.location!.dy! - 4,
        child: GestureDetector(
          onTap: () async {
            if (player!.mode! != 'walk') {
              return;
            }
            if (player!.cantReach(chest!.location!.getLocation())) {
              return;
            }

            try {
              player!.action!.takeAction(
                game.id!,
                player!.id!,
              );
            } on EndPlayerTurnException {
              game.round!.passTurn(game.id!, player!);
            }

            if (chest!.isClosed!) {
              chest!.openLoot(game.id!);
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return EquipmentPage(
                    player: player,
                    chest: chest,
                  );
                },
              );
            } else {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return EquipmentPage(
                    player: player,
                    chest: chest,
                  );
                },
              );
            }
          },
          child: ChestSpriteImage(isClosed: chest!.isClosed),
        ));
  }
}
