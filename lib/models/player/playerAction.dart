import 'package:dsixv02app/models/player/option.dart';

class PlayerAction {
  String icon;
  String name;
  String description;
  List<Option> option;
  int value;
  // bool focus;

  PlayerAction(
    this.icon,
    this.name,
    this.description,
    this.option,
    this.value,
  );
}
