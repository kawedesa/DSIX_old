import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dsixv02app/models/player.dart';
import 'package:dsixv02app/models/user.dart';

import 'game.dart';

class TurnManager {
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

  void takeTurn(
      Game game, List<Player> players, List<Turn> turnOrder, User user) async {
    turnOrder.first.takeTurn();

    if (turnOrder.first.turnIsNotOver()) {
      user.walkMode();
      return;
    }

    if (turnOrder.length == 1) {
      passTurn(turnOrder.first.index);

      game.newRound();
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

class Turn {
  int index;
  String id;
  bool firstAction;
  bool secondAction;
  Turn({int index, String id, bool firstAction, bool secondAction}) {
    this.index = index;
    this.id = id;
    this.firstAction = firstAction;
    this.secondAction = secondAction;
  }

  final db = FirebaseFirestore.instance;
  factory Turn.fromMap(Map data) {
    return Turn(
      index: data['index'],
      id: data['id'],
      firstAction: data['firstAction'],
      secondAction: data['secondAction'],
    );
  }
  Map<String, dynamic> saveToDataBase(Turn turn) {
    return {
      'index': turn.index,
      'id': turn.id,
      'firstAction': turn.firstAction,
      'secondAction': turn.secondAction,
    };
  }

  Turn newTurn(String playerID, int index) {
    return Turn(
      index: index,
      id: playerID,
      firstAction: true,
      secondAction: true,
    );
  }

  void takeTurn() async {
    if (this.firstAction) {
      this.firstAction = false;
      await db
          .collection('turnOrder')
          .doc('${this.index}')
          .update({'firstAction': this.firstAction});
    } else {
      this.secondAction = false;
    }
  }

  bool turnIsNotOver() {
    if (this.secondAction) {
      return true;
    } else {
      return false;
    }
  }

  bool isPlayerTurn(String id) {
    if (id == this.id) {
      return true;
    } else {
      return false;
    }
  }
}
