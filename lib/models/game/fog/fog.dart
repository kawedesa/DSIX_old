import 'dart:math';
import 'package:dsixv02app/models/player/player.dart';
import 'package:flutter/material.dart';

class Fog {
  double? dx;
  double? dy;
  double? size;

  Fog({double? dx, double? dy, double? size}) {
    this.dx = dx;
    this.dy = dy;
    this.size = size;
  }

  Map<String, dynamic> toMap() {
    return {
      'dx': this.dx,
      'dy': this.dy,
      'size': this.size,
    };
  }

  factory Fog.empty() {
    return Fog(
      dx: 0,
      dy: 0,
      size: 0,
    );
  }

  factory Fog.fromMap(Map<String, dynamic>? data) {
    return Fog(
      dx: data?['dx'] * 1.0,
      dy: data?['dy'] * 1.0,
      size: data?['size'] * 1.0,
    );
  }
  factory Fog.newFog(double? mapSize) {
    double dx = (Random().nextDouble() * mapSize! * 0.8) + (mapSize * 0.1);
    double dy = (Random().nextDouble() * mapSize * 0.8) + (mapSize * 0.1);

    return Fog(
      dx: dx,
      dy: dy,
      size: mapSize * 2,
    );
  }

  Offset getLocation() {
    return Offset(this.dx!, this.dy!);
  }

  void shrink() {
    this.size = this.size! - 32;
    if (this.size! < 50) {
      this.size = 50;
    }
  }

  void checkFog(String gameID, Player player) {
    double distance = (player.location!.getLocation() - getLocation()).distance;
    if (distance >= this.size! / 2) {
      takeFogDamage(gameID, player);
    }
  }

  void takeFogDamage(
    String gameID,
    Player player,
  ) {
    player.life!.decrease(gameID, player.id!, 2);
  }
}
