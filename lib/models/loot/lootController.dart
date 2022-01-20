import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dsixv02app/models/player/player.dart';
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
    return (Random().nextDouble() * mapSize * 0.9) + (mapSize * 0.05);
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
              loot: target,
            ));
      }
    });
  }
}
