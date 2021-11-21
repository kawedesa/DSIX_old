import 'dart:math';

import 'package:dsixv02app/core/app_colors.dart';
import 'package:dsixv02app/core/app_images.dart';
import 'package:dsixv02app/models/dsix/sprite.dart';

import 'package:dsixv02app/models/gm/gm.dart';
import 'package:dsixv02app/models/gm/loot/loot.dart';
import 'package:dsixv02app/models/gm/loot/loot_old.dart';
import 'package:dsixv02app/models/player/enemySprite.dart';

import 'package:dsixv02app/models/player/player.dart';
import 'package:dsixv02app/models/player/playerSprite.dart';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class GmMapPageVM {
  TransformationController interactiveViewerController;

  void startGame(Gm gm) {
    gm.newTurn();
  }

  void spawnPlayersInRandomLocation(List<Player> players, Gm gm, context) {
    if (players.isEmpty) {
      return;
    }
    players.forEach((element) {
      if (element.playerCreated) {
        double randomX = Random().nextDouble() * (gm.map.size - 300) + 150;
        double randomY = Random().nextDouble() * (gm.map.size - 300) + 150;
        element.location = Offset(randomX, randomY);
        element.map = gm.map;

        gm.players.add(element);
      }
    });

    gm.buildCanvas();
  }

  void addLoot(Gm gm, context) {
    int randomValue = (Random().nextInt(7) + 1) * 100;

    double size = 20;

    Offset spawnLocation = Offset(
        -gm.navigation.value.row0.a / gm.navigation.value.row0.r +
            (MediaQuery.of(context).size.width * 0.45) /
                gm.navigation.value.row0.r -
            size / 2,
        -gm.navigation.value.row1.a / gm.navigation.value.row0.r +
            (MediaQuery.of(context).size.height * 0.37) /
                gm.navigation.value.row0.r -
            size / 2);

    Loot newLoot = Loot(
      value: randomValue,
      size: size,
      location: spawnLocation,
      openLoot: () async {
        //TODO open loot dialog
        //Player select Loot
        //Delete Loot
      },
    );

    gm.loot.add(newLoot);
    gm.buildCanvas();
  }

  // void mapInteraction(Offset position, Gm gm) {
  //   instructions[gm.quest.gameCreationStep].action(position, gm);
  // }

  // List<Instruction> instructions = [];
  // Widget gameCreationAction(Gm gm) {
  //   switch (gm.quest.objective.objective) {
  //     case 'escort':
  //       instructions = [
  //         Instruction(
  //             'Double tap the map to place the .', spawnTargetObjective),
  //         Instruction(
  //             'Place the \'s destination. The mission ends when they reach their destination.',
  //             spawnTargetGoal),
  //         Instruction('Place the players starting location.', spawnPlayers),
  //         Instruction(
  //             'Place the enemies. You can change them with a double tap. Spend all your points.',
  //             spawnMenu),
  //       ];
  //       break;
  //   }

  //   return InstructionMenu(
  //     instruction: instructions[gm.quest.gameCreationStep].text,
  //     // subTitle: 'Points left: ${gm.currentXp}',
  //     // ready: false,
  //     // nextStep: () {
  //     //   setState(() {
  //     //     widget.dsix.gm.spawnCharacters();
  //     //   });
  //     // },
  //     // action: () async {
  //     //   instructions[gm.quest.gameCreationStep].action();
  //     // },
  //   );
  // }

  // void spawnTargetObjective(Offset position, Gm gm) {
  //   gm.targets = [];

  //   Character newCharacter = AvailableCharacters.merchant.copy();

  //   newCharacter.sprite.location = position;

  //   gm.targets.add(newCharacter);
  //   gm.buildCanvas();
  //   // gm.quest.objective.target.characters.forEach((element) {
  //   //   gm.targets.add(element);
  //   // });
  //   gm.quest.gameCreationStep++;
  // }

  // void spawnTargetGoal(Offset position, Gm gm) {
  //   gm.goals = [];

  //   Character newCharacter = AvailableCharacters.goal.copy();

  //   newCharacter.sprite.location = position;

  //   gm.goals.add(newCharacter);
  //   gm.buildCanvas();
  //   gm.quest.gameCreationStep++;
  // }

  // void spawnPlayers(Offset position, Gm gm) {
  //   gm.players = [];

  //   Character newCharacter = AvailableCharacters.skeletonMage.copy();

  //   newCharacter.sprite.location = position;

  //   gm.players.add(newCharacter);
  //   gm.buildCanvas();
  //   gm.quest.gameCreationStep++;
  // }

  // void spawnMenu(Offset position, Gm gm) {
  //   int totalSpawns = gm.currentXp ~/ 25;
  // }
}
