import 'package:dsixv02app/models/dsix/item.dart';
import 'bonus.dart';

class PlayerBackground {
  String icon;
  String name;
  String description;
  List<Bonus> bonus;
  List<Item> bonusItem;

  PlayerBackground(
      {String icon,
      String name,
      String description,
      List<Bonus> bonus,
      List<Item> bonusItem}) {
    this.icon = icon;
    this.name = name;
    this.description = description;
    this.bonus = bonus;
    this.bonusItem = bonusItem;
  }
}
