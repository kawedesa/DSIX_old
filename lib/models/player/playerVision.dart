import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dsixv02app/models/player/playerLocation.dart';
import 'package:flutter/material.dart';

class PlayerVision {
  double? tempVision;
  double? heightBonus;
  double? vision;
  bool? canSeeInvisible;
  PlayerVision({
    double? tempVision,
    double? heightBonus,
    double? vision,
    bool? canSeeInvisible,
  }) {
    this.tempVision = tempVision;
    this.heightBonus = heightBonus;
    this.vision = vision;
    this.canSeeInvisible = canSeeInvisible;
  }
  Map<String, dynamic> toMap() {
    return {
      'tempVision': this.tempVision,
      'heightBonus': this.heightBonus,
      'vision': this.vision,
      'canSeeInvisible': this.canSeeInvisible,
    };
  }

  factory PlayerVision.fromMap(Map<String, dynamic>? data) {
    return PlayerVision(
      tempVision: data?['tempVision'] * 1.0,
      heightBonus: data?['heightBonus'] * 1.0,
      vision: data?['vision'] * 1.0,
      canSeeInvisible: data?['canSeeInvisible'],
    );
  }
  factory PlayerVision.set(String race) {
    double vision;
    if (race == 'elf') {
      vision = 150.0;
    } else {
      vision = 120.0;
    }

    return PlayerVision(
      tempVision: 0,
      heightBonus: 0,
      vision: vision,
      canSeeInvisible: false,
    );
  }

  void look(String gameID, String playerIndex) {
    this.canSeeInvisible = true;
    update(gameID, playerIndex);
  }

  bool canSeeEnemyPlayer(PlayerLocation target, PlayerLocation player) {
    double distanceFromTarget =
        (target.getLocation() - player.getLocation()).distance;

    if (target.isVisible == true && distanceFromTarget < getRange() / 2) {
      return true;
    }

    if (target.isVisible == false &&
        this.canSeeInvisible == true &&
        distanceFromTarget < getRange() / 2) {
      return true;
    }

    return false;
  }

  bool canSeeLoot(Offset targetLocation, Offset playerLocation) {
    double distanceFromTarget = (targetLocation - playerLocation).distance;

    if (distanceFromTarget < getRange() / 2) {
      return true;
    }

    return false;
  }

  double getRange() {
    return (this.vision! + this.tempVision! + this.heightBonus!);
  }

  void reset() {
    this.canSeeInvisible = false;
    this.tempVision = 0;
  }

  void update(String gameID, String playerIndex) async {
    final database = FirebaseFirestore.instance.collection('game');

    await database.doc(gameID).collection('players').doc(playerIndex).update({
      'vision': toMap(),
    });
  }
}
