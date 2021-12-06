import 'dart:math';

import 'package:flutter/material.dart';

class Player {
  String id;

  double dx;
  double dy;
  String race;
  double vision;
  double walkRange;
  int life;
  int maxLife;
  Player(
      {String id,
      double dx,
      double dy,
      String race,
      double vision,
      double walkRange,
      int life,
      int maxLife}) {
    this.id = id;
    this.dx = dx;
    this.dy = dy;
    this.race = race;
    this.vision = vision;
    this.walkRange = walkRange;
    this.life = life;
    this.maxLife = maxLife;
  }

  Map<String, dynamic> saveToDataBase(Player player) {
    return {
      'id': player.id,
      'dx': player.dx,
      'dy': player.dy,
      'race': player.race,
      'vision': player.vision,
      'walkRange': player.walkRange,
    };
  }

  factory Player.fromMap(Map data) {
    return Player(
      id: data['id'],
      dx: data['dx'] * 1.0,
      dy: data['dy'] * 1.0,
      race: data['race'],
      vision: data['vision'] * 1.0,
      walkRange: data['walkRange'] * 1.0,
    );
  }

  factory Player.newRandomPlayer(double dx, double dy, int playerIndex) {
    List<String> id = [
      'blue',
      'pink',
      'green',
      'yellow',
      'purple',
    ];

    List<String> races = [
      'orc',
      'dwarf',
    ];
    int randomRace = Random().nextInt(races.length);

    return Player(
      id: id[playerIndex],
      dx: dx,
      dy: dy,
      race: races[randomRace],
      vision: 100,
      walkRange: 50,
    );
  }

  int getCurrentLife() {
    return this.life;
  }

  void reduceCurrentLife(int value) {
    this.life -= value;
  }

  void increaseCurrentLife(int value) {
    this.life += value;
  }

  bool checkIfPlayerIsDead() {
    if (this.life < 1) {
      return true;
    } else {
      return false;
    }
  }
}

class PlayerTemporaryLocation extends ChangeNotifier {
  double dx = 0;
  double dy = 0;

  void changePlayerLocation(double dx, double dy) {
    this.dx += dx;
    this.dy += dy;
    notifyListeners();
  }

  void updatePlayerSprite(
    double dx,
    double dy,
  ) {
    this.dx = dx;
    this.dy = dy;
    notifyListeners();
  }
}
