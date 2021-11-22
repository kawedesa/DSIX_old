import 'dart:math';

import 'package:dsixv02app/core/app_colors.dart';
import 'package:dsixv02app/core/app_icon.dart';
import 'package:dsixv02app/core/app_images.dart';
import 'package:dsixv02app/models/dsix/sprite.dart';
import 'package:dsixv02app/models/gm/map/mapTile.dart';
import 'package:dsixv02app/models/gm/building/building.dart';
import 'package:dsixv02app/models/gm/quest/quest.dart';
import 'package:dsixv02app/models/player/effectSystem.dart';
import 'package:dsixv02app/models/player/player.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'character/character.dart';
import 'loot/gmLootSprite.dart';
import 'loot/loot.dart';

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
        layers: [element.race.icon],
        size: element.race.size,
        location: element.location,
      );

      this.canvas.add(newSprite);
    });

    // //Add Enemies
    // this.enemy.forEach((element) {
    //   this.canvas.add(element.sprite);
    // });

    //Add Loot
    spawnLoot();
  }

  void spawnLoot() {
    this.loot.forEach((element) {
      GmLootSprite newLootSprite = GmLootSprite(
        gold: element.gold,
        size: element.size,
        location: element.location,
        confirm: () async {},
        updateLocation: (details) async {
          element.location = Offset(element.location.dx + details.dx,
              element.location.dy + details.dy);
        },
      );
      this.canvas.add(newLootSprite);
    });
  }

  void killPlayer(Player player) {
    this.players.remove(player);
    if (this.turnOrder.contains(player.race.icon)) {
      this.turnOrder.remove(player.race.icon);
    }
    this.deadPlayers.add(player);
    Loot playerCorpse = Loot(
      image: SvgPicture.asset(
        AppImages.grave,
        color: player.primaryColor,
        width: player.race.size,
        height: player.race.size,
      ),
      name: 'corpse',
      size: player.race.size,
      opened: false,
      gold: player.gold,
      location: player.location,
    );
    this.loot.add(playerCorpse);
    if (this.turnOrder.contains(player.race.icon)) {
      this.turnOrder.remove(player.race.icon);
    }

    buildCanvas();
  }

  List<Player> deadPlayers = [];

  EffectSystem _effectSystem = EffectSystem();
  void takeTurn() {
    List<AppIcon> playerToRemove = [];
    this.players.forEach((element) {
      if (element.race.icon == this.turnOrder.first) {
        _effectSystem.runEffects(element);
        playerToRemove.add(element.race.icon);
      }
    });

    playerToRemove.forEach((element) {
      this.turnOrder.remove(element);
    });

    checkTurn();
  }

  void checkTurn() {
    if (this.turnOrder.isEmpty) {
      newTurn();
      return;
    }
  }

  void newTurn() {
    this.turnOrder = [];

    if (this.players.isNotEmpty) {
      this.players.forEach((element) {
        this.turnOrder.add(element.race.icon);
      });

      if (this.enemy.isNotEmpty) {
        this.enemy.forEach((element) {
          this.turnOrder.add(element.icon);
        });
      }

      this.turnOrder.shuffle();
    }
  }

  List<Widget> canvas = [];

  List<Player> players = [];
  List<Character> enemy = [];
  List<Loot> loot = [];

  List<AppIcon> turnOrder = [];
}
