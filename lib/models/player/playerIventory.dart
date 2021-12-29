import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dsixv02app/models/shop/item.dart';

import 'playerWeight.dart';

class PlayerIventory {
  Item? mainHandSlot;
  Item? offHandSlot;
  Item? headSlot;
  Item? bodySlot;
  Item? handSlot;
  Item? feetSlot;
  List<Item>? bag;
  PlayerWeight? weight;

  PlayerIventory({
    Item? mainHandSlot,
    Item? offHandSlot,
    Item? headSlot,
    Item? bodySlot,
    Item? handSlot,
    Item? feetSlot,
    List<Item>? bag,
    PlayerWeight? weight,
  }) {
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

  factory PlayerIventory.fromMap(Map<String, dynamic>? data) {
    List<Item> bag = [];
    List<dynamic> bagMap = data?['bag'];
    bagMap.forEach((item) {
      bag.add(new Item.fromMap(item));
    });

    return PlayerIventory(
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
  factory PlayerIventory.empty(String randomRace) {
    return PlayerIventory(
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

  void unequip(Item item) async {
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
  }

  void getItem(String gameID, String playerIndex, Item item) {
    this.weight!.current = this.weight!.current! + item.weight!;
    this.bag!.add(item);
    update(gameID, playerIndex);
  }

  void destroyItem(String gameID, String playerIndex, Item item) {
    this.weight!.current = this.weight!.current! - item.weight!;
    this.bag!.remove(item);
    update(gameID, playerIndex);
  }

  void update(String gameID, String playerIndex) async {
    final database = FirebaseFirestore.instance.collection('game');

    await database
        .doc(gameID)
        .collection('players')
        .doc(playerIndex)
        .update({'iventory': toMap()});
  }
}
