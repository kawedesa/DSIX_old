import 'package:flutter/material.dart';
import 'shop/item.dart';

class Game {
  String? id;
  bool? isRunning;
  int? round;
  GameMap? map;

  Game({
    String? id,
    bool? isRunning,
    int? round,
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
      round: data?['round'],
      isRunning: data?['isRunning'],
      map: GameMap.fromMap(data?['map']),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': this.id,
      'round': this.round,
      'map': this.map?.toMap(),
      'isRunning': this.isRunning,
    };
  }

  factory Game.newEmptyGame() {
    return Game(
      id: 'alpha',
      round: 0,
      map: GameMap(
        name: '',
        size: 0.0,
      ),
      isRunning: false,
    );
  }

  factory Game.newGame(String gameID, GameMap map) {
    return Game(
      id: gameID,
      round: 1,
      map: map,
      isRunning: true,
    );
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
