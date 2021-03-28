import 'package:dsixv02app/option.dart';

class PlayerSkill {
  int index;
  String type;
  String name;
  String attribute;
  String description;
  List<Option> options;
  bool focus;

  PlayerSkill(this.index, this.type, this.name, this.attribute,
      this.description, this.options, this.focus);
}
