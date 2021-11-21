import 'dart:math';

import 'package:dsixv02app/models/gm/character/availableCharacters.dart';
import 'package:dsixv02app/models/gm/character/character.dart';
import 'package:dsixv02app/models/gm/character/characterSprite.dart';

// import 'package:dsixv02app/models/gm/building/availableBuildings.dart';
// import 'package:dsixv02app/models/gm/building/building.dart';

class QuestTarget {
  // List<Building> buildings = [];

  List<Character> characters = [];

  QuestTarget newTarget(String objective) {
    QuestTarget newTarget;
    switch (objective) {
      case 'escort':
        this.characters = [];
        List<Character> possibleTarget = [
          AvailableCharacters.skeleton,
          AvailableCharacters.skeletonMage,
          AvailableCharacters.zombie,
        ];

        // newTarget.characters
        //     .add(possibleTarget[Random().nextInt(possibleTarget.length)]);

        // print(this.characters);
        break;

      // case 'capture':
      //   List<String> possibleTarget = [
      //     'altar',
      //     'outpost',
      //   ];

      //   newTarget.target =
      //       possibleTarget[Random().nextInt(possibleTarget.length)];

      //   switch (newTarget.target) {
      //     case 'altar':
      //       this.availableBuildings.altar.forEach((element) {
      //         newTarget.buildings.add(element);
      //       });
      //       break;
      //     case 'outpost':
      //       this.availableBuildings.outpost.forEach((element) {
      //         newTarget.buildings.add(element);
      //       });
      //       break;
      //   }

      //   break;
      // case 'control':
      //   List<String> possibleTarget = [
      //     'altar',
      //     'outpost',
      //   ];

      //   newTarget.target =
      //       possibleTarget[Random().nextInt(possibleTarget.length)];

      //   switch (newTarget.target) {
      //     case 'altar':
      //       this.availableBuildings.altar.forEach((element) {
      //         newTarget.buildings.add(element);
      //       });
      //       break;
      //     case 'outpost':
      //       this.availableBuildings.outpost.forEach((element) {
      //         newTarget.buildings.add(element);
      //       });
      //       break;
      //   }
      //   break;
      // case 'destroy':
      //   List<String> possibleTarget = [
      //     'altar',
      //     'outpost',
      //   ];

      //   newTarget.target =
      //       possibleTarget[Random().nextInt(possibleTarget.length)];

      //   switch (newTarget.target) {
      //     case 'altar':
      //       this.availableBuildings.altar.forEach((element) {
      //         newTarget.buildings.add(element);
      //       });
      //       break;
      //     case 'outpost':
      //       this.availableBuildings.outpost.forEach((element) {
      //         newTarget.buildings.add(element);
      //       });
      //       break;
      //   }
      //   break;
      // case 'protect':
      //   List<String> possibleTarget = [
      //     'altar',
      //     'outpost',
      //   ];

      //   newTarget.target =
      //       possibleTarget[Random().nextInt(possibleTarget.length)];

      //   switch (newTarget.target) {
      //     case 'altar':
      //       this.availableBuildings.altar.forEach((element) {
      //         newTarget.buildings.add(element);
      //       });
      //       break;
      //     case 'outpost':
      //       this.availableBuildings.outpost.forEach((element) {
      //         newTarget.buildings.add(element);
      //       });
      //       break;
      //   }
      //   break;
    }
    return newTarget;
  }
}
