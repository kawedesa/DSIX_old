class Game {
  String id;
  int round;
  String map;
  double mapSize;

  Game({
    String id,
    int round,
    String map,
    double mapSize,
  }) {
    this.id = id;
    this.round = round;
    this.map = map;
    this.mapSize = mapSize;
  }

  factory Game.fromMap(Map data) {
    return Game(
      id: data['id'],
      round: data['round'],
      map: data['map'],
      mapSize: data['mapSize'] * 1.0,
    );
  }

  factory Game.newAlphaGame() {
    return Game(id: 'alpha', round: 0, map: 'ruins', mapSize: 320);
  }

  Map<String, dynamic> toMap(Game game) {
    return {
      'id': game.id,
      'round': game.round,
      'map': game.map,
      'mapSize': game.mapSize,
    };
  }
}
