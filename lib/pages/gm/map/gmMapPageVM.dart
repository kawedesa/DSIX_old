import 'dart:math';

import 'package:dsixv02app/core/app_colors.dart';
import 'package:dsixv02app/core/app_images.dart';
import 'package:dsixv02app/models/dsix/dsix.dart';
import 'package:dsixv02app/models/dsix/sprite.dart';

import 'package:dsixv02app/models/gm/gm.dart';
import 'package:dsixv02app/models/gm/loot/gmLootSprite.dart';
import 'package:dsixv02app/models/gm/loot/loot.dart';
import 'package:dsixv02app/models/player/enemySprite.dart';

import 'package:dsixv02app/models/player/player.dart';
import 'package:dsixv02app/models/player/playerSprite.dart';
import 'package:dsixv02app/pages/player/playerUI/playerUI.dart';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class GmMapPageVM {
  TransformationController interactiveViewerController;

  void goToPlayer(BuildContext context, Dsix dsix, int playerIndex) {
    dsix.setCurrentPlayer(playerIndex);

    Route newRoute = PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => PlayerUI(
        dsix: dsix,
      ),
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

  void startGame(Gm gm) {
    gm.newTurn();
  }

  void spawnPlayersInRandomLocation(List<Player> players, Gm gm) {
    if (players.isEmpty) {
      return;
    }

    gm.players = [];

    players.forEach((element) {
      if (element.playerCreated) {
        double randomX = Random().nextDouble() * (gm.map.size - 300) + 150;
        double randomY = Random().nextDouble() * (gm.map.size - 300) + 150;
        element.location = Offset(randomX, randomY);
        element.map = gm.map.copy();

        gm.players.add(element);
      }
    });

    gm.buildCanvas();
  }

  void createRandomLoot(context, Gm gm, int number) {
    List<String> possibleLoot = [
      'gold',
      'item',
    ];

    int i = 0;
    while (i < number) {
      int randomLoot = Random().nextInt(possibleLoot.length);

      newLoot(context, gm, possibleLoot[randomLoot]);
      i++;
    }
  }

  void newLoot(context, Gm gm, String type) {
    //Location
    double randomX = Random().nextDouble() * (gm.map.size);
    double randomY = Random().nextDouble() * (gm.map.size);

    Offset spawnLocation = Offset(randomX, randomY);

    Loot newLoot = Loot(
      type: type,
      name: '$type chest',
      opened: false,
      location: spawnLocation,
    );

    gm.loot.add(newLoot);

    gm.buildCanvas();
  }
}


   // //Middle of screen
    // Offset spawnLocation = Offset(
    //     -gm.navigation.value.row0.a / gm.navigation.value.row0.r +
    //         (MediaQuery.of(context).size.width * 0.45) /
    //             gm.navigation.value.row0.r -
    //         size / 2,
    //     -gm.navigation.value.row1.a / gm.navigation.value.row0.r +
    //         (MediaQuery.of(context).size.height * 0.37) /
    //             gm.navigation.value.row0.r -
    //         size / 2);
