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
  ItemSlot? mainHandSlot;
  ItemSlot? offHandSlot;
  ItemSlot? headSlot;
  ItemSlot? bodySlot;
  ItemSlot? handSlot;
  ItemSlot? feetSlot;
  List<Item>? bag;
  PlayerWeight? weight;

  PlayerEquipment({
    PlayerArmor? armor,
    PlayerDamage? damage,
    PlayerAttackRange? attackRange,
    ItemSlot? mainHandSlot,
    ItemSlot? offHandSlot,
    ItemSlot? headSlot,
    ItemSlot? bodySlot,
    ItemSlot? handSlot,
    ItemSlot? feetSlot,
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
      mainHandSlot: ItemSlot.fromMap(data?['mainHandSlot']),
      offHandSlot: ItemSlot.fromMap(data?['offHandSlot']),
      headSlot: ItemSlot.fromMap(data?['headSlot']),
      bodySlot: ItemSlot.fromMap(data?['bodySlot']),
      handSlot: ItemSlot.fromMap(data?['handSlot']),
      feetSlot: ItemSlot.fromMap(data?['feetSlot']),
      bag: bag,
      weight: PlayerWeight.fromMap(data?['weight']),
    );
  }
  factory PlayerEquipment.empty(String randomRace) {
    return PlayerEquipment(
      armor: PlayerArmor.empty(),
      damage: PlayerDamage.empty(),
      attackRange: PlayerAttackRange.empty(),
      mainHandSlot: ItemSlot.empty(),
      offHandSlot: ItemSlot.empty(),
      headSlot: ItemSlot.empty(),
      bodySlot: ItemSlot.empty(),
      handSlot: ItemSlot.empty(),
      feetSlot: ItemSlot.empty(),
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

  void equip(
    String gameID,
    String playerID,
    ItemSlot itemSlot,
    Item item,
  ) {
    if (itemSlot.isEmpty!) {
      this.bag!.remove(item);
      increaseDamageAndArmor(item);
      itemSlot.equip(item);
      update(gameID, playerID);
      return;
    }
    unequip(gameID, playerID, itemSlot);
    this.bag!.remove(item);
    increaseDamageAndArmor(item);
    itemSlot.equip(item);
    update(gameID, playerID);
  }

  void increaseDamageAndArmor(Item item) {
    this.attackRange!.increase(item);
    this.damage!.increasePDamage(item.pDamage!);
    this.damage!.increaseMDamage(item.mDamage!);
    this.armor!.increasePArmor(item.pArmor!);
    this.armor!.increaseMArmor(item.mArmor!);
  }

  void unequip(
    String gameID,
    String playerID,
    ItemSlot itemSlot,
  ) {
    decreaseDamageAndArmor(itemSlot.item!);
    this.bag!.add(itemSlot.item!);
    itemSlot.empty();
  }

  void decreaseDamageAndArmor(Item item) {
    this.attackRange!.decrease(item);
    this.damage!.decreasePDamage(item.pDamage!);
    this.damage!.decreaseMDamage(item.mDamage!);
    this.armor!.decreasePArmor(item.pArmor!);
    this.armor!.decreaseMArmor(item.mArmor!);
  }

  void destroyItem(String gameID, String playerIndex, Item item) {
    this.weight!.current = this.weight!.current! - item.weight!;
    this.bag!.remove(item);
    update(gameID, playerIndex);
  }

  bool rangedAttack() {
    if (this.mainHandSlot!.item!.type == 'ranged' ||
        this.offHandSlot!.item!.type == 'ranged') {
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

class ItemSlot {
  bool? isEmpty;
  Item? item;
  ItemSlot({bool? isEmpty, Item? item}) {
    this.isEmpty = isEmpty;
    this.item = item;
  }

  Map<String, dynamic> toMap() {
    return {
      'isEmpty': this.isEmpty,
      'item': this.item?.toMap(),
    };
  }

  factory ItemSlot.fromMap(Map<String, dynamic>? data) {
    return ItemSlot(
      isEmpty: data?['isEmpty'],
      item: Item.fromMap(data?['item']),
    );
  }
  factory ItemSlot.empty() {
    return ItemSlot(
      isEmpty: true,
      item: Item.empty(),
    );
  }

  void equip(Item item) {
    this.isEmpty = false;
    this.item = item;
  }

  void empty() {
    this.isEmpty = true;
    this.item = Item.empty();
  }
}
