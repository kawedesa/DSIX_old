import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class PlayerVision {
  double? tempVision;
  double? vision;
  bool? canSeeInvisible;
  PlayerVision({
    double? tempVision,
    double? vision,
    bool? canSeeInvisible,
  }) {
    this.tempVision = tempVision;
    this.vision = vision;
    this.canSeeInvisible = canSeeInvisible;
  }
  Map<String, dynamic> toMap() {
    return {
      'tempVision': this.tempVision,
      'vision': this.vision,
      'canSeeInvisible': this.canSeeInvisible,
    };
  }

  factory PlayerVision.fromMap(Map<String, dynamic>? data) {
    return PlayerVision(
      tempVision: data?['tempVision'] * 1.0,
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
      vision: vision,
      canSeeInvisible: false,
    );
  }

  void look(String gameID, String playerIndex) {
    this.canSeeInvisible = true;
    update(gameID, playerIndex);
  }

  bool cantSee(
      Offset targetLocation, bool targetIsVisible, Offset playerLocation) {
    if (targetIsVisible == false && this.canSeeInvisible == false) {
      return true;
    }

    double distanceFromTarget = (targetLocation - playerLocation).distance;

    if (distanceFromTarget > getRange() / 2) {
      return true;
    } else {
      return false;
    }
  }

  double getRange() {
    return (this.vision! + this.tempVision!);
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
