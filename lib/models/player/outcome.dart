import 'package:dsixv02app/models/shared/item.dart';

class Outcome {
  String name;
  String description;
  List<Item> itemList;
  bool selected;

  Outcome({
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
