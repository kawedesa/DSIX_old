import 'dart:math';
import 'package:dsixv02app/models/game/gameMap/heightMap.dart';
import 'package:dsixv02app/models/game/gameMap/totalArea.dart';
import 'package:dsixv02app/models/shop/item.dart';
import 'package:dsixv02app/shared/app_Exceptions.dart';
import 'package:flutter/material.dart';
import 'playerAction.dart';

import 'equipment/playerAttackRange.dart';

import 'equipment/playerEquipment.dart';
import 'playerLife.dart';
import 'playerLocation.dart';
import 'playerVision.dart';
import 'playerWalkRange.dart';
import 'sprite/playerTempLocation.dart';

class Player {
  String? id;
  PlayerLocation? location;
  String? race;
  PlayerVision? vision;
  PlayerWalkRange? walkRange;
  PlayerLife? life;
  PlayerEquipment? equipment;
  PlayerAction? action;

  Player({
    String? id,
    PlayerLocation? location,
    String? race,
    PlayerVision? vision,
    PlayerWalkRange? walkRange,
    PlayerLife? life,
    PlayerAttackRange? attackRange,
    PlayerEquipment? equipment,
    PlayerAction? action,
  }) {
    this.id = id;
    this.location = location;
    this.race = race;
    this.vision = vision;
    this.walkRange = walkRange;
    this.life = life;
    this.equipment = equipment;
    this.action = action;
  }

  Map<String, dynamic> toMap() {
    return {
      'id': this.id,
      'location': this.location?.toMap(),
      'race': this.race,
      'vision': this.vision?.toMap(),
      'walkRange': this.walkRange?.toMap(),
      'life': this.life?.toMap(),
      'equipment': this.equipment?.toMap(),
      'action': this.action?.toMap(),
    };
  }

  factory Player.fromMap(Map<String, dynamic>? data) {
    return Player(
      id: data?['id'],
      location: PlayerLocation.fromMap(data?['location']),
      race: data?['race'],
      vision: PlayerVision.fromMap(data?['vision']),
      walkRange: PlayerWalkRange.fromMap(data?['walkRange']),
      life: PlayerLife.fromMap(data?['life']),
      equipment: PlayerEquipment.fromMap(data?['equipment']),
      action: PlayerAction.fromMap(data?['action']),
    );
  }

  factory Player.newRandomPlayer(int playerIndex, PlayerLocation location) {
    List<String> id = [
      'blue',
      'pink',
      'green',
      'yellow',
      'purple',
    ];

    List<String> races = [
      'orc',
      'dwarf',
      'elf',
    ];
    int randomNumber = Random().nextInt(races.length);
    String randomRace = races[randomNumber];

    return Player(
      id: id[playerIndex],
      location: location,
      race: randomRace,
      vision: PlayerVision.set(randomRace),
      walkRange: PlayerWalkRange.set(randomRace),
      life: PlayerLife.set(randomRace),
      equipment: PlayerEquipment.empty(randomRace),
      action: PlayerAction.empty(),
    );
  }

  bool cantReach(Offset targetLocation) {
    double distance = (targetLocation - this.location!.getLocation()).distance;
    if (distance > 20) {
      return true;
    } else {
      return false;
    }
  }

  void endWalk(
    String gameID,
    PlayerTempLocation newLocation,
    TotalArea tallGrass,
    HeightMap height,
  ) {
    int newHeight = height.inThisLayer(newLocation.getLocation());

    if (newHeight != newLocation.height) {
      throw CantPassException();
    }

    this
        .location!
        .newLocation(gameID, this.id!, newLocation, tallGrass, newHeight);

    this.vision!.setHeight(gameID, this.id!, newHeight);
  }

  int attack() {
    int damage = Random().nextInt(6) + 1;
    return damage;
  }

  void defend(String gameID) {
    int protect = Random().nextInt(6) + 1;
    this.equipment!.armor!.increaseTempArmor(protect);
    this.equipment!.update(gameID, this.id!);
  }

  void clearTempEffects(String gameID) {
    this.equipment!.armor!.resetTempArmor();
    this.equipment!.update(gameID, this.id!);
    this.vision!.reset();
    this.vision!.update(gameID, this.id!);
  }

  void takeDamage(String gameID, int damageRoll, pDamage, mDamage) {
    if (this.equipment!.armor!.tempArmor! > 0) {
      int damage = pDamage + mDamage + damageRoll;
      this.life!.decrease(
          gameID, this.id!, this.equipment!.armor!.calculateTempArmor(damage));
      this.equipment!.update(gameID, this.id!);
      return;
    }

    this.life!.decrease(
        gameID,
        this.id!,
        this
            .equipment!
            .armor!
            .calculateDamageReceived(damageRoll, pDamage, mDamage));
  }

  void useItem(String gameID, Item item) {
    switch (item.name) {
      case 'ward':
        this.vision!.tempVision = this.vision!.tempVision! + 50;
        this.vision!.canSeeInvisible = true;
        this.vision!.update(gameID, this.id!);
        break;

      case 'food':
        int healingAmount = Random().nextInt(3) + 1;
        this.life!.increase(gameID, this.id!, healingAmount);
        break;

      case 'healing potion':
        int healingAmount = Random().nextInt(3) + 4;
        this.life!.increase(gameID, this.id!, healingAmount);
        break;
    }
    this.equipment!.destroyItem(gameID, this.id!, item);
  }
}
