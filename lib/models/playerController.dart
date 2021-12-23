import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'player/player.dart';

class PlayerController {
  List<Player>? players;
  PlayerController({List<Player>? players}) {
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
    //Add Players
    for (int i = 0; i < numberOfPlayers; i++) {
      //For Test
      double dx = (Random().nextDouble() * mapSize * 0.4) + (mapSize * 0.3);
      double dy = (Random().nextDouble() * mapSize * 0.4) + (mapSize * 0.3);

      // Original
      // double dx = (Random().nextDouble() * mapSize * 0.8) + (mapSize * 0.1);
      // double dy = (Random().nextDouble() * mapSize * 0.8) + (mapSize * 0.1);

      Offset randomLocation = Offset(dx, dy);

      await database
          .collection('game')
          .doc(gameID)
          .collection('players')
          .doc('$i')
          .set(Player.newRandomPlayer(randomLocation, i).toMap());
    }
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
