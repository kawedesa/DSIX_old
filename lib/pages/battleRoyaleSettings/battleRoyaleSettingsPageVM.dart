import 'package:dsixv02app/models/game/gameController.dart';
import 'package:dsixv02app/models/game/gameMap/gameMap.dart';
import 'package:dsixv02app/models/loot/lootController.dart';
import 'package:dsixv02app/models/player/playerController.dart';
import 'package:dsixv02app/models/turn/turnController.dart';
import 'package:dsixv02app/pages/playerSelection/playerSelectionPage.dart';
import 'package:dsixv02app/shared/app_Maps.dart';
import 'package:flutter/material.dart';

class BattleRoyaleSettingsPageVM {
  int numberOfPlayers = 2;
  int numberOfLoot = 10;

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

  void increaseNumberOfLoot() {
    this.numberOfLoot++;
    if (numberOfLoot > 20) {
      numberOfLoot = 20;
    }
  }

  void decreaseNumberOfLoot() {
    this.numberOfLoot--;
    if (numberOfLoot < 10) {
      numberOfLoot = 10;
    }
  }

  void newBattleRoyaleGame(
    GameController gameController,
    PlayerController playerController,
    LootController lootController,
  ) {
    GameMap map = AppMaps.ruins;
    gameController.newGame(map);

    playerController.newRandomPlayers(
      gameController.gameID,
      map.size!,
      numberOfPlayers,
    );

    lootController.newRandomLoot(
      gameController.gameID,
      map.size!,
      numberOfLoot * numberOfPlayers,
    );
  }

  void deleteGame(
    GameController gameController,
    PlayerController playerController,
    LootController lootController,
    TurnController turnController,
  ) {
    gameController.deleteGame();
    playerController.deleteAllPlayers(gameController.gameID);
    lootController.deleteAllLoot(gameController.gameID);
    turnController.deleteTurnOrder(gameController.gameID);
  }

  void joinGame(context) {
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

    Navigator.of(context).pushReplacement(newRoute);
  }
}
