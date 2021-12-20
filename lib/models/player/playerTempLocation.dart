import 'package:flutter/material.dart';

class PlayerTempLocation extends ChangeNotifier {
  double dx = 0;
  double dy = 0;

  void walk(double dx, double dy) {
    this.dx += dx;
    this.dy += dy;
    notifyListeners();
  }

  void updatePlayerLocation(
    double dx,
    double dy,
  ) {
    this.dx = dx;
    this.dy = dy;
  }
}
