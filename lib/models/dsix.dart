import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'player.dart';

class Dsix {
  final db = FirebaseFirestore.instance;

  int selectedPlayerIndex;
  List<Player> listOfPlayers = [];

  Stream<List<Player>> getAvailablePlayers() {
    return db.collection('players').snapshots().map((querySnapshot) =>
        querySnapshot.docs
            .map((player) => Player.fromMap(player.data()))
            .toList());
  }

  void pullPlayersFromDataBase() {
    this.listOfPlayers = [];
    db
        .collection('players')
        .snapshots()
        .map((querySnapshot) => querySnapshot.docs.forEach((doc) {
              addPlayer(Player.fromMap(doc.data()));
            }));
  }

  void addPlayer(Player player) {
    this.listOfPlayers.add(player);
  }

  void setColorForAllPlayers() {
    this.listOfPlayers.forEach((player) {
      player.setColor();
    });
  }

  void addListOfPlayersToDataBase() {
    this.listOfPlayers.forEach((element) {
      addPlayerToDataBase(element);
    });
  }

  void addPlayerToDataBase(Player player) {
    db.collection('players').doc(player.id).set(player.saveToDataBase(player));
  }

  void joinGame() {
    pullPlayersFromDataBase();
    setColorForAllPlayers();
  }

  void deleteGame() {
    this.listOfPlayers = [];
    deleteAllPlayersFromDataBase();
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

  void createListOfRandomPlayers(int numberOfPlayers) {
    for (int i = 0; i < numberOfPlayers; i++) {
      newRandomPlayer(i);
    }
  }

  void newRandomPlayer(int playerIndex) {
    Player newRandomPlayer = Player().newPlayer(playerIndex);
    addPlayer(newRandomPlayer);
  }

  void selectPlayer(int playerIndex) {
    this.selectedPlayerIndex = playerIndex;
  }

  void newBattleRoyaleGame(int numberOfPlayers) {
    createListOfRandomPlayers(numberOfPlayers);
    setColorForAllPlayers();
    preparePlayersForBattleRoyale();
    addListOfPlayersToDataBase();
  }

  void preparePlayersForBattleRoyale() {
    this.listOfPlayers.forEach((player) {
      spawnPlayerInRandomLocation(player);
      assignRandomRaceToPlayer(player);
    });
  }

  void spawnPlayerInRandomLocation(Player player) {
    //This is used to spawn people close to the center using the map size
    double dx = (Random().nextDouble() * 640 * 0.8) + (640 * 0.1);
    double dy = (Random().nextDouble() * 640 * 0.8) + (640 * 0.1);
    player.dx = dx;
    player.dy = dy;
  }

  void assignRandomRaceToPlayer(Player player) {
    List<String> availableRaces = [
      'orc',
      'dwarf',
    ];
    int randomRace = Random().nextInt(availableRaces.length);
    player.race = availableRaces[randomRace];
    player.setAttributeBasedOnRace();
  }

  void updateSelectedPlayerLocation(double dx, double dy, String playerID) {
    final batch = db.batch();
    final document =
        FirebaseFirestore.instance.collection('players').doc(playerID);
    batch.update(document, {'dx': dx, 'dy': dy});
    batch.commit();
  }
}
