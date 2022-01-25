import 'package:dsixv02app/models/player/player.dart';
import 'package:dsixv02app/models/game/round.dart';
import 'gameMap/gameMap.dart';

class Game {
  String? id;
  bool? isRunning;
  Round? round;
  GameMap? map;

  Game({
    String? id,
    bool? isRunning,
    Round? round,
    GameMap? map,
  }) {
    this.id = id;
    this.isRunning = isRunning;
    this.round = round;
    this.map = map;
  }

  factory Game.fromMap(Map<String, dynamic>? data) {
    return Game(
      id: data?['id'],
      isRunning: data?['isRunning'],
      round: Round.fromMap(data?['round']),
      map: GameMap.fromMap(data?['map']),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': this.id,
      'isRunning': this.isRunning,
      'round': this.round?.toMap(),
      'map': this.map?.toMap(),
    };
  }

  factory Game.newEmptyGame() {
    return Game(
      id: 'alpha',
      isRunning: false,
      round: Round.empty(),
      map: GameMap.empty(),
    );
  }

  factory Game.newGame(String gameID, GameMap map, List<Player> players) {
    return Game(
      id: gameID,
      round: Round.newRound(map.size, players),
      map: map,
      isRunning: true,
    );
  }
}
