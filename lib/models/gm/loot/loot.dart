import 'package:dsixv02app/models/dsix/item.dart';
import 'package:flutter/cupertino.dart';

class Loot {
  Widget image;
  String name;
  double size;
  bool opened;
  int gold;
  List<Item> item;
  Offset location;

  // Loot copy() {
  //   Loot newLoot = Loot(
  //     icon: this.icon,
  //     name: this.name,
  //     value: this.value,
  //     sprite: LootSprite(
  //       size: this.sprite.size,
  //       location: this.sprite.location,
  //     ),
  //   );
  //   return newLoot;
  // }

  Loot(
      {Widget image,
      String name,
      double size,
      bool opened,
      int gold,
      List<Item> item,
      Offset location}) {
    this.image = image;
    this.name = name;
    this.size = size;
    this.opened = opened;
    this.gold = gold;
    this.item = item;
    this.location = location;
  }
}
