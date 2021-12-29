import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dsixv02app/models/game/gameMap/tallGrassArea.dart';
import 'package:flutter/material.dart';

class PlayerLocation {
  double? dx;
  double? dy;
  bool? isVisible;
  PlayerLocation({double? dx, double? dy, bool? isVisible}) {
    this.dx = dx;
    this.dy = dy;
    this.isVisible = isVisible;
  }
  Map<String, dynamic> toMap() {
    return {
      'dx': this.dx,
      'dy': this.dy,
      'isVisible': this.isVisible,
    };
  }

  factory PlayerLocation.fromMap(Map<String, dynamic>? data) {
    return PlayerLocation(
      dx: data?['dx'] * 1.0,
      dy: data?['dy'] * 1.0,
      isVisible: data?['isVisible'],
    );
  }
  factory PlayerLocation.newLocation(
    Offset location,
  ) {
    return PlayerLocation(
      dx: location.dx,
      dy: location.dy,
      isVisible: true,
    );
  }

  Offset getLocation() {
    return Offset(this.dx!.toDouble(), this.dy!.toDouble());
  }

  void endWalk(
    String gameID,
    String playerIndex,
    PlayerLocation newLocation,
    TallGrassArea tallGrass,
  ) async {
    this.dx = newLocation.dx;
    this.dy = newLocation.dy;

    if (inTallGrass(tallGrass)) {
      this.isVisible = false;
    } else {
      this.isVisible = true;
    }

    update(gameID, playerIndex);
  }

  bool inTallGrass(TallGrassArea tallgrass) {
    bool inThere = false;

    tallgrass.totalArea!.forEach((grass) {
      if (inThere) {
        return;
      }
      inThere = grass.inHere(this.getLocation());
    });

    return inThere;
  }

  void update(String gameID, String playerIndex) async {
    final database = FirebaseFirestore.instance.collection('game');
    await database.doc(gameID).collection('players').doc(playerIndex).update({
      'location': toMap(),
    });
  }
}
