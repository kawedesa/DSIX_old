import 'dart:math';
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
}
