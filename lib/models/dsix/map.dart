import 'package:flutter/material.dart';

class Map {
  String name;
  String location;

  Widget layers = Container();

  Map copyMap() {
    Map newMap = new Map(
      name: this.name,
      location: this.location,
      layers: this.layers,
    );
    return newMap;
  }

  Map({String name, String location, Widget layers}) {
    this.name = name;
    this.location = location;
    this.layers = layers;
  }
}
