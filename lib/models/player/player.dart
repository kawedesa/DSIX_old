import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dsixv02app/models/game/gameMap/heightMap.dart';
import 'package:dsixv02app/models/game/gameMap/totalArea.dart';
import 'package:dsixv02app/models/player/equipment/equipmentSlot.dart';
import 'package:dsixv02app/models/player/equipment/playerDamage.dart';
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
import 'playerTempLocation.dart';

class Player {
  String? gameID;
  String? id;
  String? mode;
  PlayerAnimation? animation;
  PlayerLocation? location;
  String? race;
  PlayerVision? vision;
  PlayerWalkRange? walkRange;
  PlayerLife? life;
  PlayerEquipment? equipment;
  PlayerAction? action;

  Player({
    String? gameID,
    String? id,
    String? mode,
    PlayerAnimation? animation,
    PlayerLocation? location,
    String? race,
    PlayerVision? vision,
    PlayerWalkRange? walkRange,
    PlayerLife? life,
    PlayerAttackRange? attackRange,
    PlayerEquipment? equipment,
    PlayerAction? action,
  }) {
    this.gameID = gameID;
    this.id = id;
    this.mode = mode;
    this.animation = animation;
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
      'gameID': this.gameID,
      'id': this.id,
      'mode': this.mode,
      'animation': this.animation?.toMap(),
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
      gameID: data?['gameID'],
      id: data?['id'],
      mode: data?['mode'],
      animation: PlayerAnimation.fromMap(data?['animation']),
      location: PlayerLocation.fromMap(data?['location']),
      race: data?['race'],
      vision: PlayerVision.fromMap(data?['vision']),
      walkRange: PlayerWalkRange.fromMap(data?['walkRange']),
      life: PlayerLife.fromMap(data?['life']),
      equipment: PlayerEquipment.fromMap(data?['equipment']),
      action: PlayerAction.fromMap(data?['action']),
    );
  }

  factory Player.newRandomPlayer(
      String gameID, int playerIndex, PlayerLocation location) {
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
      gameID: gameID,
      id: id[playerIndex],
      mode: 'wait',
      animation: PlayerAnimation.empty(),
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

  void startTurn() {
    this.action!.newActions(this.gameID!, this.id!);
    clearTempEffects();
    walkMode();
    updateMode();
  }

  void menuMode() {
    if (this.mode == 'menu') {
      if (this.action!.outOfActions()) {
        waitMode();
        return;
      } else {
        walkMode();
        return;
      }
    } else {
      this.mode = 'menu';
    }
    updateMode();
  }

  void waitMode() {
    this.mode = 'wait';
    updateMode();
  }

  void walkMode() {
    this.mode = 'walk';
    updateMode();
  }

  void attackMode() {
    this.mode = 'attack';
    updateMode();
  }

  void deadMode() {
    this.mode = 'dead';
    updateMode();
  }

  updateMode() async {
    final database = FirebaseFirestore.instance.collection('game');
    await database.doc(this.gameID!).collection('players').doc(this.id).update({
      'mode': this.mode,
    });
  }

  void endWalk(
    PlayerTempLocation newLocation,
    TotalArea tallGrass,
    HeightMap height,
  ) {
    int newHeight = height.inThisLayer(newLocation.newLocation!);

    if (newHeight != newLocation.height) {
      throw CantPassException();
    }

    this.location!.newLocation(this.gameID!, this.id!, newLocation, tallGrass);

    this.vision!.setHeight(this.gameID!, this.id!, newLocation.height!);
  }

  bool cantAttack(PlayerLocation targetLocation) {
    if (this.equipment!.attackRange!.cantAttack(
        targetLocation, this.location!, this.equipment!.rangedAttack())) {
      return true;
    } else {
      return false;
    }
  }

  PlayerAttack attack() {
    return PlayerAttack.newAttack(this.equipment!.damage!);
  }

  void receiveAnAttack(PlayerAttack attack) {
    int totalDamage = this.equipment!.armor!.calculateArmor(attack);
    this.animation!.newDamageAnimation(this.gameID!, this.id!, totalDamage);
    this.life!.decrease(this.gameID!, this.id!, totalDamage);
    this.equipment!.update(this.gameID!, this.id!);

    if (this.life!.isDead()) {
      deadMode();
      throw PlayerIsDeadException();
    }
  }

  void defend() {
    int protect = Random().nextInt(6) + 1;
    this.equipment!.armor!.increaseTempArmor(protect);
    this.equipment!.update(this.gameID!, this.id!);
  }

  void look() {
    this.vision!.seeInvisible(this.gameID!, this.id!);
  }

  void clearTempEffects() {
    this.equipment!.armor!.resetTempArmor();
    this.equipment!.update(this.gameID!, this.id!);
    this.vision!.reset();
    this.vision!.update(this.gameID!, this.id!);
  }

  void getItem(Item item) {
    this.equipment!.getItem(this.gameID!, this.id!, item);
  }

  void addItemToBag(Item item) {
    this.equipment!.addItemToBag(this.gameID!, this.id!, item);
  }

  void removeItem(EquipmentSlot equipmentSlot) {
    this.equipment!.removeItem(this.gameID!, this.id!, equipmentSlot);
  }

  void removeItemFromBag(EquipmentSlot equipmentSlot) {
    this.equipment!.removeItemFromBag(this.gameID!, this.id!, equipmentSlot);
  }

  void equipItem(EquipmentSlot equipmentSlot, EquipmentSlot item) {
    this.equipment!.equipItem(this.gameID!, this.id!, equipmentSlot, item);
  }

  void unequipItem(EquipmentSlot equipmentSlot) {
    this.equipment!.unequip(this.gameID!, this.id!, equipmentSlot);
  }

  void emptySlot(EquipmentSlot equipmentSlot) {
    this.equipment!.emptySlot(this.gameID!, this.id!, equipmentSlot);
  }

  void useItem(EquipmentSlot item) {
    switch (item.item!.name) {
      case 'ward':
        this.vision!.tempVision = this.vision!.tempVision! + 50;
        this.vision!.canSeeInvisible = true;
        this.vision!.update(this.gameID!, this.id!);
        break;

      case 'food':
        int healingAmount = Random().nextInt(3) + 1;
        this.life!.increase(this.gameID!, this.id!, healingAmount);
        break;

      case 'healing potion':
        int healingAmount = Random().nextInt(3) + 4;
        this.life!.increase(this.gameID!, this.id!, healingAmount);
        break;
    }
    this.equipment!.removeItem(this.gameID!, this.id!, item);
    this.equipment!.removeItemFromBag(this.gameID!, this.id!, item);
  }
}

class PlayerAnimation {
  List<String>? damage;
  PlayerAnimation({
    List<String>? damage,
  }) {
    this.damage = damage;
  }

  factory PlayerAnimation.fromMap(Map<String, dynamic>? data) {
    List<String> damage = [];
    List<dynamic> damageMap = data?['damage'];
    damageMap.forEach((animation) {
      damage.add(animation);
    });

    return PlayerAnimation(
      damage: damage,
    );
  }

  factory PlayerAnimation.empty() {
    return PlayerAnimation(
      damage: [],
    );
  }

  Map<String, dynamic> toMap() {
    var damage = this.damage?.toList();
    return {
      'damage': damage,
    };
  }

  void newDamageAnimation(String gameID, String playerID, int damage) {
    this.damage!.add(damage.toString());
    update(gameID, playerID);
  }

  void update(String gameID, String playerID) async {
    final database = FirebaseFirestore.instance.collection('game');

    await database
        .doc(gameID)
        .collection('players')
        .doc(playerID)
        .update({'animation': toMap()});
  }
}

class PlayerAttack {
  int? randomDamage;
  int? pDamage;
  int? mDamage;

  PlayerAttack({int? randomDamage, int? pDamage, int? mDamage}) {
    this.randomDamage = randomDamage;
    this.pDamage = pDamage;
    this.mDamage = mDamage;
  }

  factory PlayerAttack.newAttack(PlayerDamage damage) {
    return PlayerAttack(
      randomDamage: Random().nextInt(6) + 1,
      pDamage: damage.pDamage,
      mDamage: damage.mDamage,
    );
  }

  int totalDamage() {
    return this.randomDamage! + this.pDamage! + this.mDamage!;
  }
}
