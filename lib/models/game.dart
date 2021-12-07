import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'player.dart';

final db = FirebaseFirestore.instance;

class Game {
  String id;
  int round;
  String map;
  double mapSize;

  Game({
    String id,
    int round,
    String map,
    double mapSize,
  }) {
    this.id = id;
    this.round = round;
    this.map = map;
    this.mapSize = mapSize;
  }

  factory Game.createFromDataBase(Map data) {
    return Game(
      id: data['id'],
      round: data['round'],
      map: data['map'],
      mapSize: data['mapSize'] * 1.0,
    );
  }

  Map<String, dynamic> saveToDataBase(Game game) {
    return {
      'id': game.id,
      'round': game.round,
      'map': game.map,
      'mapSize': game.mapSize,
    };
  }

  Stream<List<Player>> pullPlayersFromDataBase() {
    return db.collection('players').snapshots().map((querySnapshot) =>
        querySnapshot.docs
            .map((player) => Player.fromMap(player.data()))
            .toList());
  }

  Stream<Game> pullGameFromDataBase() {
    return db
        .collection('game')
        .doc('alpha')
        .snapshots()
        .map((game) => Game.createFromDataBase(game.data()));
  }

  Stream<List<Turn>> pullTurnOrderFromDataBase() {
    return db.collection('turnOrder').snapshots().map((querySnapshot) =>
        querySnapshot.docs
            .map((player) => Turn.fromMap(player.data()))
            .toList());
  }

  void newGameBattleRoyaleGame(int numberOfPlayers) {
    newMap();
    startGame(createListOfRandomPlayersInRandomLocations(numberOfPlayers));
  }

  void newMap() {
    db.collection('game').doc('alpha').set(Game().saveToDataBase(
        Game(id: 'alpha', round: 0, map: 'crossroads', mapSize: 640)));
  }

  void startGame(List<Player> players) {
    players.forEach((player) {
      addPlayerToDataBase(player);
    });
    newTurnOrder(players);
  }

  List<Player> createListOfRandomPlayersInRandomLocations(int numberOfPlayers) {
    List<Player> listOfRandomPlayers = [];
    for (int i = 0; i < numberOfPlayers; i++) {
      listOfRandomPlayers
          .add(Player.newRandomPlayer(randomLocation(), randomLocation(), i));
    }
    return listOfRandomPlayers;
  }

  double randomLocation() {
    return (Random().nextDouble() * 640 * 0.8) + (640 * 0.1);
  }

  void addPlayerToDataBase(Player player) {
    db.collection('players').doc(player.id).set(player.saveToDataBase(player));
  }

  void newRound(List<Player> players, int currentRound) {
    int newRoundNumber = currentRound + 1;
    db.collection('game').doc('alpha').update({'round': newRoundNumber});
    newTurnOrder(players);
  }

  void newTurnOrder(List<Player> players) {
    List<Player> randomOrder = [];
    players.forEach((player) {
      randomOrder.add(player);
    });
    randomOrder.shuffle();

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

  void deleteGame() {
    deleteMap();
    deleteAllPlayersFromDataBase();
    deleteTurnOrder();
  }

  void deleteMap() async {
    var batch = db.batch();
    await db.collection('game').get().then((snapshot) {
      snapshot.docs.forEach((document) {
        batch.delete(document.reference);
      });
    });

    batch.commit();
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

  void deleteTurnOrder() async {
    var batch = db.batch();
    await db.collection('turnOrder').get().then((snapshot) {
      snapshot.docs.forEach((document) {
        batch.delete(document.reference);
      });
    });

    batch.commit();
  }

  void updateSelectedPlayerLocation(
      double dx, double dy, String playerID) async {
    final batch = db.batch();
    final document =
        FirebaseFirestore.instance.collection('players').doc(playerID);
    batch.update(document, {'dx': dx, 'dy': dy});
    await batch.commit();
  }

  void takeTurn(
      List<Turn> turnOrder, List<Player> players, int currentRound) async {
    turnOrder.first.takeTurn();
    if (turnOrder.first.turnIsNotOver()) {
      return;
    }
    if (turnOrder.length == 1) {
      newRound(players, currentRound);
    } else {
      removeTurnFromDataBase(turnOrder.first.index);
    }
  }

  void removeTurnFromDataBase(int index) async {
    await db.collection('turnOrder').doc('$index').delete();
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
