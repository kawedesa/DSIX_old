import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dsixv02app/models/player/playerLocation.dart';
import 'package:dsixv02app/models/shop/item.dart';
import 'package:flutter/material.dart';

class PlayerAttackRange {
  double? min;
  double? max;
  PlayerAttackRange({double? min, double? max}) {
    this.min = min;
    this.max = max;
  }
  Map<String, dynamic> toMap() {
    return {
      'min': this.min,
      'max': this.max,
    };
  }

  factory PlayerAttackRange.fromMap(Map<String, dynamic>? data) {
    return PlayerAttackRange(
      min: data?['min'] * 1.0,
      max: data?['max'] * 1.0,
    );
  }
  factory PlayerAttackRange.empty() {
    return PlayerAttackRange(min: 0, max: 30);
  }

  void increase(Item item) {
    this.max = this.max! + item.maxWeaponRange!;
    this.min = this.min! + item.minWeaponRange!;
  }

  void decrease(Item item) {
    this.max = this.max! - item.maxWeaponRange!;
    this.min = this.min! - item.minWeaponRange!;
  }

  bool cantAttack(PlayerLocation targetLocation, PlayerLocation playerLocation,
      bool rangedAttack) {
    bool withinHeight = checkHeight(
        targetLocation.height!, playerLocation.height!, rangedAttack);
    bool withinDistance = checkDistance(
        targetLocation.getLocation(), playerLocation.getLocation());

    if (withinHeight && withinDistance) {
      return false;
    } else {
      return true;
    }
  }

  bool checkHeight(int targetHeight, int playerHeight, bool rangedAttack) {
    if (rangedAttack) {
      return true;
    }

    int maxRange = targetHeight + 1;
    int minRange = targetHeight - 1;

    if (playerHeight < minRange || playerHeight > maxRange) {
      return false;
    } else {
      return true;
    }
  }

  bool checkDistance(Offset targetLocation, Offset playerLocation) {
    double distance = (targetLocation - playerLocation).distance;

    if (distance > this.max! / 2 || distance < this.min! / 2) {
      return false;
    } else {
      return true;
    }
  }

  double setMaxRange(String mode, double vision) {
    switch (mode) {
      case 'walk':
        return 0;

      case 'wait':
        return 0;

      case 'menu':
        return 0;

      case 'attack':
        if (max! > vision) {
          return vision;
        } else {
          return max!;
        }
    }

    return 0.0;
  }

  double setMinRange(String mode) {
    switch (mode) {
      case 'walk':
        return 0;

      case 'wait':
        return 0;

      case 'menu':
        return 0;

      case 'attack':
        return min!;
    }

    return 0.0;
  }

  void update(String gameID, String playerIndex) async {
    final database = FirebaseFirestore.instance.collection('game');

    await database.doc(gameID).collection('players').doc(playerIndex).update({
      'attackRange': toMap(),
    });
  }
}
