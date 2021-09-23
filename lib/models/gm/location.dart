import 'package:dsixv02app/models/gm/character.dart';

class Location {
  String icon;
  String name;
  String description;
  List<Character> possibleCharacters = [];

  Location({
    String icon,
    String name,
    String description,
    List<Character> possibleCharacters,
  }) {
    this.icon = icon;
    this.name = name;
    this.description = description;
    this.possibleCharacters = possibleCharacters;
  }
}
