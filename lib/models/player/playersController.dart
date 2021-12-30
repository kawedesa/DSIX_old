import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dsixv02app/models/game/gameMap/gameMap.dart';
import 'package:dsixv02app/models/player/playerLocation.dart';
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
    GameMap map,
    int numberOfPlayers,
  ) async {
    var batch = database.batch();

    //Add Players
    for (int i = 0; i < numberOfPlayers; i++) {
      PlayerLocation location = randomLocation(map);

      var document = database
          .collection('game')
          .doc(gameID)
          .collection('players')
          .doc('$i');

      batch.set(
          document,
          Player.newRandomPlayer(
            i,
            location,
          ).toMap());
    }
    batch.commit();
  }

  PlayerLocation randomLocation(GameMap map) {
    int i = 0;

    double dx = 0;
    double dy = 0;
    Offset newOffset = Offset(0, 0);
    bool isVisible = true;
    int height = 0;

    while (i < 1) {
      dx = (Random().nextDouble() * map.size! * 0.9) + (map.size! * 0.05);
      dy = (Random().nextDouble() * map.size! * 0.9) + (map.size! * 0.05);

      newOffset = Offset(dx, dy);

      if (map.tallGrass!.inThisArea(newOffset)) {
        isVisible = false;
      }

      height = map.heightMap!.inThisLayer(newOffset);

      if (height != 10) {
        i++;
      }
    }

    return PlayerLocation(dx: dx, dy: dy, isVisible: isVisible, height: height);
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
