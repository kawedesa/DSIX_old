import 'dart:math';
import 'package:dsixv02app/models/shop/item.dart';
import 'package:flutter/material.dart';

class Player {
  int? index;
  String? id;
  PlayerLocation? location;
  bool? isVisible;
  bool? canSeeInvisible;
  String? race;
  PlayerVisionRange? visionRange;
  PlayerWalkRange? walkRange;
  PlayerAttackRange? attackRange;
  PlayerLife? life;
  PlayerWeight? weight;
  int? pDamage;
  int? mDamage;
  int? pArmor;
  int? mArmor;
  int? tempArmor;
  Item? mainHandSlot;
  Item? offHandSlot;
  Item? headSlot;
  Item? bodySlot;
  Item? handSlot;
  Item? feetSlot;
  List<Item>? bag;
  PlayerAction? action;
  Player({
    int? index,
    String? id,
    PlayerLocation? location,
    bool? isVisible,
    bool? canSeeInvisible,
    String? race,
    PlayerVisionRange? visionRange,
    PlayerWalkRange? walkRange,
    PlayerAttackRange? attackRange,
    PlayerLife? life,
    PlayerWeight? weight,
    int? pDamage,
    int? mDamage,
    int? pArmor,
    int? mArmor,
    int? tempArmor,
    Item? mainHandSlot,
    Item? offHandSlot,
    Item? headSlot,
    Item? bodySlot,
    Item? handSlot,
    Item? feetSlot,
    List<Item>? bag,
    PlayerAction? action,
  }) {
    this.index = index;
    this.id = id;
    this.location = location;
    this.isVisible = isVisible;
    this.canSeeInvisible = canSeeInvisible;
    this.race = race;
    this.visionRange = visionRange;
    this.walkRange = walkRange;
    this.attackRange = attackRange;
    this.life = life;
    this.weight = weight;
    this.pDamage = pDamage;
    this.mDamage = mDamage;
    this.pArmor = pArmor;
    this.mArmor = mArmor;
    this.tempArmor = tempArmor;
    this.mainHandSlot = mainHandSlot;
    this.offHandSlot = offHandSlot;
    this.headSlot = headSlot;
    this.bodySlot = bodySlot;
    this.handSlot = handSlot;
    this.feetSlot = feetSlot;
    this.bag = bag;
    this.action = action;
  }

  Map<String, dynamic> toMap() {
    var bag = this.bag?.map((item) => item.toMap()).toList();

    return {
      'index': this.index,
      'id': this.id,
      'location': this.location?.toMap(),
      'isVisible': this.isVisible,
      'canSeeInvisible': this.canSeeInvisible,
      'race': this.race,
      'visionRange': this.visionRange?.toMap(),
      'walkRange': this.walkRange?.toMap(),
      'attackRange': this.attackRange?.toMap(),
      'life': this.life?.toMap(),
      'weight': this.weight?.toMap(),
      'pDamage': this.pDamage,
      'mDamage': this.mDamage,
      'pArmor': this.pArmor,
      'mArmor': this.mArmor,
      'tempArmor': this.tempArmor,
      'mainHandSlot': this.mainHandSlot?.toMap(),
      'offHandSlot': this.offHandSlot?.toMap(),
      'headSlot': this.headSlot?.toMap(),
      'bodySlot': this.bodySlot?.toMap(),
      'handSlot': this.handSlot?.toMap(),
      'feetSlot': this.feetSlot?.toMap(),
      'bag': bag,
      'action': this.action?.toMap(),
    };
  }

  factory Player.fromMap(Map<String, dynamic>? data) {
    List<Item> bag = [];
    List<dynamic> bagMap = data?['bag'];
    bagMap.forEach((item) {
      bag.add(new Item.fromMap(item));
    });

    return Player(
      index: data?['index'],
      id: data?['id'],
      location: PlayerLocation.fromMap(data?['location']),
      isVisible: data?['isVisible'],
      canSeeInvisible: data?['canSeeInvisible'],
      race: data?['race'],
      visionRange: PlayerVisionRange.fromMap(data?['visionRange']),
      walkRange: PlayerWalkRange.fromMap(data?['walkRange']),
      attackRange: PlayerAttackRange.fromMap(data?['attackRange']),
      life: PlayerLife.fromMap(data?['life']),
      weight: PlayerWeight.fromMap(data?['weight']),
      pDamage: data?['pDamage'],
      mDamage: data?['mDamage'],
      pArmor: data?['pArmor'],
      mArmor: data?['mArmor'],
      tempArmor: data?['tempArmor'],
      mainHandSlot: Item.fromMap(data?['mainHandSlot']),
      offHandSlot: Item.fromMap(data?['offHandSlot']),
      headSlot: Item.fromMap(data?['headSlot']),
      bodySlot: Item.fromMap(data?['bodySlot']),
      handSlot: Item.fromMap(data?['handSlot']),
      feetSlot: Item.fromMap(data?['feetSlot']),
      bag: bag,
      action: PlayerAction.fromMap(data?['action']),
    );
  }

  factory Player.newRandomPlayer(Offset location, int playerIndex) {
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
      index: playerIndex,
      id: id[playerIndex],
      location: PlayerLocation.newLocation(location),
      race: randomRace,
      isVisible: true,
      canSeeInvisible: false,
      visionRange: PlayerVisionRange.set(randomRace),
      walkRange: PlayerWalkRange.set(randomRace),
      attackRange: PlayerAttackRange.set(randomRace),
      life: PlayerLife.set(randomRace),
      weight: PlayerWeight.set(randomRace),
      pDamage: 0,
      mDamage: 0,
      pArmor: 0,
      mArmor: 0,
      tempArmor: 0,
      mainHandSlot: Item.empty(),
      offHandSlot: Item.empty(),
      headSlot: Item.empty(),
      bodySlot: Item.empty(),
      handSlot: Item.empty(),
      feetSlot: Item.empty(),
      bag: [],
      action: PlayerAction.empty(),
    );
  }

  bool cantSee(Offset targetLocation, bool isVisible) {
    if (isVisible == false && this.canSeeInvisible == false) {
      return true;
    }

    double distance = (targetLocation - this.location!.getLocation()).distance;

    if (distance < this.visionRange!.min! / 2 ||
        distance > this.visionRange!.max! / 2) {
      return true;
    } else {
      return false;
    }
  }

  bool cantReach(Offset targetLocation) {
    double distance = (targetLocation - this.location!.getLocation()).distance;
    if (distance > 20) {
      return true;
    } else {
      return false;
    }
  }

  bool cantAttack(Offset targetLocation) {
    double distance = (targetLocation - this.location!.getLocation()).distance;
    if (distance > this.attackRange!.max! / 2 ||
        distance < this.attackRange!.min! / 2) {
      return true;
    } else {
      return false;
    }
  }

  int attack() {
    int damage = Random().nextInt(6) + 1;
    return damage;
  }

  void look() {
    this.canSeeInvisible = true;
  }

  void defend() {
    int protect = Random().nextInt(6) + 1;
    increaseTempArmor(protect);
  }

  void increaseTempArmor(int value) {
    this.tempArmor = this.tempArmor! + value;
  }

  void clearTempEffects() {
    this.tempArmor = 0;
    this.canSeeInvisible = false;
  }

  void takeDamage(int damageRoll, pDamage, mDamage) {
    if (this.tempArmor! > 0) {
      int damage = pDamage + mDamage + damageRoll;

      this.life!.reduceCurrentLife(calculateTempArmor(damage));
      return;
    }

    int damageLeftOver = 0;
    int protectionLeftOver = 0;

    int pDamageCalculation = pDamage - this.pArmor;
    if (pDamageCalculation >= 0) {
      damageLeftOver += pDamageCalculation;
    } else {
      protectionLeftOver -= pDamageCalculation;
    }

    int mDamageCalculation = mDamage - this.mArmor;
    if (mDamageCalculation >= 0) {
      damageLeftOver += mDamageCalculation;
    } else {
      protectionLeftOver -= mDamageCalculation;
    }

    int partialDamage = damageRoll - protectionLeftOver;
    if (partialDamage < 1) {
      partialDamage = 0;
    }

    int totalDamageReceived = partialDamage + damageLeftOver;

    if (totalDamageReceived < 0) {
      totalDamageReceived = 0;
    }

    this.life!.reduceCurrentLife(totalDamageReceived);
  }

  int calculateTempArmor(int damage) {
    int totalDamageReceived =
        damage - this.tempArmor! - this.pArmor! - this.mArmor!;

    decreaseTempArmor(damage);

    if (totalDamageReceived < 0) {
      totalDamageReceived = 0;
    }

    return totalDamageReceived;
  }

  void decreaseTempArmor(int value) async {
    this.tempArmor = this.tempArmor! - value;
    if (this.tempArmor! < 0) {
      this.tempArmor = 0;
    }
  }

  void equipItem(Item item) async {
    this.pDamage = this.pDamage! + item.pDamage!;
    this.mDamage = this.mDamage! + item.mDamage!;
    this.pArmor = this.pArmor! + item.pArmor!;
    this.mArmor = this.mArmor! + item.mArmor!;
    this.attackRange!.max = this.attackRange!.max! + item.maxWeaponRange!;
    this.attackRange!.min = this.attackRange!.min! + item.minWeaponRange!;

    switch (item.itemSlot) {
      case 'oneHand':
        if (this.mainHandSlot!.name != '' && this.offHandSlot!.name != '') {
          unequip(this.mainHandSlot!, 'mainHandSlot');
        }
        if (this.mainHandSlot!.name != '') {
          this.offHandSlot = item;
        } else {
          this.mainHandSlot = item;
        }
        break;
      case 'twoHands':
        if (this.mainHandSlot!.name != '') {
          unequip(this.mainHandSlot!, 'mainHandSlot');
        }
        if (this.offHandSlot!.name != '') {
          unequip(this.offHandSlot!, 'offHandSlot');
        }

        this.mainHandSlot = item;
        this.offHandSlot = item;

        break;
      case 'head':
        if (this.headSlot!.name != '') {
          unequip(this.headSlot!, 'headSlot');
        }
        this.headSlot = item;

        break;
      case 'body':
        if (this.bodySlot!.name != '') {
          unequip(this.bodySlot!, 'bodySlot');
        }
        this.bodySlot = item;

        break;
      case 'hands':
        if (this.handSlot!.name != '') {
          unequip(this.handSlot!, 'handSlot');
        }
        this.handSlot = item;

        break;
      case 'feet':
        if (this.feetSlot!.name != '') {
          unequip(this.feetSlot!, 'feetSlot');
        }
        this.feetSlot = item;

        break;
    }

    this.bag!.remove(item);
  }

  void unequip(Item item, String itemSlot) async {
    this.pDamage = this.pDamage! - item.pDamage!;
    this.mDamage = this.mDamage! - item.mDamage!;
    this.pArmor = this.pArmor! - item.pArmor!;
    this.mArmor = this.mArmor! - item.mArmor!;
    this.attackRange!.max = this.attackRange!.max! - item.maxWeaponRange!;
    this.attackRange!.min = this.attackRange!.min! - item.minWeaponRange!;

    switch (item.itemSlot) {
      case 'oneHand':
        if (itemSlot == 'mainHandSlot') {
          this.mainHandSlot = Item.empty();
        } else {
          this.offHandSlot = Item.empty();
        }
        break;
      case 'twoHands':
        this.mainHandSlot = Item.empty();
        this.offHandSlot = Item.empty();
        break;

      case 'head':
        this.headSlot = Item.empty();

        break;
      case 'body':
        this.bodySlot = Item.empty();

        break;
      case 'hands':
        this.handSlot = Item.empty();

        break;
      case 'feet':
        this.feetSlot = Item.empty();

        break;
    }

    this.bag!.add(item);
  }

  void getItem(Item item) {
    this.weight!.current = this.weight!.current! + item.weight!;
    this.bag!.add(item);
  }

  void destroyItem(Item item) {
    this.weight!.current = this.weight!.current! - item.weight!;
    this.bag!.remove(item);
  }
}

class PlayerAction {
  bool? firstAction;
  bool? secondAction;
  PlayerAction(
      {int? index, String? id, bool? firstAction, bool? secondAction}) {
    this.firstAction = firstAction;
    this.secondAction = secondAction;
  }

  factory PlayerAction.fromMap(Map<String, dynamic>? data) {
    return PlayerAction(
      firstAction: data?['firstAction'],
      secondAction: data?['secondAction'],
    );
  }
  Map<String, dynamic> toMap() {
    return {
      'firstAction': this.firstAction,
      'secondAction': this.secondAction,
    };
  }

  factory PlayerAction.empty() {
    return PlayerAction(
      firstAction: false,
      secondAction: false,
    );
  }

  void newActions() {
    this.firstAction = true;
    this.secondAction = true;
  }

  void takeAction() {
    if (this.firstAction!) {
      this.firstAction = false;
    } else {
      this.secondAction = false;
    }
  }

  bool outOfActions() {
    if (this.secondAction!) {
      return false;
    } else {
      return true;
    }
  }
}

class PlayerLocation {
  double? dx;
  double? dy;
  PlayerLocation({double? dx, double? dy}) {
    this.dx = dx;
    this.dy = dy;
  }
  Map<String, dynamic> toMap() {
    return {
      'dx': this.dx,
      'dy': this.dy,
    };
  }

  factory PlayerLocation.fromMap(Map<String, dynamic>? data) {
    return PlayerLocation(
      dx: data?['dx'] * 1.0,
      dy: data?['dy'] * 1.0,
    );
  }
  factory PlayerLocation.newLocation(Offset location) {
    return PlayerLocation(
      dx: location.dx,
      dy: location.dy,
    );
  }

  Offset getLocation() {
    return Offset(this.dx!.toDouble(), this.dy!.toDouble());
  }
}

class PlayerTempLocation extends ChangeNotifier {
  double? dx;
  double? dy;
  PlayerTempLocation({double? dx, double? dy}) {
    this.dx = dx;
    this.dy = dy;
  }

  void walk(double dx, double dy) {
    this.dx = this.dx! + dx;
    this.dy = this.dy! + dy;
    notifyListeners();
  }

  void updatePlayerLocation(double? dx, double? dy) {
    this.dx = dx;
    this.dy = dy;
  }
}

class PlayerLife {
  int? max;
  int? current;
  PlayerLife({int? max, int? current}) {
    this.max = max;
    this.current = current;
  }
  Map<String, dynamic> toMap() {
    return {
      'max': this.max,
      'current': this.current,
    };
  }

  factory PlayerLife.fromMap(Map<String, dynamic>? data) {
    return PlayerLife(
      max: data?['max'],
      current: data?['current'],
    );
  }

  factory PlayerLife.set(String race) {
    int max;
    int current;
    if (race == 'dwarf') {
      max = 20;
    } else {
      max = 16;
    }
    current = max;
    return PlayerLife(max: max, current: current);
  }

  void reduceCurrentLife(int value) async {
    this.current = this.current! - value;
  }

  void increaseCurrentLife(int value) {
    this.current = this.current! + value;
  }

  bool isDead() {
    if (this.current! < 1) {
      return true;
    } else {
      return false;
    }
  }
}

class PlayerWeight {
  int? max;
  int? current;
  PlayerWeight({int? max, int? current}) {
    this.max = max;
    this.current = current;
  }
  Map<String, dynamic> toMap() {
    return {
      'max': this.max,
      'current': this.current,
    };
  }

  factory PlayerWeight.fromMap(Map<String, dynamic>? data) {
    return PlayerWeight(
      max: data?['max'],
      current: data?['current'],
    );
  }

  factory PlayerWeight.set(String race) {
    int max;
    if (race == 'orc') {
      max = 18;
    } else {
      max = 14;
    }
    return PlayerWeight(max: max, current: 0);
  }

  bool cantCarry(int newWeight) {
    if (this.current! + newWeight > this.max!) {
      return true;
    } else {
      return false;
    }
  }
}

class PlayerAttackRange {
  double? min;
  double? max;
  PlayerAttackRange({double? min, double? max}) {
    this.min = min;
    this.max = max;
  }
  Map<String, dynamic> toMap() {
    return {
      'min': this.min,
      'max': this.max,
    };
  }

  factory PlayerAttackRange.fromMap(Map<String, dynamic>? data) {
    return PlayerAttackRange(
      min: data?['min'] * 1.0,
      max: data?['max'] * 1.0,
    );
  }
  factory PlayerAttackRange.set(String race) {
    return PlayerAttackRange(min: 0, max: 30);
  }
}

class PlayerWalkRange {
  double? min;
  double? max;
  PlayerWalkRange({double? min, double? max}) {
    this.min = min;
    this.max = max;
  }
  Map<String, dynamic> toMap() {
    return {
      'min': this.min,
      'max': this.max,
    };
  }

  factory PlayerWalkRange.fromMap(Map<String, dynamic>? data) {
    return PlayerWalkRange(
      min: data?['min'] * 1.0,
      max: data?['max'] * 1.0,
    );
  }
  factory PlayerWalkRange.set(String race) {
    return PlayerWalkRange(min: 0, max: 60);
  }
}

class PlayerVisionRange {
  double? min;
  double? max;
  PlayerVisionRange({double? min, double? max}) {
    this.min = min;
    this.max = max;
  }
  Map<String, dynamic> toMap() {
    return {
      'min': this.min,
      'max': this.max,
    };
  }

  factory PlayerVisionRange.fromMap(Map<String, dynamic>? data) {
    return PlayerVisionRange(
      min: data?['min'] * 1.0,
      max: data?['max'] * 1.0,
    );
  }
  factory PlayerVisionRange.set(String race) {
    double max;
    if (race == 'elf') {
      max = 150.0;
    } else {
      max = 120.0;
    }

    return PlayerVisionRange(min: 0, max: max);
  }
}
