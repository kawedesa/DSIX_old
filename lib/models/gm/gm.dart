import 'dart:math';

import 'package:dsixv02app/core/app_colors.dart';
import 'package:dsixv02app/models/dsix/sprite.dart';
import 'package:dsixv02app/models/gm/map/mapTile.dart';
import 'package:dsixv02app/models/gm/building/building.dart';
import 'package:dsixv02app/models/gm/quest/quest.dart';
import 'package:dsixv02app/models/player/player.dart';
import 'package:flutter/material.dart';

import 'character/character.dart';
import 'loot/loot.dart';
import 'loot/loot_old.dart';

class Gm {
  Color primaryColor = AppColors.gmPrimaryColor;
  Color secondaryColor = AppColors.gmSecondaryColor;
  Color tertiaryColor = AppColors.gmTertiaryColor;

  bool gameSelected = false;

  MapTile map;

  // int round = 0;
  // int roundXp;
  // int currentXp;
  // int roundGold;

  // Quest quest = Quest().emptyQuest();
  // List<Quest> questCompleted;

  //Canvas

  TransformationController navigation = TransformationController(
      Matrix4(1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 1));

  // void spawnCharacters() {
  //   this.gameCreationStep++;

  //   this.buildings.forEach((element) {
  //     element.sprite.drag = false;

  //     while (element.xp > 0) {
  //       Character newCharacter = Character();
  //       newCharacter = element.availableCharacters[
  //               Random().nextInt(element.availableCharacters.length)]
  //           .copy();

  //       newCharacter.sprite.location = Offset(
  //           Random().nextDouble() * element.sprite.size +
  //               element.sprite.location.dx -
  //               newCharacter.sprite.size / 2,
  //           Random().nextDouble() * element.sprite.size +
  //               element.sprite.location.dy -
  //               newCharacter.sprite.size / 2);

  //       if (newCharacter.xp <= element.xp) {
  //         this.characters.add(newCharacter);
  //         element.xp -= newCharacter.xp;
  //       }
  //     }
  //   });

  //   print(this.characters);
  //   // print(this.buildings);
  //   buildCanvas();
  // }

  // void deleteBuilding(Building building) {
  //   this.buildings.remove(building);
  //   this.currentXp += building.xp;
  //   buildCanvas();
  // }

  Widget separator = Container(
    width: 640,
    height: 640,
    color: AppColors.separator,
  );

  // void newRound() {
  //   this.round++;
  //   this.canvas = [];
  //   // this.buildings = [];
  //   this.targets = [];
  //   this.goals = [];
  //   this.players = [];
  //   this.enemies = [];
  // }

  void buildCanvas() {
    this.canvas = [];

    //Add Map
    this.canvas.add(this.map);

    //Add Players
    this.players.forEach((element) {
      Sprite newSprite = Sprite(
        layers: element.race.sprite.layers,
        size: element.race.size,
        location: element.location,
      );

      this.canvas.add(newSprite);
    });

    //Add Enemies
    this.enemy.forEach((element) {
      this.canvas.add(element.sprite);
    });

    //Add Loot
    this.loot.forEach((element) {
      this.canvas.add(element);
    });
  }

  void takeTurn(Player player) {
    this.turnOrder.remove(player.race.sprite);
    checkTurn();
  }

  void checkTurn() {
    if (this.turnOrder.isEmpty) {
      newTurn();
    }
  }

  void newTurn() {
    this.turnOrder = [];

    if (this.players.isNotEmpty) {
      this.players.forEach((element) {
        this.turnOrder.add(element.race.sprite);
      });

      if (this.enemy.isNotEmpty) {
        this.enemy.forEach((element) {
          this.turnOrder.add(element.sprite);
        });
      }

      this.turnOrder.shuffle();
    }
  }

  List<Widget> canvas = [];

  List<Player> players = [];
  List<Character> enemy = [];
  List<Loot> loot = [];

  List<Widget> turnOrder = [];
}
