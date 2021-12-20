import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dsixv02app/models/shop/item.dart';
import 'package:flutter/material.dart';

class Player {
  String id;
  double dx;
  double dy;
  String race;
  double visionRange;
  double walkRange;
  double maxAttackRange;
  double minAttackRange;
  int life;
  int maxLife;
  int weight;
  int maxWeight;
  int pDamage;
  int mDamage;
  int pArmor;
  int mArmor;
  int tempArmor;
  Item mainHandSlot;
  Item offHandSlot;
  Item headSlot;
  Item bodySlot;
  Item handSlot;
  Item feetSlot;
  List<Item> bag;
  Player(
      {String id,
      double dx,
      double dy,
      String race,
      double vision,
      double walkRange,
      double maxAttackRange,
      double minAttackRange,
      int life,
      int maxLife,
      int weight,
      int maxWeight,
      int pDamage,
      int mDamage,
      int pArmor,
      int mArmor,
      int tempArmor,
      Item mainHandSlot,
      Item offHandSlot,
      Item headSlot,
      Item bodySlot,
      Item handSlot,
      Item feetSlot,
      List<Item> bag}) {
    this.id = id;
    this.dx = dx;
    this.dy = dy;
    this.race = race;
    this.visionRange = vision;
    this.walkRange = walkRange;
    this.maxAttackRange = maxAttackRange;
    this.minAttackRange = minAttackRange;
    this.life = life;
    this.maxLife = maxLife;
    this.weight = weight;
    this.maxWeight = maxWeight;
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
  }

  final db = FirebaseFirestore.instance;

  Map<String, dynamic> toMap(Player player) {
    var bag = player.bag.map((item) => item.toMap()).toList();

    return {
      'id': player.id,
      'dx': player.dx,
      'dy': player.dy,
      'race': player.race,
      'visionRange': player.visionRange,
      'walkRange': player.walkRange,
      'maxAttackRange': player.maxAttackRange,
      'minAttackRange': player.minAttackRange,
      'life': player.life,
      'maxLife': player.maxLife,
      'weight': player.weight,
      'maxWeight': player.maxWeight,
      'pDamage': player.pDamage,
      'mDamage': player.mDamage,
      'pArmor': player.pArmor,
      'mArmor': player.mArmor,
      'tempArmor': player.tempArmor,
      'mainHandSlot': player.mainHandSlot.toMap(),
      'offHandSlot': player.offHandSlot.toMap(),
      'headSlot': player.headSlot.toMap(),
      'bodySlot': player.bodySlot.toMap(),
      'handSlot': player.handSlot.toMap(),
      'feetSlot': player.feetSlot.toMap(),
      'bag': bag,
    };
  }

  factory Player.fromMap(Map data) {
    List<Item> bag = [];
    List<dynamic> bagMap = data['bag'];
    bagMap.forEach((item) {
      bag.add(new Item.fromMap(item));
    });

    return Player(
      id: data['id'],
      dx: data['dx'] * 1.0,
      dy: data['dy'] * 1.0,
      race: data['race'],
      vision: data['visionRange'] * 1.0,
      walkRange: data['walkRange'] * 1.0,
      maxAttackRange: data['maxAttackRange'] * 1.0,
      minAttackRange: data['minAttackRange'] * 1.0,
      life: data['life'],
      maxLife: data['maxLife'],
      weight: data['weight'],
      maxWeight: data['maxWeight'],
      pDamage: data['pDamage'],
      mDamage: data['mDamage'],
      pArmor: data['pArmor'],
      mArmor: data['mArmor'],
      tempArmor: data['tempArmor'],
      mainHandSlot: Item.fromMap(data['mainHandSlot']),
      offHandSlot: Item.fromMap(data['offHandSlot']),
      headSlot: Item.fromMap(data['headSlot']),
      bodySlot: Item.fromMap(data['bodySlot']),
      handSlot: Item.fromMap(data['handSlot']),
      feetSlot: Item.fromMap(data['feetSlot']),
      bag: bag,
    );
  }

  factory Player.newRandomPlayer(double dx, double dy, int playerIndex) {
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
    int randomRace = Random().nextInt(races.length);

    return Player(
      id: id[playerIndex],
      dx: dx,
      dy: dy,
      race: races[randomRace],
      vision: 0,
      walkRange: 0,
      maxAttackRange: 0,
      minAttackRange: 0,
      life: 0,
      maxLife: 0,
      weight: 0,
      maxWeight: 0,
      pDamage: 0,
      mDamage: 0,
      pArmor: 0,
      mArmor: 0,
      tempArmor: 0,
      mainHandSlot: Item.emptyItem(),
      offHandSlot: Item.emptyItem(),
      headSlot: Item.emptyItem(),
      bodySlot: Item.emptyItem(),
      handSlot: Item.emptyItem(),
      feetSlot: Item.emptyItem(),
      bag: [],
    );
  }

  void setVisionRange() {
    if (this.race == 'elf') {
      this.visionRange = 130.0;
      return;
    }
    this.visionRange = 100.0;
  }

  void setWalkRange() {
    this.walkRange = 50.0;
  }

  void setAttackRange() {
    this.maxAttackRange = 30.0;
    this.minAttackRange = 0.0;
  }

  void setLife() {
    if (this.race == 'dwarf') {
      this.maxLife = 20;
      this.life = 20;
      return;
    }
    this.maxLife = 16;
    this.life = 16;
  }

  void setWeight() {
    if (this.race == 'orc') {
      this.maxWeight = 18;
      this.weight = 0;
      return;
    }
    this.maxWeight = 14;
    this.weight = 0;
  }

  void reduceCurrentLife(int value) async {
    this.life -= value;
    await db.collection('players').doc(this.id).update({'life': this.life});
  }

  void increaseCurrentLife(int value) {
    this.life += value;
  }

  bool isDead() {
    if (this.life < 1) {
      return true;
    } else {
      return false;
    }
  }

  bool cantCarry(int newWeight) {
    if (this.weight + newWeight > this.maxWeight) {
      return true;
    } else {
      return false;
    }
  }

  bool cantSee(Offset targetLocation) {
    double distance = (targetLocation - getLocation()).distance;
    if (distance > this.visionRange / 2) {
      return true;
    } else {
      return false;
    }
  }

  bool cantReach(Offset targetLocation) {
    double distance = (targetLocation -
            Offset(
              getLocation().dx,
              getLocation().dy - 5,
            ))
        .distance;
    if (distance > 15) {
      return true;
    } else {
      return false;
    }
  }

  bool cantAttack(Offset targetLocation) {
    double distance = (targetLocation -
            Offset(
              getLocation().dx,
              getLocation().dy,
            ))
        .distance;
    if (distance > this.maxAttackRange / 2 ||
        distance < this.minAttackRange / 2) {
      return true;
    } else {
      return false;
    }
  }

  Offset getLocation() {
    return Offset(this.dx, this.dy);
  }

  int attack() {
    int damage = Random().nextInt(6) + 1;
    return damage;
  }

  void defend() {
    int protect = Random().nextInt(6) + 1;
    increaseTempArmor(protect);
  }

  void increaseTempArmor(int value) async {
    this.tempArmor += value;
    await db
        .collection('players')
        .doc(this.id)
        .update({'tempArmor': this.tempArmor});
  }

  void clearTempEffects() async {
    this.tempArmor = 0;
    await db
        .collection('players')
        .doc(this.id)
        .update({'tempArmor': this.tempArmor});
  }

  void takeDamage(int damageRoll, pDamage, mDamage) {
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

    partialDamage += damageLeftOver;

    int totalDamageReceived = calculateTempArmor(partialDamage);

    if (totalDamageReceived < 0) {
      totalDamageReceived = 0;
    }

    reduceCurrentLife(totalDamageReceived);
  }

  int calculateTempArmor(int damage) {
    int damageCalculation = damage - this.tempArmor;
    decreaseTempArmor(damage);
    return damageCalculation;
  }

  void decreaseTempArmor(int value) async {
    this.tempArmor -= value;
    if (this.tempArmor < 0) {
      this.tempArmor = 0;
    }
    await db
        .collection('players')
        .doc(this.id)
        .update({'tempArmor': this.tempArmor});
  }

  void equipItem(Item item) async {
    this.pDamage += item.pDamage;
    this.mDamage += item.mDamage;
    this.pArmor += item.pArmor;
    this.mArmor += item.mArmor;
    this.maxAttackRange += item.maxWeaponRange;
    this.minAttackRange += item.minWeaponRange;

    switch (item.itemSlot) {
      case 'oneHand':
        if (this.mainHandSlot.name != '' && this.offHandSlot.name != '') {
          unequip(this.mainHandSlot, 'mainHandSlot');
        }
        if (this.mainHandSlot.name != '') {
          this.offHandSlot = item;
        } else {
          this.mainHandSlot = item;
        }
        break;
      case 'twoHands':
        if (this.mainHandSlot.name != '') {
          unequip(this.mainHandSlot, 'mainHandSlot');
        }
        if (this.offHandSlot.name != '') {
          unequip(this.offHandSlot, 'offHandSlot');
        }

        this.mainHandSlot = item;
        this.offHandSlot = item;

        break;
      case 'head':
        if (this.headSlot.name != '') {
          unequip(this.headSlot, 'headSlot');
        }
        this.headSlot = item;

        break;
      case 'body':
        if (this.bodySlot.name != '') {
          unequip(this.bodySlot, 'bodySlot');
        }
        this.bodySlot = item;

        break;
      case 'hands':
        if (this.handSlot.name != '') {
          unequip(this.handSlot, 'handSlot');
        }
        this.handSlot = item;

        break;
      case 'feet':
        if (this.feetSlot.name != '') {
          unequip(this.feetSlot, 'feetSlot');
        }
        this.feetSlot = item;

        break;
    }

    this.bag.remove(item);

    List<Map<String, dynamic>> updatedBag =
        this.bag.map((item) => item.toMap()).toList();
    updateIventory(updatedBag);
  }

  void unequip(Item item, String itemSlot) async {
    this.pDamage -= item.pDamage;
    this.mDamage -= item.mDamage;
    this.pArmor -= item.pArmor;
    this.mArmor -= item.mArmor;
    this.maxAttackRange -= item.maxWeaponRange;
    this.minAttackRange -= item.minWeaponRange;

    switch (item.itemSlot) {
      case 'oneHand':
        if (itemSlot == 'mainHandSlot') {
          this.mainHandSlot = Item.emptyItem();
        } else {
          this.offHandSlot = Item.emptyItem();
        }
        break;
      case 'twoHands':
        this.mainHandSlot = Item.emptyItem();
        this.offHandSlot = Item.emptyItem();
        break;

      case 'head':
        this.headSlot = Item.emptyItem();

        break;
      case 'body':
        this.bodySlot = Item.emptyItem();

        break;
      case 'hands':
        this.handSlot = Item.emptyItem();

        break;
      case 'feet':
        this.feetSlot = Item.emptyItem();

        break;
    }

    this.bag.add(item);
    List<Map<String, dynamic>> updatedBag =
        this.bag.map((item) => item.toMap()).toList();
    updateIventory(updatedBag);
  }

  void getItem(Item item) {
    this.weight += item.weight;
    this.bag.add(item);
    var updatedBag = this.bag.map((item) => item.toMap()).toList();
    updateBag(updatedBag);
  }

  void destroyItem(Item item) {
    this.weight -= item.weight;
    this.bag.remove(item);
    var updatedBag = this.bag.map((item) => item.toMap()).toList();
    updateBag(updatedBag);
  }

  void updateBag(List<Map<String, dynamic>> updatedBag) async {
    await db.collection('players').doc(this.id).update({
      'bag': updatedBag,
      'weight': this.weight,
    });
  }

  void updateIventory(List<Map<String, dynamic>> updatedBag) async {
    await db.collection('players').doc(this.id).update({
      'bag': updatedBag,
      'mainHandSlot': this.mainHandSlot.toMap(),
      'offHandSlot': this.offHandSlot.toMap(),
      'headSlot': this.headSlot.toMap(),
      'bodySlot': this.bodySlot.toMap(),
      'handSlot': this.handSlot.toMap(),
      'feetSlot': this.feetSlot.toMap(),
      'pDamage': this.pDamage,
      'mDamage': this.mDamage,
      'pArmor': this.pArmor,
      'mArmor': this.mArmor,
      'maxAttackRange': this.maxAttackRange,
      'minAttackRange': this.minAttackRange,
    });
  }
}
