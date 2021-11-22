import 'package:dsixv02app/core/app_icon.dart';
import 'package:dsixv02app/models/dsix/sprite.dart';
import 'package:flutter/cupertino.dart';

class Character {
  AppIcon icon;
  String name;
  int xp;
  double size;
  Offset location;

  Character copy() {
    Character newCharacter = Character(
      icon: this.icon,
      name: this.name,
      xp: this.xp,
      size: this.size,
      location: this.location,
    );
    return newCharacter;
  }

  Character({
    AppIcon icon,
    String name,
    int xp,
    double size,
    Offset location,
  }) {
    this.icon = icon;
    this.name = name;
    this.xp = xp;
    this.size = size;
    this.location = location;
  }
}
