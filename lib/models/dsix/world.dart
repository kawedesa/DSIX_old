import 'package:flutter/material.dart';

import 'mapTile.dart';
import 'sprite.dart';
import 'dart:ui';

class World {
  //MAP, LOCATION, WORLD

  MapTile mapTile;
  double mapSize = 640;

  World createNewWorld() {
    World newWorld = World(
      mapTile: MapTile().createNewMap(this.mapSize),
    );

    return newWorld;
  }

  World({MapTile mapTile}) {
    this.mapTile = mapTile;
  }
}
