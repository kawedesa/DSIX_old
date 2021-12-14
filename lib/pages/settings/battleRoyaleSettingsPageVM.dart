import 'package:dsixv02app/models/game.dart';
import 'package:dsixv02app/models/loot.dart';
import 'package:dsixv02app/models/player.dart';
import 'package:dsixv02app/models/turnOrder.dart';
import 'package:dsixv02app/pages/playerSelection/playerSelectionPage.dart';

import 'package:flutter/material.dart';

class BattleRoyaleSettingsPageVM {
  int numberOfPlayers;

  void setNumberOfPlayers() {
    if (this.numberOfPlayers != null) {
      return;
    }
    numberOfPlayers = 2;
  }

  void increaseNumberOfPlayers() {
    this.numberOfPlayers++;
    if (numberOfPlayers > 5) {
      numberOfPlayers = 5;
    }
  }

  void decreaseNumberOfPlayers() {
    this.numberOfPlayers--;
    if (numberOfPlayers < 2) {
      numberOfPlayers = 2;
    }
  }

  void joinGame(context) {
    goToPlayerSelectionPage(context);
  }

  void goToPlayerSelectionPage(context) {
    Route newRoute = PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) =>
          PlayerSelectionPage(),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        var begin = Offset(1.0, 0.0);
        var end = Offset(0.0, 0.0);
        var curve = Curves.ease;
        var tween =
            Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

        return SlideTransition(
          position: animation.drive(tween),
          child: child,
        );
      },
    );

    Navigator.of(context).push(newRoute);
  }

  void newBattleRoyaleGame(
    context,
    Game game,
    PlayerController playerController,
    TurnController turnController,
    LootController lootController,
  ) {
    game.newGame();
    playerController
        .createListOfRandomPlayersInRandomLocations(this.numberOfPlayers);
    turnController.newTurnOrder(playerController.listOfRandomPlayers);
    lootController.createListOfRandomLootInRandomLocation(10);
    goToPlayerSelectionPage(context);
  }

  void deleteBattleRoyaleGame(
    Game game,
    PlayerController playerController,
    TurnController turnController,
    LootController lootController,
  ) {
    game.deleteGame();
    playerController.deleteAllPlayersFromDataBase();
    turnController.deleteTurnOrder();
    lootController.deleteAllLootFromDataBase();
  }
}
