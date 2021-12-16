import 'package:cloud_firestore/cloud_firestore.dart';

import 'game.dart';

class GameController {
  final db = FirebaseFirestore.instance;
  Stream<Game> pullGameFromDataBase() {
    return db
        .collection('game')
        .doc('alpha')
        .snapshots()
        .map((game) => Game.fromMap(game.data()));
  }

  Game game;
  void newGame() {
    game = Game.newAlphaGame();
    db.collection('game').doc(game.id).set(Game().toMap(game));
  }

  void joinGame(Game joinedGame) {
    this.game = joinedGame;
  }

  void newRound() async {
    this.game.round++;
    await db.collection('game').doc('alpha').update({'round': this.game.round});
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
