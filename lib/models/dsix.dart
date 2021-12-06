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

  void newTurnOrder(List<Player> players) {
    players.shuffle();
    players.forEach((player) {
      addTurnToDataBase(Turn(id: player.id, firstAction: true));
    });
  }

  void addTurnToDataBase(Turn turn) async {
    await db
        .collection('turnOrder')
        .doc(turn.id)
        .set(turn.saveToDataBase(turn));
  }

  void deleteTurnOrder() async {
    await db.collection('turnOrder').get().then((snapshot) {
      snapshot.docs.forEach((document) {
        document.reference.delete();
      });
    });
  }

  bool checkPlayerTurn(List<Turn> turnOrder, Player player) {
    if (turnOrder.first.id == player.id) {
      return true;
    } else {
      return false;
    }
  }

  void takeTurn(
      List<Turn> turnOrder, List<Player> players, String playerID) async {
    if (turnOrder.length == 1) {
      newTurnOrder(players);
    } else {
      await db.collection('turnOrder').doc(playerID).delete();
    }
  }
}

class Turn {
  String id;
  bool firstAction;
  Turn({String id, bool firstAction}) {
    this.id = id;
    this.firstAction = firstAction;
  }
  factory Turn.fromMap(Map data) {
    return Turn(
      id: data['id'],
      firstAction: data['firstAction'],
    );
  }
  Map<String, dynamic> saveToDataBase(Turn turn) {
    return {
      'id': turn.id,
      'firstAction': turn.firstAction,
    };
  }
}
