import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dsixv02app/models/player/player.dart';
import 'package:dsixv02app/models/shop/item.dart';
import 'package:dsixv02app/models/shop/shop.dart';
import 'package:flutter/material.dart';
import 'loot.dart';
import 'lootSprite.dart';

class LootController {
  final db = FirebaseFirestore.instance;
  Shop _shop = Shop();

  Stream<List<Loot>> pullLootFromDataBase() {
    return db.collection('loot').snapshots().map((querySnapshot) =>
        querySnapshot.docs.map((loot) => Loot.fromMap(loot.data())).toList());
  }

  List<Loot> listOfRandomLoot = [];
  void createListOfRandomLootInRandomLocation(
      int numberOfLoot, double mapSize) {
    listOfRandomLoot = [];
    for (int i = 0; i < numberOfLoot; i++) {
      addLootToDataBase(Loot.newLoot(
          lootRandomLocation(mapSize), lootRandomLocation(mapSize), i));
    }
  }

  double lootRandomLocation(double mapSize) {
    //For dev (spawn players closer together)
    // return (Random().nextDouble() * mapSize * 0.1) + (mapSize * 0.35);
    //Original
    return (Random().nextDouble() * mapSize * 0.8) + (mapSize * 0.1);
  }

  void addLootToDataBase(Loot loot) {
    db.collection('loot').doc('${loot.index}').set(loot.saveToDataBase(loot));
  }

  void openLoot(int lootIndex) async {
    List<Item> itemsInside = [];

    int numberOfLoot = Random().nextInt(3) + 1;

    for (int i = 0; i < numberOfLoot; i++) {
      itemsInside.add(_shop.randomItem());
    }

    var uploadItems = itemsInside.map((item) => item.toMap()).toList();

    await db
        .collection('loot')
        .doc('$lootIndex')
        .update({'isClosed': false, 'items': uploadItems});
  }

  void updateLootItems(int lootIndex, List<Item> itemsInside) async {
    if (itemsInside.isEmpty) {
      return;
    }

    var uploadItems = itemsInside.map((item) => item.toMap()).toList();

    await db
        .collection('loot')
        .doc('$lootIndex')
        .update({'isClosed': false, 'items': uploadItems});
  }

  void deleteAllLootFromDataBase() async {
    var batch = db.batch();
    await db.collection('loot').get().then((snapshot) {
      snapshot.docs.forEach((document) {
        batch.delete(document.reference);
      });
    });

    batch.commit();
  }

  List<LootSprite> loot = [];

  void updateLootInSight(List<Loot> loot, Player selectedPlayer) {
    this.loot = [];
    loot.forEach((target) {
      if (selectedPlayer.cantSee(Offset(target.dx, target.dy))) {
        return;
      }
      this.loot.add(LootSprite(
            lootIndex: target.index,
            dx: target.dx,
            dy: target.dy,
            isClosed: target.isClosed,
          ));
    });
  }
}
