import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dsixv02app/models/player/player.dart';
import 'package:dsixv02app/shared/app_Exceptions.dart';

import 'fog/fog.dart';

class Round {
  int? roundNumber;
  int? numberOfPlayers;
  List<String>? turnOrder;
  Fog? fog;

  Round(
      {int? roundNumber,
      int? numberOfPlayers,
      List<String>? turnOrder,
      Fog? fog}) {
    this.roundNumber = roundNumber;
    this.numberOfPlayers = numberOfPlayers;
    this.turnOrder = turnOrder;
    this.fog = fog;
  }

  factory Round.fromMap(Map<String, dynamic>? data) {
    List<String> turnOrder = [];
    List<dynamic> turnOrderMap = data?['turnOrder'];
    turnOrderMap.forEach((turn) {
      turnOrder.add(turn);
    });

    return Round(
      roundNumber: data?['roundNumber'],
      numberOfPlayers: data?['numberOfPlayers'],
      turnOrder: turnOrder,
      fog: Fog.fromMap(data?['fog']),
    );
  }

  Map<String, dynamic> toMap() {
    var turnOrder = this.turnOrder?.toList();
    return {
      'roundNumber': this.roundNumber,
      'numberOfPlayers': this.numberOfPlayers,
      'turnOrder': turnOrder,
      'fog': this.fog?.toMap(),
    };
  }

  factory Round.empty() {
    return Round(
      roundNumber: 0,
      numberOfPlayers: 0,
      turnOrder: [],
      fog: Fog.empty(),
    );
  }

  factory Round.newRound(double? mapSize, List<Player> players) {
    List<String> turnOrder = [];

    players.shuffle();

    for (int i = 0; i < players.length; i++) {
      turnOrder.add(players[i].id!);
    }

    return Round(
      roundNumber: 0,
      numberOfPlayers: players.length,
      turnOrder: turnOrder,
      fog: Fog.newFog(mapSize),
    );
  }

  void checkForEndGame() {
    if (this.numberOfPlayers! < 2) {
      throw EndGameException();
    }
  }

  void checkForPlayerTurn(String playerID) {
    if (this.turnOrder!.first == playerID) {
      throw PlayerTurnException();
    }
  }

  void takeTurn(String gameID, Player player) {
    player.action!.takeAction(
      gameID,
      player.id!,
    );
    if (player.action!.outOfActions()) {
      passTurn(player);
    }
  }

  void passTurn(Player player) {
    this.turnOrder!.remove(player.id);
    this.turnOrder!.add(player.id!);
    this.fog!.checkFog(player.gameID!, player);

    if (player.life!.isNotDead()) {
      player.waitMode();
    } else {
      removeDeadPlayer(player);
      player.deadMode();
    }

    this.roundNumber = this.roundNumber! + 1;
    this.fog!.shrink(this.numberOfPlayers!);

    updateRound(player.gameID!);
  }

  void removeDeadPlayer(Player player) {
    this.numberOfPlayers = this.numberOfPlayers! - 1;
    this.turnOrder!.remove(player.id);

    updateRound(player.gameID!);
  }

  void updateRound(String gameID) async {
    final database = FirebaseFirestore.instance.collection('game');
    await database.doc(gameID).update({'round': toMap()});
  }
}
