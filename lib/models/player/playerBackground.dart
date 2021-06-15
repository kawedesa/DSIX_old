import '../shared/item.dart';
import 'bonus.dart';

class PlayerBackground {
  String icon;
  String background;
  String description;
  List<Bonus> bonus;
  List<Item> bonusItem;

  PlayerBackground(
      this.icon, this.background, this.description, this.bonus, this.bonusItem);
}
