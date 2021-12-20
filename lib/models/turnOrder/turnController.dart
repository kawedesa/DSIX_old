import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dsixv02app/models/player/player.dart';
import 'package:dsixv02app/shared/app_Exceptions.dart';

import 'turn.dart';

class TurnController {
  final db = FirebaseFirestore.instance;

  Stream<List<Turn>> pullTurnOrderFromDataBase() {
    return db.collection('turnOrder').snapshots().map((querySnapshot) =>
        querySnapshot.docs
            .map((player) => Turn.fromMap(player.data()))
            .toList());
  }

  void newTurnOrder(List<Player> players) {
    List<String> playerIDs = [];

    players.forEach((player) {
      if (player.isDead()) {
      } else {
        playerIDs.add(player.id);
      }
    });

    playerIDs.shuffle();

    for (int i = 0; i < playerIDs.length; i++) {
      addTurnToDataBase(Turn().newTurn(playerIDs[i], i));
    }
  }

  void addTurnToDataBase(Turn turn) async {
    await db.collection('turnOrder').doc('${turn.index}').set(turn.toMap(turn));
  }

  void passTurnForDeadPlayers(List<Turn> turnOrder, List<Player> players) {
    if (turnOrder.isEmpty) {
      throw NewTurnException();
    }

    players.forEach((player) {
      if (player.isDead()) {
        passTurnWhere(player.id);
      }
    });

    if (turnOrder.isEmpty) {
      throw NewTurnException();
    }
  }

  void passTurnWhere(String playerID) async {
    var collection = FirebaseFirestore.instance.collection('turnOrder');
    var snapshot = await collection.where('id', isEqualTo: playerID).get();
    for (var doc in snapshot.docs) {
      await doc.reference.delete();
    }
  }

  void checkForPlayerTurn(List<Turn> turnOrder, String id) {
    if (turnOrder.isEmpty) {
      throw NotPlayerTurnException();
    }

    if (id == turnOrder.first.id) {
      throw PlayerTurnException();
    } else {
      throw NotPlayerTurnException();
    }
  }

  void takeTurn(List<Turn> turnOrder) {
    turnOrder.first.takeTurn();

    if (turnOrder.first.turnIsNotOver()) {
      throw PlayerTurnException();
    }
    passTurn(turnOrder.first.index);
    throw NotPlayerTurnException();
  }

  void passTurn(int turnIndex) async {
    await db.collection('turnOrder').doc('$turnIndex').delete();
  }

  void deleteTurnOrder() async {
    var batch = db.batch();
    await db.collection('turnOrder').get().then((snapshot) {
      snapshot.docs.forEach((document) {
        batch.delete(document.reference);
      });
    });

    batch.commit();
  }
}
