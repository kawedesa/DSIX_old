import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dsixv02app/shared/app_Exceptions.dart';

import 'game.dart';
import 'player/player.dart';

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
    this.game = null;
    var batch = db.batch();
    await db.collection('game').get().then((snapshot) {
      snapshot.docs.forEach((document) {
        batch.delete(document.reference);
      });
    });

    batch.commit();
  }

  void checkForEndGame(List<Player> players) {
    int deadPlayers = 0;
    players.forEach((player) {
      if (player.life < 1) {
        deadPlayers++;
      }
    });
    if (deadPlayers == players.length - 1) {
      throw EndGameException();
    }
  }

  double fogSize;

  void setFogSize() {
    this.fogSize = game.mapSize - this.game.round * 5;
  }
}
