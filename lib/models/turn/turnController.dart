// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:dsixv02app/models/player/player.dart';
// import 'package:dsixv02app/shared/app_Exceptions.dart';

// import '../turn.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dsixv02app/models/player/player.dart';
import 'package:dsixv02app/shared/app_Exceptions.dart';

import 'turn.dart';

class TurnController {
  final database = FirebaseFirestore.instance;

  Stream<List<Turn>> pullTurnOrderFromDataBase(String gameID) {
    return database
        .collection('game')
        .doc(gameID)
        .collection('turnOrder')
        .snapshots()
        .map((querySnapshot) => querySnapshot.docs
            .map((turn) => Turn.fromMap(turn.data()))
            .toList());
  }

  void newTurnOrder(String gameID, List<Player> players) async {
    List<String> playerIDs = [];
    var batch = database.batch();

    players.forEach((player) {
      if (player.life!.isDead()) {
        return;
      }
      playerIDs.add(player.id!);
    });

    playerIDs.shuffle();

    for (int i = 0; i < playerIDs.length; i++) {
      var document = database
          .collection('game')
          .doc(gameID)
          .collection('turnOrder')
          .doc('$i');

      batch.set(document, Turn.newTurn(playerIDs[i], i).toMap());
    }
    batch.commit();
  }

  // void addTurnToDataBase(String gameID, Turn turn) async {
  //   await database
  //       .collection('game')
  //       .doc(gameID)
  //       .collection('turnOrder')
  //       .doc('${turn.index}')
  //       .set(turn.toMap());
  // }

  void passTurnForDeadPlayers(
      String gameID, List<Turn> turnOrder, List<Player> players) {
    if (turnOrder.isEmpty) {
      throw NewTurnException();
    }

    players.forEach((player) {
      if (player.life!.isDead()) {
        passTurnWhere(gameID, player.id!);
      }
    });

    if (turnOrder.isEmpty) {
      throw NewTurnException();
    }
  }

  void passTurnWhere(String gameID, String playerID) async {
    var snapshot = await database
        .collection('game')
        .doc(gameID)
        .collection('turnOrder')
        .where('id', isEqualTo: playerID)
        .get();

    for (var doc in snapshot.docs) {
      await doc.reference.delete();
    }
  }

  void deleteTurnOrder(String gameID) async {
    var batch = database.batch();
    await database
        .collection('game')
        .doc(gameID)
        .collection('turnOrder')
        .get()
        .then((snapshot) {
      snapshot.docs.forEach((document) {
        batch.delete(document.reference);
      });
    });

    batch.commit();
  }
}
