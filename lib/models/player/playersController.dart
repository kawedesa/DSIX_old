import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dsixv02app/models/game/gameMap/gameMap.dart';
import 'package:dsixv02app/models/player/playerLocation.dart';
import 'player.dart';

class PlayersController {
  List<Player>? players;
  PlayersController({List<Player>? players}) {
    this.players = players;
  }

  final database = FirebaseFirestore.instance;

  Stream<List<Player>> pullPlayersFromDataBase(String gameID) {
    return database
        .collection('game')
        .doc(gameID)
        .collection('players')
        .snapshots()
        .map((querySnapshot) => querySnapshot.docs
            .map((player) => Player.fromMap(player.data()))
            .toList());
  }

  List<Player> newRandomPlayers(
    String gameID,
    GameMap map,
    int numberOfPlayers,
  ) {
    List<Player> newPlayers = [];

    //Add Players
    for (int i = 0; i < numberOfPlayers; i++) {
      Player player = Player.newRandomPlayer(
        i,
        PlayerLocation.randomLocation(map),
      );
      newPlayers.add(player);
    }
    uploadPlayers(gameID, newPlayers);
    return newPlayers;
  }

  void uploadPlayers(String gameID, List<Player> players) async {
    var batch = database.batch();
    players.forEach((player) {
      var document = database
          .collection('game')
          .doc(gameID)
          .collection('players')
          .doc('${player.id}');
      batch.set(document, player.toMap());
    });
    batch.commit();
  }

  void deleteAllPlayers(String gameID) async {
    var batch = database.batch();
    await database
        .collection('game')
        .doc(gameID)
        .collection('players')
        .get()
        .then((snapshot) {
      snapshot.docs.forEach((document) {
        batch.delete(document.reference);
      });
    });

    batch.commit();
  }
}
