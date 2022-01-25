import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dsixv02app/models/player/player.dart';
import 'chest.dart';
import 'chestSprite.dart';

class ChestController {
  final database = FirebaseFirestore.instance;

  Stream<List<Chest>> pullLootFromDataBase(String gameID) {
    return database
        .collection('game')
        .doc(gameID)
        .collection('loot')
        .snapshots()
        .map((querySnapshot) => querySnapshot.docs
            .map((loot) => Chest.fromMap(loot.data()))
            .toList());
  }

  void newRandomLoot(
    String gameID,
    double mapSize,
    int numberOfLoot,
  ) {
    var batch = database.batch();

    for (int i = 0; i < numberOfLoot; i++) {
      ChestLocation randomLocation = ChestLocation(
        dx: lootRandomLocation(mapSize),
        dy: lootRandomLocation(mapSize),
      );

      var document =
          database.collection('game').doc(gameID).collection('loot').doc('$i');

      batch.set(document, Chest.newLoot(gameID, randomLocation, i).toMap());
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

  List<ChestSprite> visibleLoot = [];

  void updateLootInSight(
    List<Chest> loot,
    Player player,
  ) {
    this.visibleLoot = [];
    loot.forEach((target) {
      if (player.vision!.canSeeLoot(
          target.location!.getLocation(), player.location!.getLocation())) {
        this.visibleLoot.add(ChestSprite(
              player: player,
              chest: target,
            ));
      }
    });
  }
}
