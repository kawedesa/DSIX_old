import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dsixv02app/models/player/player.dart';
import 'package:dsixv02app/models/shop/item.dart';
import 'package:dsixv02app/models/shop/shop.dart';
import 'loot.dart';
import 'lootSprite.dart';

class LootController {
  final database = FirebaseFirestore.instance;

  Stream<List<Loot>> pullLootFromDataBase(String gameID) {
    return database
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
    var batch = database.batch();

    for (int i = 0; i < numberOfLoot; i++) {
      LootLocation randomLocation = LootLocation(
        dx: lootRandomLocation(mapSize),
        dy: lootRandomLocation(mapSize),
      );

      var document =
          database.collection('game').doc(gameID).collection('loot').doc('$i');

      batch.set(document, Loot.newLoot(randomLocation, i).toMap());
    }
    batch.commit();
  }

  double lootRandomLocation(double mapSize) {
    //For dev (spawn players closer together)
    // return (Random().nextDouble() * mapSize * 0.1) + (mapSize * 0.35);
    //Original
    return (Random().nextDouble() * mapSize * 0.9) + (mapSize * 0.05);
  }

  Shop _shop = Shop();

  void openLoot(String gameID, int lootIndex) async {
    List<Item> itemsInside = [];

    int numberOfLoot = Random().nextInt(3) + 1;

    for (int i = 0; i < numberOfLoot; i++) {
      itemsInside.add(_shop.randomItem());
    }

    var uploadItems = itemsInside.map((item) => item.toMap()).toList();

    await database
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

    await database
        .collection('game')
        .doc(gameID)
        .collection('loot')
        .doc('$lootIndex')
        .update({'isClosed': false, 'items': uploadItems});
  }

  void deleteAllLoot(String gameID) async {
    var batch = database.batch();
    await database
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
      if (selectedPlayer.vision!.canSeeLoot(target.location!.getLocation(),
          selectedPlayer.location!.getLocation())) {
        this.visibleLoot.add(LootSprite(
              lootIndex: target.index,
              location: target.location,
              isClosed: target.isClosed,
            ));
      }
    });
  }
}
