import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class PlayerManager {
  final db = FirebaseFirestore.instance;
  Stream<List<Player>> pullPlayersFromDataBase() {
    return db.collection('players').snapshots().map((querySnapshot) =>
        querySnapshot.docs
            .map((player) => Player.fromMap(player.data()))
            .toList());
  }

  List<Player> listOfRandomPlayers = [];
  void createListOfRandomPlayersInRandomLocations(int numberOfPlayers) {
    listOfRandomPlayers = [];
    for (int i = 0; i < numberOfPlayers; i++) {
      listOfRandomPlayers
          .add(Player.newRandomPlayer(randomLocation(), randomLocation(), i));
    }

    listOfRandomPlayers.forEach((player) {
      player.setLife();
      player.setWeight();
      player.setAttackRange();
      player.setVisionRange();
      player.setWalkRange();
      addPlayerToDataBase(player);
    });
  }

  double randomLocation() {
    //For dev
    return (Random().nextDouble() * 640 * 0.1) + (640 * 0.35);
    //Original
    // return (Random().nextDouble() * 640 * 0.8) + (640 * 0.1);
  }

  void addPlayerToDataBase(Player player) {
    db.collection('players').doc(player.id).set(player.saveToDataBase(player));
  }

  void deleteAllPlayersFromDataBase() async {
    var batch = db.batch();
    await db.collection('players').get().then((snapshot) {
      snapshot.docs.forEach((document) {
        batch.delete(document.reference);
      });
    });

    batch.commit();
  }
}

class Player {
  String id;

  double dx;
  double dy;
  String race;
  double visionRange;
  double walkRange;
  double attackRange;
  int life;
  int maxLife;
  int weight;
  int maxWeight;
  Player(
      {String id,
      double dx,
      double dy,
      String race,
      double vision,
      double walkRange,
      double attackRange,
      int life,
      int maxLife,
      int weight,
      int maxWeight}) {
    this.id = id;
    this.dx = dx;
    this.dy = dy;
    this.race = race;
    this.visionRange = vision;
    this.walkRange = walkRange;
    this.attackRange = attackRange;
    this.life = life;
    this.maxLife = maxLife;
    this.weight = weight;
    this.maxWeight = maxWeight;
  }

  final db = FirebaseFirestore.instance;

  Map<String, dynamic> saveToDataBase(Player player) {
    return {
      'id': player.id,
      'dx': player.dx,
      'dy': player.dy,
      'race': player.race,
      'visionRange': player.visionRange,
      'walkRange': player.walkRange,
      'attackRange': player.attackRange,
      'life': player.life,
      'maxLife': player.maxLife,
      'weight': player.weight,
      'maxWeight': player.maxWeight,
    };
  }

  factory Player.fromMap(Map data) {
    return Player(
      id: data['id'],
      dx: data['dx'] * 1.0,
      dy: data['dy'] * 1.0,
      race: data['race'],
      vision: data['visionRange'] * 1.0,
      walkRange: data['walkRange'] * 1.0,
      attackRange: data['attackRange'] * 1.0,
      life: data['life'],
      maxLife: data['maxLife'],
      weight: data['weight'],
      maxWeight: data['maxWeight'],
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
      vision: 0,
      walkRange: 0,
      attackRange: 0,
      life: 0,
      maxLife: 0,
      weight: 0,
      maxWeight: 0,
    );
  }

  void setVisionRange() {
    this.visionRange = 100.0;
  }

  void setWalkRange() {
    this.walkRange = 50.0;
  }

  void setAttackRange() {
    this.attackRange = 30.0;
  }

  void setLife() {
    if (this.race == 'dwarf') {
      this.maxLife = 16;
      this.life = 16;
      return;
    }
    this.maxLife = 12;
    this.life = 12;
  }

  void setWeight() {
    if (this.race == 'orc') {
      this.maxWeight = 18;
      this.weight = 0;
      return;
    }
    this.maxWeight = 14;
    this.weight = 0;
  }

  void reduceCurrentLife(int value) async {
    this.life -= value;
    await db.collection('players').doc(this.id).update({'life': this.life});
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

  Offset getLocation() {
    return Offset(this.dx, this.dy);
  }

  int dealDamage() {
    int damage = Random().nextInt(6) + 1;
    print(damage);
    return damage;
  }
}

class PlayerTemporaryLocation extends ChangeNotifier {
  final db = FirebaseFirestore.instance;
  double dx = 0;
  double dy = 0;

  void walk(double dx, double dy) {
    this.dx += dx;
    this.dy += dy;
    notifyListeners();
  }

  void endWalk(String id) async {
    final batch = db.batch();
    final document = db.collection('players').doc(id);
    batch.update(document, {'dx': this.dx, 'dy': this.dy});
    await batch.commit();
  }

  void updatePlayerLocation(
    double dx,
    double dy,
  ) {
    this.dx = dx;
    this.dy = dy;
    notifyListeners();
  }
}
