import 'package:dsixv02app/models/game/gameMap/heightMap.dart';
import 'package:flutter/material.dart';
import '../playerLocation.dart';

class PlayerTempLocation extends ChangeNotifier {
  double? dx;
  double? dy;
  int? height;
  PlayerTempLocation({
    double? dx,
    double? dy,
    int? height,
  }) {
    this.dx = dx;
    this.dy = dy;
    this.height = height;
  }

  void startWalk(int currentHeight) {
    this.height = currentHeight;
  }

  void walk(
    double dx,
    double dy,
    HeightMap height,
  ) {
    int newHeight = height.inThisLayer(getLocation());

    int maxHeight = newHeight + 1;
    int minHeight = newHeight - 1;

    if (this.height! < minHeight || this.height! > maxHeight) {
      if (dx > 0) {
        this.dx = this.dx! - 1;
      } else {
        this.dx = this.dx! + 1;
      }
      if (dy > 0) {
        this.dy = this.dy! - 1;
      } else {
        this.dy = this.dy! + 1;
      }
      return;
    }

    this.height = newHeight;
    this.dx = this.dx! + dx;
    this.dy = this.dy! + dy;

    notifyListeners();
  }

  void updatePlayerLocation(PlayerLocation location) {
    this.dx = location.dx;
    this.dy = location.dy;
    this.height = location.height;
  }

  Offset getLocation() {
    return Offset(this.dx!, this.dy!);
  }

  double? distanceLeftOver(PlayerLocation location, double maxWalkRange) {
    double distanceLeftOver =
        (getLocation() - location.getLocation()).distance * 2;

    if (maxWalkRange - distanceLeftOver < 0) {
      distanceLeftOver = 0;
    } else {
      distanceLeftOver = maxWalkRange - distanceLeftOver;
    }
    return distanceLeftOver;
  }
}
