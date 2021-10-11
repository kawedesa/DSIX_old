import 'package:dsixv02app/models/dsix/item.dart';

class ActionOutcome {
  String name;
  String description;
  List<Item> itemList;
  bool selected;

  ActionOutcome({
    String name,
    String description,
    List<Item> itemList,
    bool selected,
  }) {
    this.name = name;
    this.description = description;
    this.itemList = itemList;
    this.selected = selected;
  }
}
