import 'package:dsixv02app/models/gm/character.dart';

class Location {
  String icon;
  String name;
  String description;
  List<Character> characters = [];

  Location({
    String icon,
    String name,
    String description,
    List<Character> characters,
  }) {
    this.icon = icon;
    this.name = name;
    this.description = description;
    this.characters = characters;
  }
}
