import 'dart:math';

import 'package:flutter/material.dart';

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

class Fog {
  double? dx;
  double? dy;
  double? size;

  Fog({double? dx, double? dy, double? size}) {
    this.dx = dx;
    this.dy = dy;
    this.size = size;
  }

  Map<String, dynamic> toMap() {
    return {
      'dx': this.dx,
      'dy': this.dy,
      'size': this.size,
    };
  }

  factory Fog.fromMap(Map<String, dynamic>? data) {
    return Fog(
      dx: data?['dx'] * 1.0,
      dy: data?['dy'] * 1.0,
      size: data?['size'] * 1.0,
    );
  }
  factory Fog.newFog(double? mapSize) {
    double dx = (Random().nextDouble() * mapSize! * 0.8) + (mapSize * 0.1);
    double dy = (Random().nextDouble() * mapSize * 0.8) + (mapSize * 0.1);

    return Fog(
      dx: dx,
      dy: dy,
      size: mapSize * 2,
    );
  }

  Offset getLocation() {
    return Offset(this.dx!, this.dy!);
  }

  void shrink() {
    this.size = this.size! - 24;
    if (this.size! < 50) {
      this.size = 50;
    }
  }
}

class GameMap {
  String? name;
  double? size;
  GameMap({String? name, double? size}) {
    this.name = name;
    this.size = size;
  }

  factory GameMap.fromMap(Map data) {
    return GameMap(
      name: data['name'],
      size: data['size'] * 1.0,
    );
  }
  Map<String, dynamic> toMap() {
    return {
      'name': this.name,
      'size': this.size,
    };
  }
}
