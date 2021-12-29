import 'fog/fog.dart';
import 'gameMap/gameMap.dart';
import 'gameMap/tallGrassArea.dart';

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
      round: data?['round'],
      isRunning: data?['isRunning'],
      map: GameMap.fromMap(data?['map']),
      fog: Fog.fromMap(data?['fog']),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': this.id,
      'round': this.round,
      'map': this.map?.toMap(),
      'isRunning': this.isRunning,
      'fog': this.fog?.toMap(),
    };
  }

  factory Game.newEmptyGame() {
    GameMap map = GameMap(
      name: '',
      size: 0.0,
      tallGrass: TallGrassArea.empty(),
    );

    return Game(
      id: 'alpha',
      round: 0,
      map: map,
      isRunning: false,
      fog: Fog.newFog(map.size),
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
