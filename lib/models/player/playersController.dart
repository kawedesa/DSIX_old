import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'player.dart';

class PlayersController {
  List<Player>? players;
  PlayersController({List<Player>? players}) {
    this.players = players;
  }

  final database = FirebaseFirestore.instance;

  Stream<List<Player>> pullPlayersFromDataBase(String gameID) {
    return database
        .collection('game')
        .doc(gameID)
        .collection('players')
        .snapshots()
        .map((querySnapshot) => querySnapshot.docs
            .map((player) => Player.fromMap(player.data()))
            .toList());
  }

  void newRandomPlayers(
    String gameID,
    double mapSize,
    int numberOfPlayers,
  ) async {
    var batch = database.batch();

    //Add Players
    for (int i = 0; i < numberOfPlayers; i++) {
      // For Test
      // double dx = (Random().nextDouble() * mapSize * 0.4) + (mapSize * 0.3);
      // double dy = (Random().nextDouble() * mapSize * 0.4) + (mapSize * 0.3);

      // Original
      double dx = playerRandomLocation(mapSize);
      double dy = playerRandomLocation(mapSize);

      Offset randomLocation = Offset(dx, dy);

      var document = database
          .collection('game')
          .doc(gameID)
          .collection('players')
          .doc('$i');

      batch.set(document, Player.newRandomPlayer(randomLocation, i).toMap());
    }
    batch.commit();
  }

  double playerRandomLocation(double mapSize) {
    //For dev (spawn players closer together)
    // return (Random().nextDouble() * mapSize * 0.1) + (mapSize * 0.35);
    //Original
    return (Random().nextDouble() * mapSize * 0.9) + (mapSize * 0.05);
  }

  void deleteAllPlayers(String gameID) async {
    var batch = database.batch();
    await database
        .collection('game')
        .doc(gameID)
        .collection('players')
        .get()
        .then((snapshot) {
      snapshot.docs.forEach((document) {
        batch.delete(document.reference);
      });
    });

    batch.commit();
  }
}
