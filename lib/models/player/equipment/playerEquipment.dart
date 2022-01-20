import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dsixv02app/models/player/equipment/playerArmor.dart';
import 'package:dsixv02app/models/player/equipment/playerAttackRange.dart';
import 'package:dsixv02app/models/player/equipment/playerDamage.dart';
import 'package:dsixv02app/models/shop/item.dart';

import 'playerWeight.dart';

class PlayerEquipment {
  PlayerArmor? armor;
  PlayerDamage? damage;
  PlayerAttackRange? attackRange;
  Item? mainHandSlot;
  Item? offHandSlot;
  Item? headSlot;
  Item? bodySlot;
  Item? handSlot;
  Item? feetSlot;
  List<Item>? bag;
  PlayerWeight? weight;

  PlayerEquipment({
    PlayerArmor? armor,
    PlayerDamage? damage,
    PlayerAttackRange? attackRange,
    Item? mainHandSlot,
    Item? offHandSlot,
    Item? headSlot,
    Item? bodySlot,
    Item? handSlot,
    Item? feetSlot,
    List<Item>? bag,
    PlayerWeight? weight,
  }) {
    this.armor = armor;
    this.damage = damage;
    this.attackRange = attackRange;
    this.mainHandSlot = mainHandSlot;
    this.offHandSlot = offHandSlot;
    this.headSlot = headSlot;
    this.bodySlot = bodySlot;
    this.handSlot = handSlot;
    this.feetSlot = feetSlot;
    this.bag = bag;
    this.weight = weight;
  }

  Map<String, dynamic> toMap() {
    var bag = this.bag?.map((item) => item.toMap()).toList();

    return {
      'armor': this.armor?.toMap(),
      'damage': this.damage?.toMap(),
      'attackRange': this.attackRange?.toMap(),
      'mainHandSlot': this.mainHandSlot?.toMap(),
      'offHandSlot': this.offHandSlot?.toMap(),
      'headSlot': this.headSlot?.toMap(),
      'bodySlot': this.bodySlot?.toMap(),
      'handSlot': this.handSlot?.toMap(),
      'feetSlot': this.feetSlot?.toMap(),
      'bag': bag,
      'weight': this.weight?.toMap(),
    };
  }

  factory PlayerEquipment.fromMap(Map<String, dynamic>? data) {
    List<Item> bag = [];
    List<dynamic> bagMap = data?['bag'];
    bagMap.forEach((item) {
      bag.add(new Item.fromMap(item));
    });

    return PlayerEquipment(
      armor: PlayerArmor.fromMap(data?['armor']),
      damage: PlayerDamage.fromMap(data?['damage']),
      attackRange: PlayerAttackRange.fromMap(data?['attackRange']),
      mainHandSlot: Item.fromMap(data?['mainHandSlot']),
      offHandSlot: Item.fromMap(data?['offHandSlot']),
      headSlot: Item.fromMap(data?['headSlot']),
      bodySlot: Item.fromMap(data?['bodySlot']),
      handSlot: Item.fromMap(data?['handSlot']),
      feetSlot: Item.fromMap(data?['feetSlot']),
      bag: bag,
      weight: PlayerWeight.fromMap(data?['weight']),
    );
  }
  factory PlayerEquipment.empty(String randomRace) {
    return PlayerEquipment(
      armor: PlayerArmor.empty(),
      damage: PlayerDamage.empty(),
      attackRange: PlayerAttackRange.empty(),
      mainHandSlot: Item.empty(),
      offHandSlot: Item.empty(),
      headSlot: Item.empty(),
      bodySlot: Item.empty(),
      handSlot: Item.empty(),
      feetSlot: Item.empty(),
      bag: [],
      weight: PlayerWeight.set(randomRace),
    );
  }

  void getItem(String gameID, String playerID, Item item) {
    this.weight!.current = this.weight!.current! + item.weight!;

    switch (item.itemSlot) {
      case 'oneHand':
        break;
      case 'twoHands':
        break;
      case 'head':
        break;
      case 'body':
        break;
      case 'hands':
        break;
      case 'feet':
        break;
      case 'consumable':
        break;
    }

    this.bag!.add(item);
    update(gameID, playerID);
  }

  void equip(String gameID, String playerID, Item item) {
    this.attackRange!.increase(item);
    this.damage!.increasePDamage(item.pDamage!);
    this.damage!.increaseMDamage(item.mDamage!);
    this.armor!.increasePArmor(item.pArmor!);
    this.armor!.increaseMArmor(item.mArmor!);

    switch (item.itemSlot) {
      case 'oneHand':
        if (mainHandSlot!.name != '' && offHandSlot!.name != '') {
          unequip(gameID, playerID, this.mainHandSlot!);
        }
        if (mainHandSlot!.name != '') {
          offHandSlot = item;
        } else {
          mainHandSlot = item;
        }
        break;
      case 'twoHands':
        if (mainHandSlot!.name != '') {
          unequip(gameID, playerID, mainHandSlot!);
        }
        if (offHandSlot!.name != '') {
          unequip(gameID, playerID, offHandSlot!);
        }

        mainHandSlot = item;
        offHandSlot = item;

        break;
      case 'head':
        if (headSlot!.name != '') {
          unequip(gameID, playerID, headSlot!);
        }
        headSlot = item;

        break;
      case 'body':
        if (bodySlot!.name != '') {
          unequip(gameID, playerID, bodySlot!);
        }
        bodySlot = item;

        break;
      case 'hands':
        if (handSlot!.name != '') {
          unequip(gameID, playerID, handSlot!);
        }
        handSlot = item;

        break;
      case 'feet':
        if (feetSlot!.name != '') {
          unequip(gameID, playerID, feetSlot!);
        }
        feetSlot = item;

        break;
    }
    this.bag!.remove(item);
    update(gameID, playerID);
  }

  void unequip(String gameID, String playerID, Item item) async {
    this.attackRange!.decrease(item);
    this.damage!.decreasePDamage(item.pDamage!);
    this.damage!.decreaseMDamage(item.mDamage!);
    this.armor!.decreasePArmor(item.pArmor!);
    this.armor!.decreaseMArmor(item.mArmor!);

    switch (item.itemSlot) {
      case 'oneHand':
        if (item == this.mainHandSlot) {
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
    update(gameID, playerID);
  }

  void destroyItem(String gameID, String playerIndex, Item item) {
    this.weight!.current = this.weight!.current! - item.weight!;
    this.bag!.remove(item);
    update(gameID, playerIndex);
  }

  bool rangedAttack() {
    if (this.mainHandSlot!.type == 'ranged' ||
        this.offHandSlot!.type == 'ranged') {
      return true;
    } else {
      return false;
    }
  }

  void update(String gameID, String playerID) async {
    final database = FirebaseFirestore.instance.collection('game');

    await database
        .doc(gameID)
        .collection('players')
        .doc(playerID)
        .update({'equipment': toMap()});
  }
}
