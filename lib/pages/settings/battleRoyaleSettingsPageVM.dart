import 'package:dsixv02app/models/dsix.dart';
import 'package:dsixv02app/models/gameMap.dart';
import 'package:dsixv02app/pages/playerSelection/playerSelectionPage.dart';

import 'package:flutter/material.dart';

class BattleRoyaleSettingsPageVM {
  void newGame(context, Dsix dsix, GameMap map, int numberOfPlayers) {
    dsix.createRandomPlayersInRandomLocations(numberOfPlayers);
    dsix.newMap();
    goToPlayerSelectionPage(context);
  }

  void deleteGame(Dsix dsix) {
    dsix.deleteMap();
    dsix.deleteAllPlayersFromDataBase();
    dsix.deleteTurnOrder();
  }

  void joinGame(context) {
    goToPlayerSelectionPage(context);
  }

  void goToPlayerSelectionPage(context) {
    Route newRoute = PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) =>
          PlayerSelectionPage(),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        var begin = Offset(-1.0, 0.0);
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
}
