import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';

import 'player.dart';

class PlayerController {
  final db = FirebaseFirestore.instance;
  Stream<List<Player>> pullPlayersFromDataBase() {
    return db.collection('players').snapshots().map((querySnapshot) =>
        querySnapshot.docs
            .map((player) => Player.fromMap(player.data()))
            .toList());
  }

  List<Player> listOfRandomPlayers = [];
  void createListOfRandomPlayersInRandomLocations(
      int numberOfPlayers, double mapSize) {
    listOfRandomPlayers = [];
    for (int i = 0; i < numberOfPlayers; i++) {
      listOfRandomPlayers.add(Player.newRandomPlayer(
          playerRandomLocation(mapSize), playerRandomLocation(mapSize), i));
    }

    listOfRandomPlayers.forEach((player) {
      player.setLife();
      player.setWeight();
      player.setAttackRange();
      player.setVisionRange();
      player.setWalkRange();
      addPlayerToDataBase(player);
    });
  }

  double playerRandomLocation(double mapSize) {
    // //For dev (spawn players closer together)
    // return (Random().nextDouble() * mapSize * 0.1) + (mapSize * 0.35);
    //Original
    return (Random().nextDouble() * mapSize * 0.8) + (mapSize * 0.1);
  }

  void addPlayerToDataBase(Player player) {
    db.collection('players').doc(player.id).set(player.toMap(player));
  }

  void deleteAllPlayersFromDataBase() async {
    var batch = db.batch();
    await db.collection('players').get().then((snapshot) {
      snapshot.docs.forEach((document) {
        batch.delete(document.reference);
      });
    });

    batch.commit();
  }
}
