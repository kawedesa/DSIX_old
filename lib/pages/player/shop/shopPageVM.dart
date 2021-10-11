import 'package:dsixv02app/models/dsix/item.dart';
import 'package:dsixv02app/models/dsix/shop.dart';

import 'package:dsixv02app/widgets/selector.dart';

class ShopPageVM {
  String title = 'shop';
  String description =
      'Don\'t forget to buy stuff! The world is a dangerous place. Select the category above and click on the item to see it.';
  Selector selector = Selector();

  List<Item> selectedMenu = [];

  final List<String> menu = [
    'lightWeapon',
    'heavyWeapon',
    'rangedWeapon',
    'magicWeapon',
    'armor',
    'resources',
  ];

  menuSelection(Shop shop, int index) {
    this.selector.select(index);
    this.selectedMenu = [];
    switch (index) {
      case 0:
        this.title = 'light weapons';

        this.selectedMenu = shop.lightWeapons;
        break;
      case 1:
        this.title = 'heavy weapons';

        this.selectedMenu = shop.heavyWeapons;
        break;
      case 2:
        this.title = 'ranged weapons';

        this.selectedMenu = shop.rangedWeapons;
        break;
      case 3:
        this.title = 'magic weapons';

        this.selectedMenu = shop.magicWeapons;
        break;
      case 4:
        this.title = 'armor';

        this.selectedMenu = shop.armor;
        break;
      case 5:
        this.title = 'resources';

        this.selectedMenu = shop.resources;
        break;
    }
  }
}
