import 'characterSprite.dart';

class Character {
  String icon;
  String name;
  int xp;
  CharacterSprite sprite;

  Character copy() {
    Character newCharacter = Character(
      icon: this.icon,
      name: this.name,
      xp: this.xp,
      sprite: this.sprite,
    );
    return newCharacter;
  }

  Character({
    String icon,
    String name,
    int xp,
    CharacterSprite sprite,
  }) {
    this.icon = icon;
    this.name = name;
    this.xp = xp;
    this.sprite = sprite;
  }
}
