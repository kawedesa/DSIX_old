import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dsixv02app/models/player/equipment/playerArmor.dart';
import 'package:dsixv02app/models/player/equipment/playerAttackRange.dart';
import 'package:dsixv02app/models/player/equipment/playerDamage.dart';
import 'package:dsixv02app/models/shop/item.dart';

import 'equipmentSlot.dart';
import 'playerWeight.dart';

class PlayerEquipment {
  PlayerArmor? armor;
  PlayerDamage? damage;
  PlayerAttackRange? attackRange;
  EquipmentSlot? mainHandSlot;
  EquipmentSlot? offHandSlot;
  EquipmentSlot? headSlot;
  EquipmentSlot? bodySlot;
  EquipmentSlot? handSlot;
  EquipmentSlot? feetSlot;
  List<EquipmentSlot>? bag;
  PlayerWeight? weight;

  PlayerEquipment({
    PlayerArmor? armor,
    PlayerDamage? damage,
    PlayerAttackRange? attackRange,
    EquipmentSlot? mainHandSlot,
    EquipmentSlot? offHandSlot,
    EquipmentSlot? headSlot,
    EquipmentSlot? bodySlot,
    EquipmentSlot? handSlot,
    EquipmentSlot? feetSlot,
    List<EquipmentSlot>? bag,
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
    var bag = this.bag?.map((equipmentSlot) => equipmentSlot.toMap()).toList();

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
    List<EquipmentSlot> bag = [];
    List<dynamic> bagMap = data?['bag'];
    bagMap.forEach((slot) {
      bag.add(new EquipmentSlot.fromMap(slot));
    });

    return PlayerEquipment(
      armor: PlayerArmor.fromMap(data?['armor']),
      damage: PlayerDamage.fromMap(data?['damage']),
      attackRange: PlayerAttackRange.fromMap(data?['attackRange']),
      mainHandSlot: EquipmentSlot.fromMap(data?['mainHandSlot']),
      offHandSlot: EquipmentSlot.fromMap(data?['offHandSlot']),
      headSlot: EquipmentSlot.fromMap(data?['headSlot']),
      bodySlot: EquipmentSlot.fromMap(data?['bodySlot']),
      handSlot: EquipmentSlot.fromMap(data?['handSlot']),
      feetSlot: EquipmentSlot.fromMap(data?['feetSlot']),
      bag: bag,
      weight: PlayerWeight.fromMap(data?['weight']),
    );
  }
  factory PlayerEquipment.empty(String randomRace) {
    return PlayerEquipment(
      armor: PlayerArmor.empty(),
      damage: PlayerDamage.empty(),
      attackRange: PlayerAttackRange.empty(),
      mainHandSlot: EquipmentSlot.empty('mainHandSlot'),
      offHandSlot: EquipmentSlot.empty('offHandSlot'),
      headSlot: EquipmentSlot.empty('headSlot'),
      bodySlot: EquipmentSlot.empty('bodySlot'),
      handSlot: EquipmentSlot.empty('handSlot'),
      feetSlot: EquipmentSlot.empty('feetSlot'),
      bag: [],
      weight: PlayerWeight.set(randomRace),
    );
  }

  void getItem(String gameID, String playerID, Item item) {
    this.weight!.current = this.weight!.current! + item.weight!;
    update(gameID, playerID);
  }

  void addItemToBag(String gameID, String playerID, Item item) {
    this.bag!.add(EquipmentSlot.fromItem('bag', item));
    update(gameID, playerID);
  }

  void removeItemFromBag(
      String gameID, String playerID, EquipmentSlot equipmentSlot) {
    this.bag!.remove(equipmentSlot);
    update(gameID, playerID);
  }

  void removeItem(String gameID, String playerID, EquipmentSlot equipmentSlot) {
    this.weight!.current = this.weight!.current! - equipmentSlot.item!.weight!;
    update(gameID, playerID);
  }

  void equipItem(
    String gameID,
    String playerID,
    EquipmentSlot equipmentSlot,
    EquipmentSlot item,
  ) {
    increaseDamageAndArmor(item.item!);

    if (item.item!.itemSlot == 'twoHands') {
      unequip(gameID, playerID, this.mainHandSlot!);
      unequip(gameID, playerID, this.offHandSlot!);
      this.mainHandSlot!.item = item.item;
      this.offHandSlot!.item = item.item;
    } else {
      unequip(gameID, playerID, equipmentSlot);
      equipmentSlot.item = item.item;
    }

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
    EquipmentSlot equipmentSlot,
  ) {
    if (equipmentSlot.isEmpty()) {
      return;
    }

    decreaseDamageAndArmor(equipmentSlot.item!);
    this.bag!.add(EquipmentSlot.fromItem('bag', equipmentSlot.item!));

    if (equipmentSlot.item!.itemSlot == 'twoHands') {
      this.mainHandSlot!.unequip();
      this.offHandSlot!.unequip();
    } else {
      equipmentSlot.unequip();
    }

    update(gameID, playerID);
  }

  void emptySlot(
    String gameID,
    String playerID,
    EquipmentSlot equipmentSlot,
  ) {
    if (equipmentSlot.isEmpty()) {
      return;
    }
    decreaseDamageAndArmor(equipmentSlot.item!);

    if (equipmentSlot.item!.itemSlot == 'twoHands') {
      this.mainHandSlot!.unequip();
      this.offHandSlot!.unequip();
    } else {
      equipmentSlot.unequip();
    }
    update(gameID, playerID);
  }

  void decreaseDamageAndArmor(Item item) {
    this.attackRange!.decrease(item);
    this.damage!.decreasePDamage(item.pDamage!);
    this.damage!.decreaseMDamage(item.mDamage!);
    this.armor!.decreasePArmor(item.pArmor!);
    this.armor!.decreaseMArmor(item.mArmor!);
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
