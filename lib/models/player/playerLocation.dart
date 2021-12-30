import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dsixv02app/models/game/gameMap/heightMap.dart';
import 'package:dsixv02app/models/game/gameMap/totalArea.dart';
import 'package:dsixv02app/models/player/sprite/playerTempLocation.dart';
import 'package:dsixv02app/shared/app_Exceptions.dart';
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
  factory PlayerLocation.newLocation(PlayerLocation location) {
    return PlayerLocation(
      dx: location.dx,
      dy: location.dy,
      height: location.height,
      isVisible: location.isVisible,
    );
  }

  Offset getLocation() {
    return Offset(this.dx!.toDouble(), this.dy!.toDouble());
  }

  void endWalk(
    String gameID,
    String playerIndex,
    PlayerTempLocation newLocation,
    TotalArea tallGrass,
    HeightMap height,
  ) {
    int newHeight = height.inThisLayer(newLocation.getLocation());

    if (newHeight != newLocation.height) {
      throw CantPassException();
    }

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
