import 'package:dsixv02app/models/game/gameMap/heightMap.dart';

import 'totalArea.dart';

class GameMap {
  String? name;
  double? size;
  TotalArea? tallGrass;
  HeightMap? heightMap;
  GameMap({
    String? name,
    double? size,
    TotalArea? tallGrass,
    HeightMap? heightMap,
  }) {
    this.name = name;
    this.size = size;
    this.tallGrass = tallGrass;
    this.heightMap = heightMap;
  }

  factory GameMap.fromMap(Map data) {
    return GameMap(
      name: data['name'],
      size: data['size'] * 1.0,
      tallGrass: TotalArea.fromMap(data['tallGrass']),
      heightMap: HeightMap.fromMap(data['heightMap']),
    );
  }

  factory GameMap.empty() {
    return GameMap(
      name: '',
      size: 0.0,
      tallGrass: TotalArea.empty(),
      heightMap: HeightMap.empty(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': this.name,
      'size': this.size,
      'tallGrass': this.tallGrass!.toMap(),
      'heightMap': this.heightMap!.toMap(),
    };
  }
}
