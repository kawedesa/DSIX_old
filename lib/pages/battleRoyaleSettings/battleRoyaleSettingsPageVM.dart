import 'package:dsixv02app/models/game/gameController.dart';
import 'package:dsixv02app/models/game/gameMap/gameMap.dart';
import 'package:dsixv02app/models/chest/chestController.dart';
import 'package:dsixv02app/models/player/player.dart';
import 'package:dsixv02app/models/player/playersController.dart';
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
    PlayersController playerController,
    ChestController lootController,
  ) {
    GameMap map = AppMaps.ruins;
    List<Player> newPlayers = playerController.newRandomPlayers(
      gameController.gameID,
      map,
      numberOfPlayers,
    );

    lootController.newRandomLoot(
      gameController.gameID,
      map.size!,
      numberOfLoot * numberOfPlayers,
    );

    gameController.newGame(map, newPlayers);
  }

  void deleteGame(
    GameController gameController,
    PlayersController playerController,
    ChestController lootController,
  ) {
    gameController.deleteGame();
    playerController.deleteAllPlayers(gameController.gameID);
    lootController.deleteAllLoot(gameController.gameID);
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
