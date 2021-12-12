import 'package:cloud_firestore/cloud_firestore.dart';

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

  final db = FirebaseFirestore.instance;
  Stream<Game> pullGameFromDataBase() {
    return db
        .collection('game')
        .doc('alpha')
        .snapshots()
        .map((game) => Game.createFromDataBase(game.data()));
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

  void newGame() {
    db.collection('game').doc('alpha').set(Game().saveToDataBase(
        Game(id: 'alpha', round: 0, map: 'crossroads', mapSize: 640)));
  }

  void newRound() async {
    this.round++;
    await db.collection('game').doc('alpha').update({'round': this.round});
  }

  void deleteGame() async {
    var batch = db.batch();
    await db.collection('game').get().then((snapshot) {
      snapshot.docs.forEach((document) {
        batch.delete(document.reference);
      });
    });

    batch.commit();
  }
}
