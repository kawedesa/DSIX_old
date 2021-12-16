import 'package:dsixv02app/models/game.dart';
import 'package:dsixv02app/models/gameController.dart';

import 'package:dsixv02app/models/loot/lootController.dart';

import 'package:dsixv02app/models/player/playerController.dart';

import 'package:dsixv02app/models/turnOrder/turnController.dart';
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

  void joinGame(context, Game game, GameController gameController) {
    gameController.joinGame(game);
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
    GameController gameController,
    PlayerController playerController,
    TurnController turnController,
    LootController lootController,
  ) {
    gameController.newGame();
    playerController.createListOfRandomPlayersInRandomLocations(
        this.numberOfPlayers, gameController.game.mapSize);
    turnController.newTurnOrder(playerController.listOfRandomPlayers);
    lootController.createListOfRandomLootInRandomLocation(
        this.numberOfPlayers * 10, gameController.game.mapSize);
    goToPlayerSelectionPage(context);
  }

  void deleteBattleRoyaleGame(
    GameController gameController,
    PlayerController playerController,
    TurnController turnController,
    LootController lootController,
  ) {
    gameController.deleteGame();
    playerController.deleteAllPlayersFromDataBase();
    turnController.deleteTurnOrder();
    lootController.deleteAllLootFromDataBase();
  }
}
