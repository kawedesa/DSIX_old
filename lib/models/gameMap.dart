class GameMap {
  String map;
  double mapSize;

  GameMap({
    String map,
    double mapSize,
  }) {
    this.map = map;
    this.mapSize = mapSize;
  }

  factory GameMap.fromMap(Map data) {
    return GameMap(
      map: data['map'],
      mapSize: data['mapSize'] * 1.0,
    );
  }

  Map<String, dynamic> saveToDataBase(GameMap map) {
    return {
      'map': map.map,
      'mapSize': map.mapSize,
    };
  }
}
