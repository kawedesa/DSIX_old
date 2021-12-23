// import 'dart:math';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:dsixv02app/models/player/player.dart';
// import 'package:dsixv02app/models/shop/item.dart';
// import 'package:dsixv02app/models/shop/shop.dart';
// import 'package:flutter/material.dart';
// import 'loot.dart';
// import 'lootSprite.dart';

import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dsixv02app/models/player/player.dart';
import 'package:dsixv02app/models/shop/item.dart';
import 'package:dsixv02app/models/shop/shop.dart';

import 'loot.dart';
import 'lootSprite.dart';

class LootController {
  final firebase = FirebaseFirestore.instance;

  Stream<List<Loot>> pullLootFromDataBase(String gameID) {
    return firebase
        .collection('game')
        .doc(gameID)
        .collection('loot')
        .snapshots()
        .map((querySnapshot) => querySnapshot.docs
            .map((loot) => Loot.fromMap(loot.data()))
            .toList());
  }

  void newRandomLoot(
    String gameID,
    double mapSize,
    int numberOfLoot,
  ) {
    for (int i = 0; i < numberOfLoot; i++) {
      LootLocation randomLocation = LootLocation(
        dx: lootRandomLocation(mapSize),
        dy: lootRandomLocation(mapSize),
      );

      Loot newLoot = Loot.newLoot(randomLocation, i);

      addLootToDataBase(gameID, newLoot);
    }
  }

  double lootRandomLocation(double mapSize) {
    //For dev (spawn players closer together)
    // return (Random().nextDouble() * mapSize * 0.1) + (mapSize * 0.35);
    //Original
    return (Random().nextDouble() * mapSize * 0.8) + (mapSize * 0.1);
  }

  void addLootToDataBase(String gameID, Loot loot) {
    firebase
        .collection('game')
        .doc(gameID)
        .collection('loot')
        .doc('${loot.index}')
        .set(loot.toMap());
  }

  Shop _shop = Shop();

  void openLoot(String gameID, int lootIndex) async {
    List<Item> itemsInside = [];

    int numberOfLoot = Random().nextInt(3) + 1;

    for (int i = 0; i < numberOfLoot; i++) {
      itemsInside.add(_shop.randomItem());
    }

    var uploadItems = itemsInside.map((item) => item.toMap()).toList();

    await firebase
        .collection('game')
        .doc(gameID)
        .collection('loot')
        .doc('$lootIndex')
        .update({'isClosed': false, 'items': uploadItems});
  }

  void updateLootItems(
      String gameID, int lootIndex, List<Item> itemsInside) async {
    if (itemsInside.isEmpty) {
      return;
    }

    var uploadItems = itemsInside.map((item) => item.toMap()).toList();

    await firebase
        .collection('game')
        .doc(gameID)
        .collection('loot')
        .doc('$lootIndex')
        .update({'isClosed': false, 'items': uploadItems});
  }

  void deleteAllLoot(String gameID) async {
    var batch = firebase.batch();
    await firebase
        .collection('game')
        .doc(gameID)
        .collection('loot')
        .get()
        .then((snapshot) {
      snapshot.docs.forEach((document) {
        batch.delete(document.reference);
      });
    });

    batch.commit();
  }

  List<LootSprite> visibleLoot = [];

  void updateLootInSight(
    List<Loot> loot,
    Player selectedPlayer,
  ) {
    this.visibleLoot = [];
    loot.forEach((target) {
      if (selectedPlayer.cantSee(target.location!.getLocation())) {
        return;
      }

      this.visibleLoot.add(LootSprite(
            lootIndex: target.index,
            location: target.location,
            isClosed: target.isClosed,
          ));
    });
  }
}
