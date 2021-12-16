import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dsixv02app/models/gameController.dart';
import 'package:dsixv02app/models/player/player.dart';
import 'package:dsixv02app/models/player/user.dart';
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
      if (player.checkIfPlayerIsDead()) {
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
    await db
        .collection('turnOrder')
        .doc('${turn.index}')
        .set(turn.saveToDataBase(turn));
  }

  void passTurnForDeadPlayers(
      List<Turn> turnOrder, List<Player> players, User user) {
    if (turnOrder.isEmpty) {
      return;
    }
    players.forEach((player) {
      if (player.id != turnOrder.first.id) {
        return;
      }
      if (player.life <= 0) {
        passTurn(turnOrder.first.index);
      }
    });
  }

  void checkForNewTurn(List<Turn> turnOrder, List<Player> players) {
    if (turnOrder.isNotEmpty) {
      return;
    }
    newTurnOrder(players);
  }

  bool isPlayerTurn(List<Turn> turnOrder, String id) {
    if (turnOrder.isEmpty) {
      return false;
    }

    if (id == turnOrder.first.id) {
      return true;
    } else {
      return false;
    }
  }

  void takeTurn(GameController gameController, List<Player> players,
      List<Turn> turnOrder, User user) async {
    turnOrder.first.takeTurn();

    if (turnOrder.first.turnIsNotOver()) {
      user.walkMode();
      return;
    }

    if (turnOrder.length == 1) {
      passTurn(turnOrder.first.index);
      gameController.newRound();
      newTurnOrder(players);
    } else {
      passTurn(turnOrder.first.index);
    }
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
