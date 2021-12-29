import 'tallGrassArea.dart';

class GameMap {
  String? name;
  double? size;
  TallGrassArea? tallGrass;
  GameMap({
    String? name,
    double? size,
    TallGrassArea? tallGrass,
  }) {
    this.name = name;
    this.size = size;
    this.tallGrass = tallGrass;
  }

  factory GameMap.fromMap(Map data) {
    return GameMap(
      name: data['name'],
      size: data['size'] * 1.0,
      tallGrass: TallGrassArea.fromMap(data['tallGrass']),
    );
  }
  Map<String, dynamic> toMap() {
    return {
      'name': this.name,
      'size': this.size,
      'tallGrass': this.tallGrass!.toMap(),
    };
  }
}
