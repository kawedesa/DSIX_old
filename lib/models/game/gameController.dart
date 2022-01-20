import 'package:cloud_firestore/cloud_firestore.dart';
import 'game.dart';
import '../player/player.dart';
import 'gameMap/gameMap.dart';

class GameController {
  final database = FirebaseFirestore.instance;

  String gameID = 'alpha';

  Stream<Game> pullGameFromDataBase() {
    return database
        .collection('game')
        .doc(gameID)
        .snapshots()
        .map((game) => Game.fromMap(game.data()));
  }

  void newGame(GameMap map, List<Player> players) {
    Game game = Game.newGame(this.gameID, map, players);

    database.collection('game').doc(this.gameID).set(game.toMap());
  }

  void deleteGame() async {
    Game game = Game.newEmptyGame();
    database.collection('game').doc(this.gameID).set(game.toMap());
  }
}
