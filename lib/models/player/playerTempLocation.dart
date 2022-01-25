import 'package:dsixv02app/models/game/gameMap/heightMap.dart';
import 'package:flutter/material.dart';
import 'playerLocation.dart';

class PlayerTempLocation extends ChangeNotifier {
  Offset? newLocation;
  Offset? originalLocation;
  int? height;
  PlayerTempLocation({
    Offset? newLocation,
    Offset? originalLocation,
    int? height,
  }) {
    this.newLocation = newLocation;
    this.originalLocation = originalLocation;
    this.height = height;
  }

  void startWalk(int currentHeight, Offset originalLocation) {
    this.height = currentHeight;
    this.originalLocation = originalLocation;
  }

  void walk(
    double dx,
    double dy,
    HeightMap height,
    double maxWalkRange,
  ) {
    double newDx;
    double newDy;

    if (dx > 0.5) {
      newDx = this.newLocation!.dx + 0.5;
    } else if (dx < -0.5) {
      newDx = this.newLocation!.dx - 0.5;
    } else {
      newDx = this.newLocation!.dx + dx;
    }

    if (dy > 0.5) {
      newDy = this.newLocation!.dy + 0.5;
    } else if (dy < -0.5) {
      newDy = this.newLocation!.dy - 0.5;
    } else {
      newDy = this.newLocation!.dy + dy;
    }

    int newHeight = height.inThisLayer(getNewLocation());

    int maxHeight = newHeight + 1;
    int minHeight = newHeight - 1;

    if (this.height! < minHeight || this.height! > maxHeight) {
      if (newDx > this.originalLocation!.dx) {
        newDx -= 0.55;
      } else {
        newDx += 0.55;
      }
      if (newDy > this.originalLocation!.dy) {
        newDy -= 0.55;
      } else {
        newDy += 0.55;
      }
      this.newLocation = Offset(newDx, newDy);
      return;
    }

    if (distanceLeftOver(maxWalkRange)! <= 0) {
      if (newDx > this.originalLocation!.dx) {
        newDx -= 0.25;
      } else {
        newDx += 0.25;
      }
      if (newDy > this.originalLocation!.dy) {
        newDy -= 0.25;
      } else {
        newDy += 0.25;
      }
    }

    this.height = newHeight;
    this.newLocation = Offset(newDx, newDy);

    notifyListeners();
  }

  void updatePlayerLocation(PlayerLocation location) {
    this.newLocation = location.getLocation();
    this.originalLocation = location.getLocation();
    this.height = location.height;
  }

  Offset getNewLocation() {
    return this.newLocation!;
  }

  double? distanceLeftOver(double maxWalkRange) {
    double distanceLeftOver =
        (this.newLocation! - this.originalLocation!).distance * 2;

    if (maxWalkRange - distanceLeftOver < 0) {
      distanceLeftOver = 0;
    } else {
      distanceLeftOver = maxWalkRange - distanceLeftOver;
    }
    return distanceLeftOver;
  }
}
