import 'package:dsixv02app/models/player/option.dart';

class PlayerAction {
  String icon;
  String name;
  String description;
  List<Option> option;
  int value;

  PlayerAction copyAction() {
    PlayerAction newPlayerAction = PlayerAction(
      icon: this.icon,
      name: this.name,
      description: this.description,
      option: this.option,
      value: this.value,
    );
    List<Option> newOptions = [];
    newPlayerAction.option.forEach((element) {
      newOptions.add(element.copyOption());
    });
    newPlayerAction.option = newOptions;

    return newPlayerAction;
  }

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
  }
}
