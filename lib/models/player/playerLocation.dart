import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dsixv02app/models/game/gameMap/gameMap.dart';
import 'package:dsixv02app/models/game/gameMap/totalArea.dart';
import 'package:dsixv02app/models/player/sprite/playerTempLocation.dart';
import 'package:flutter/material.dart';

class PlayerLocation {
  double? dx;
  double? dy;
  int? height;
  bool? isVisible;
  PlayerLocation({double? dx, double? dy, int? height, bool? isVisible}) {
    this.dx = dx;
    this.dy = dy;
    this.height = height;
    this.isVisible = isVisible;
  }
  Map<String, dynamic> toMap() {
    return {
      'dx': this.dx,
      'dy': this.dy,
      'height': this.height,
      'isVisible': this.isVisible,
    };
  }

  factory PlayerLocation.fromMap(Map<String, dynamic>? data) {
    return PlayerLocation(
      dx: data?['dx'] * 1.0,
      dy: data?['dy'] * 1.0,
      height: data?['height'],
      isVisible: data?['isVisible'],
    );
  }

  factory PlayerLocation.randomLocation(GameMap map) {
    int i = 0;
    double dx = 0;
    double dy = 0;
    Offset newOffset = Offset(0, 0);
    bool isVisible = true;
    int height = 0;

    while (i < 1) {
      dx = (Random().nextDouble() * map.size! * 0.9) + (map.size! * 0.05);
      dy = (Random().nextDouble() * map.size! * 0.9) + (map.size! * 0.05);

      newOffset = Offset(dx, dy);

      if (map.tallGrass!.inThisArea(newOffset)) {
        isVisible = false;
      }

      height = map.heightMap!.inThisLayer(newOffset);

      if (height != 10) {
        i++;
      }
    }

    return PlayerLocation(dx: dx, dy: dy, isVisible: isVisible, height: height);
  }

  Offset getLocation() {
    return Offset(this.dx!.toDouble(), this.dy!.toDouble());
  }

  void newLocation(
    String gameID,
    String playerIndex,
    PlayerTempLocation newLocation,
    TotalArea tallGrass,
    int newHeight,
  ) {
    this.dx = newLocation.dx;
    this.dy = newLocation.dy;

    if (tallGrass.inThisArea(newLocation.getLocation())) {
      this.isVisible = false;
    } else {
      this.isVisible = true;
    }

    this.height = newHeight;

    update(gameID, playerIndex);
  }

  void update(String gameID, String playerIndex) async {
    final database = FirebaseFirestore.instance.collection('game');
    await database.doc(gameID).collection('players').doc(playerIndex).update({
      'location': toMap(),
    });
  }
}
