import 'package:dsixv02app/models/dsix/item.dart';
import 'package:flutter/cupertino.dart';

class Loot {
  String name;
  String type;
  bool opened;
  int gold;
  List<Item> item;
  Offset location;

  Loot(
      {Widget image,
      String name,
      String type,
      double size,
      bool opened,
      int gold,
      List<Item> item,
      Offset location}) {
    this.name = name;
    this.type = type;

    this.opened = opened;
    this.gold = gold;
    this.item = item;
    this.location = location;
  }
}
