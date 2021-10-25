import 'dart:math';

import 'package:dsixv02app/models/gm/building/availableBuildings.dart';
import 'package:dsixv02app/models/gm/building/building.dart';

class QuestTarget {
  AvailableBuildings availableBuildings = AvailableBuildings();
  List<Building> buildings = [];
  String target;

  QuestTarget newTarget(String objective) {
    QuestTarget newTarget = QuestTarget();
    switch (objective) {
      case 'capture':
        List<String> possibleTarget = [
          'altar',
          'outpost',
        ];

        newTarget.target =
            possibleTarget[Random().nextInt(possibleTarget.length)];

        switch (newTarget.target) {
          case 'altar':
            this.availableBuildings.altar.forEach((element) {
              newTarget.buildings.add(element);
            });
            break;
          case 'outpost':
            this.availableBuildings.outpost.forEach((element) {
              newTarget.buildings.add(element);
            });
            break;
        }

        break;
      case 'control':
        List<String> possibleTarget = [
          'altar',
          'outpost',
        ];

        newTarget.target =
            possibleTarget[Random().nextInt(possibleTarget.length)];

        switch (newTarget.target) {
          case 'altar':
            this.availableBuildings.altar.forEach((element) {
              newTarget.buildings.add(element);
            });
            break;
          case 'outpost':
            this.availableBuildings.outpost.forEach((element) {
              newTarget.buildings.add(element);
            });
            break;
        }
        break;
      case 'destroy':
        List<String> possibleTarget = [
          'altar',
          'outpost',
        ];

        newTarget.target =
            possibleTarget[Random().nextInt(possibleTarget.length)];

        switch (newTarget.target) {
          case 'altar':
            this.availableBuildings.altar.forEach((element) {
              newTarget.buildings.add(element);
            });
            break;
          case 'outpost':
            this.availableBuildings.outpost.forEach((element) {
              newTarget.buildings.add(element);
            });
            break;
        }
        break;
      case 'protect':
        List<String> possibleTarget = [
          'altar',
          'outpost',
        ];

        newTarget.target =
            possibleTarget[Random().nextInt(possibleTarget.length)];

        switch (newTarget.target) {
          case 'altar':
            this.availableBuildings.altar.forEach((element) {
              newTarget.buildings.add(element);
            });
            break;
          case 'outpost':
            this.availableBuildings.outpost.forEach((element) {
              newTarget.buildings.add(element);
            });
            break;
        }
        break;
    }
    return newTarget;
  }
}
