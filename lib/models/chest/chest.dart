import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dsixv02app/models/shop/item.dart';
import 'package:dsixv02app/models/shop/shop.dart';
import 'package:flutter/material.dart';

class Chest {
  String? gameID;
  int? index;
  ChestLocation? location;
  List<Item>? loot;
  bool? isClosed;
  Chest(
      {String? gameID,
      int? index,
      ChestLocation? location,
      List<Item>? loot,
      bool? isClosed}) {
    this.gameID = gameID;
    this.index = index;
    this.location = location;
    this.loot = loot;
    this.isClosed = isClosed;
  }

  Map<String, dynamic> toMap() {
    var loot = this.loot!.map((item) => item.toMap()).toList();

    return {
      'gameID': this.gameID,
      'index': this.index,
      'location': this.location!.toMap(),
      'loot': loot,
      'isClosed': this.isClosed,
    };
  }

  factory Chest.fromMap(Map data) {
    List<Item> loot = [];
    List<dynamic> itemsMap = data['loot'];
    itemsMap.forEach((item) {
      loot.add(new Item.fromMap(item));
    });

    return Chest(
      gameID: data['gameID'],
      index: data['index'],
      location: ChestLocation.fromMap(data['location']),
      loot: loot,
      isClosed: data['isClosed'],
    );
  }

  factory Chest.newLoot(String gameID, ChestLocation location, int index) {
    return Chest(
      gameID: gameID,
      index: index,
      location: location,
      loot: [],
      isClosed: true,
    );
  }

  Shop _shop = Shop();

  void openLoot(String gameID) {
    this.isClosed = false;
    int numberOfLoot = Random().nextInt(3) + 1;

    for (int i = 0; i < numberOfLoot; i++) {
      this.loot!.add(_shop.randomItem());
    }
    update();
  }

  void getItem(Item addToChest) {
    this.loot!.add(addToChest);

    update();
  }

  void removeItem(Item removedFromChest) {
    this.loot!.remove(removedFromChest);

    update();
  }

  void update() async {
    final database = FirebaseFirestore.instance;
    await database
        .collection('game')
        .doc(this.gameID!)
        .collection('loot')
        .doc('${this.index}')
        .update(toMap());
  }
}

class ChestLocation {
  double? dx;
  double? dy;
  ChestLocation({double? dx, double? dy}) {
    this.dx = dx;
    this.dy = dy;
  }
  Map<String, dynamic> toMap() {
    return {
      'dx': this.dx,
      'dy': this.dy,
    };
  }

  factory ChestLocation.fromMap(Map<String, dynamic>? data) {
    return ChestLocation(
      dx: data?['dx'] * 1.0,
      dy: data?['dy'] * 1.0,
    );
  }
  factory ChestLocation.newLocation(Offset location) {
    return ChestLocation(
      dx: location.dx,
      dy: location.dy,
    );
  }

  Offset getLocation() {
    return Offset(this.dx!.toDouble(), this.dy!.toDouble());
  }
}
