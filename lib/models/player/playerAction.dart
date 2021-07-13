import 'package:dsixv02app/models/player/option.dart';

class PlayerAction {
  String icon;
  String name;
  String description;
  List<Option> option;
  int value;
  int bonus;
  // bool focus;

  PlayerAction(
      {String icon,
      String name,
      String description,
      List<Option> option,
      int value,
      int bonus}) {
    this.icon = icon;
    this.name = name;
    this.description = description;
    this.option = option;
    this.value = value;
    this.bonus = bonus;
  }
}
