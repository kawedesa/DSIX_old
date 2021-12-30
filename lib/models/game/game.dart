import 'fog/fog.dart';
import 'gameMap/gameMap.dart';

class Game {
  String? id;
  bool? isRunning;
  int? round;
  GameMap? map;
  Fog? fog;
  Game({
    String? id,
    bool? isRunning,
    int? round,
    GameMap? map,
    Fog? fog,
  }) {
    this.id = id;
    this.isRunning = isRunning;
    this.round = round;
    this.map = map;
    this.fog = fog;
  }

  factory Game.fromMap(Map<String, dynamic>? data) {
    return Game(
      id: data?['id'],
      isRunning: data?['isRunning'],
      round: data?['round'],
      map: GameMap.fromMap(data?['map']),
      fog: Fog.fromMap(data?['fog']),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': this.id,
      'isRunning': this.isRunning,
      'round': this.round,
      'map': this.map?.toMap(),
      'fog': this.fog?.toMap(),
    };
  }

  factory Game.newEmptyGame() {
    return Game(
      id: 'alpha',
      isRunning: false,
      round: 0,
      map: GameMap.empty(),
      fog: Fog.empty(),
    );
  }

  factory Game.newGame(String gameID, GameMap map) {
    return Game(
      id: gameID,
      round: 0,
      map: map,
      isRunning: true,
      fog: Fog.newFog(map.size),
    );
  }
}
