import 'package:dsixv02app/models/dsix/sprite.dart';

class Character {
  String icon;
  String name;
  int xp;
  Sprite sprite;

  Character copy() {
    Character newCharacter = Character(
      icon: this.icon,
      name: this.name,
      xp: this.xp,
      sprite: Sprite(
        layers: this.sprite.layers,
        size: this.sprite.size,
        location: this.sprite.location,
      ),
    );
    return newCharacter;
  }

  Character({
    String icon,
    String name,
    int xp,
    Sprite sprite,
  }) {
    this.icon = icon;
    this.name = name;
    this.xp = xp;
    this.sprite = sprite;
  }
}
