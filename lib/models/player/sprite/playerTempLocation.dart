import 'package:flutter/material.dart';

class PlayerTempLocation extends ChangeNotifier {
  double? dx;
  double? dy;
  PlayerTempLocation({double? dx, double? dy}) {
    this.dx = dx;
    this.dy = dy;
  }

  void walk(double dx, double dy) {
    this.dx = this.dx! + dx;
    this.dy = this.dy! + dy;
    notifyListeners();
  }

  void updatePlayerLocation(double? dx, double? dy) {
    this.dx = dx;
    this.dy = dy;
  }
}
