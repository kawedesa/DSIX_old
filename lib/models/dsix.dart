import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'gameMap.dart';
import 'player.dart';

class Dsix {
  final db = FirebaseFirestore.instance;
  int selectedPlayerIndex;

  //Map
  Stream<GameMap> pullMapFromDataBase() {
    return db
        .collection('map')
        .doc('mapID')
        .snapshots()
        .map((game) => GameMap.fromMap(game.data()));
  }

  void newMap() {
    db.collection('map').doc('mapID').set(
        GameMap().saveToDataBase(GameMap(map: 'crossroads', mapSize: 640)));
  }

  void deleteMap() {
    db.collection('map').doc('mapID').delete();
  }

//Players
  Stream<List<Player>> pullPlayersFromDataBase() {
    return db.collection('players').snapshots().map((querySnapshot) =>
        querySnapshot.docs
            .map((player) => Player.fromMap(player.data()))
            .toList());
  }

  void createRandomPlayersInRandomLocations(int numberOfPlayers) {
    for (int i = 0; i < numberOfPlayers; i++) {
      addPlayerToDataBase(
          Player.newRandomPlayer(randomLocation(), randomLocation(), i));
    }
  }

  double randomLocation() {
    return (Random().nextDouble() * 640 * 0.8) + (640 * 0.1);
  }

  void addPlayerToDataBase(Player player) {
    db.collection('players').doc(player.id).set(player.saveToDataBase(player));
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

  void changeToPlayer(List<Player> players, String playerID) {
    for (int i = 0; i < players.length; i++) {
      if (players[i].id == playerID) {
        selectPlayer(i);
      }
    }
  }

  void selectPlayer(int playerIndex) {
    this.selectedPlayerIndex = playerIndex;
  }

  void updateSelectedPlayerLocation(
      double dx, double dy, String playerID) async {
    final batch = db.batch();
    final document =
        FirebaseFirestore.instance.collection('players').doc(playerID);
    batch.update(document, {'dx': dx, 'dy': dy});
    await batch.commit();
  }

  //TurnOrder
  Stream<List<Turn>> pullTurnOrderFromDataBase() {
    return db.collection('turnOrder').snapshots().map((querySnapshot) =>
        querySnapshot.docs
            .map((player) => Turn.fromMap(player.data()))
            .toList());
  }

  void takeTurn(List<Turn> round, List<Player> players) async {
    round.first.takeTurn();
    if (round.first.turnIsNotOver()) {
      return;
    }
    if (round.length == 1) {
      newRound(players);
    } else {
      await db.collection('turnOrder').doc('${round.first.index}').delete();
    }
  }

  void newRound(List<Player> players) {
    List<Player> randomOrder = [];
    players.forEach((player) {
      randomOrder.add(player);
    });

    print(randomOrder);
    randomOrder.shuffle();
    print(randomOrder);

    for (int i = 0; i < randomOrder.length; i++) {
      addTurnToDataBase(Turn().newTurn(randomOrder[i].id, i));
    }
  }

  void addTurnToDataBase(Turn turn) async {
    await db
        .collection('turnOrder')
        .doc('${turn.index}')
        .set(turn.saveToDataBase(turn));
  }

  void deleteRound() async {
    await db.collection('turnOrder').get().then((snapshot) {
      snapshot.docs.forEach((document) {
        document.reference.delete();
      });
    });
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

  void takeTurn() {
    if (this.firstAction) {
      this.firstAction = false;
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
}
