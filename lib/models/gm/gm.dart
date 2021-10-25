import 'dart:math';

import 'package:dsixv02app/core/app_colors.dart';
import 'package:dsixv02app/models/gm/building/building.dart';
import 'package:dsixv02app/models/gm/quest/quest.dart';
import 'package:flutter/material.dart';

import 'character/character.dart';

class Gm {
  Color primaryColor = AppColors.gmPrimaryColor;
  Color secondaryColor = AppColors.gmSecondaryColor;
  Color tertiaryColor = AppColors.gmTertiaryColor;

  int round = 0;
  int roundXp;
  int currentXp;
  int roundGold;

  Quest quest = Quest().emptyQuest();
  List<Quest> questCompleted;

  //Canvas

  Offset startLocation;

  int gameCreationStep = 0;

  void spawnCharacters() {
    this.gameCreationStep++;
    this.buildings.forEach((element) {
      element.sprite.drag = false;

      Character newCharacter = Character();

      while (element.xp > 0) {
        newCharacter = element.availableCharacters[
            Random().nextInt(element.availableCharacters.length)];

        newCharacter.sprite.location = Offset(
            Random().nextDouble() * element.sprite.size +
                element.sprite.location.dx,
            Random().nextDouble() * element.sprite.size +
                element.sprite.location.dy);

        if (newCharacter.xp <= element.xp) {
          this.characters.add(newCharacter.copy());
          element.xp -= newCharacter.xp;
        }
      }
    });
    buildCanvas();
  }

  void deleteBuilding(Building building) {
    this.buildings.remove(building);
    this.currentXp += building.xp;
    buildCanvas();
  }

  Widget separator = Container(
    width: 640,
    height: 640,
    color: AppColors.separator,
  );

  void newRound() {
    this.round++;
    this.canvas = [];
    this.buildings = [];
    this.characters = [];
  }

  void buildCanvas() {
    this.canvas = [];
    switch (this.gameCreationStep) {
      case 0:
        this.canvas.add(this.quest.location.map);
        this.canvas.add(this.separator);
        this.buildings.forEach((element) {
          this.canvas.add(element.sprite);
        });
        break;
      case 1:
        this.canvas.add(this.quest.location.map);

        this.buildings.forEach((element) {
          this.canvas.add(element.sprite);
        });
        this.canvas.add(this.separator);
        this.characters.forEach((element) {
          this.canvas.add(element.sprite);
        });
        break;
    }
  }

  List<Widget> canvas = [];
  List<Building> buildings = [];
  List<Character> characters = [];
}
