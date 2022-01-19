import 'package:dsixv02app/models/player/player.dart';

import 'turn.dart';
import '../fog/fog.dart';

class Round {
  int? roundNumber;
  List<String>? turnOrder;
  Fog? fog;

  Round({int? roundNumber, List<String>? turnOrder, Fog? fog}) {
    this.roundNumber = roundNumber;
    this.turnOrder = turnOrder;
    this.fog = fog;
  }

  factory Round.fromMap(Map<String, dynamic>? data) {
    List<String> turnOrder = [];
    List<dynamic> turnOrderMap = data?['turnOrder'];
    turnOrderMap.forEach((test) {
      turnOrder.add(test);
    });

    return Round(
      roundNumber: data?['roundNumber'],
      turnOrder: turnOrder,
      fog: Fog.fromMap(data?['fog']),
    );
  }

  Map<String, dynamic> toMap() {
    var turnOrder = this.turnOrder?.toList();
    return {
      'roundNumber': this.roundNumber,
      'turnOrder': turnOrder,
      'fog': this.fog?.toMap(),
    };
  }

  factory Round.empty() {
    return Round(
      roundNumber: 0,
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
      turnOrder: turnOrder,
      fog: Fog.newFog(mapSize),
    );
  }
}
