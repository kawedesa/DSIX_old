import 'package:dsixv02app/models/shared/item.dart';
import 'package:dsixv02app/models/shared/shop.dart';
import 'dart:math';

class Loot {
  Shop shop = new Shop();

  String icon = 'loot';
  String name = 'NEW LOOT';
  String lootDescription =
      'Each loot should have an interesting orign. Like the sword of an old king or the artifacts of a powerful wizzard. Double tap this text to edit it and write your own description.';

  List<Item> itemList = [];

  Loot rewardItemLoot(int rounds) {
    int max = rounds * 300;
    int min = rounds * 200;

    Loot newLoot = Loot().newLoot();
    newLoot.itemList.add(this.shop.randomItemRange(min, max).copyItem());
    newLoot.name = newLoot.itemList.first.name;
    newLoot.icon = newLoot.itemList.first.icon;
    newLoot.lootDescription = 'Quest reward.';

    return newLoot;
  }

  Loot newLoot() {
    Loot newLoot = new Loot(
      icon: 'loot',
      name: 'NEW LOOT',
      lootDescription:
          'Each loot should have an interesting orign. Like the sword of an old king or the artifacts of a powerful wizzard. Double tap this text to edit it and write your own description.',
      itemList: [],
    );

    return newLoot;
  }

  Loot copyLoot() {
    Loot newLoot = Loot(
      icon: this.icon,
      name: this.name,
      lootDescription: this.lootDescription,
      itemList: this.itemList,
    );
    return newLoot;
  }

  void deleteLoot(Item item) {
    this.itemList.remove(item);
  }

  void randomLoot(int value) {
    value = value * 100;

    List<String> shopMenu = [
      'lightWeapons',
      'heavyWeapons',
      'rangedWeapons',
      'magicWeapons',
      'armor',
      'resources'
    ];

    int menuSelection;
    int randomItem;
    this.itemList = [];
    while (value > 0) {
      menuSelection = Random().nextInt(shopMenu.length);

      switch (shopMenu[menuSelection]) {
        case 'lightWeapons':
          randomItem = Random().nextInt(shop.lightWeapons.length);

          if (shop.lightWeapons[randomItem].value <= value) {
            this.itemList.add(shop.lightWeapons[randomItem].copyItem());
            value -= shop.lightWeapons[randomItem].value;
          }

          break;

        case 'heavyWeapons':
          randomItem = Random().nextInt(shop.heavyWeapons.length);

          if (shop.heavyWeapons[randomItem].value <= value) {
            this.itemList.add(shop.heavyWeapons[randomItem].copyItem());
            value -= shop.heavyWeapons[randomItem].value;
          }

          break;

        case 'rangedWeapons':
          randomItem = Random().nextInt(shop.rangedWeapons.length);

          if (shop.rangedWeapons[randomItem].value <= value) {
            this.itemList.add(shop.rangedWeapons[randomItem].copyItem());
            value -= shop.rangedWeapons[randomItem].value;
          }

          break;

        case 'magicWeapons':
          randomItem = Random().nextInt(shop.magicWeapons.length);

          if (shop.magicWeapons[randomItem].value <= value) {
            this.itemList.add(shop.magicWeapons[randomItem].copyItem());
            value -= shop.magicWeapons[randomItem].value;
          }

          break;

        case 'armor':
          randomItem = Random().nextInt(shop.armor.length);

          if (shop.armor[randomItem].value <= value) {
            this.itemList.add(shop.armor[randomItem].copyItem());
            value -= shop.armor[randomItem].value;
          }

          break;

        case 'resources':
          randomItem = Random().nextInt(shop.resources.length);

          if (shop.resources[randomItem].value <= value) {
            this.itemList.add(shop.resources[randomItem].copyItem());
            value -= shop.resources[randomItem].value;
          }

          break;
      }
    }
  }

  Loot(
      {String icon, String name, String lootDescription, List<Item> itemList}) {
    this.icon = icon;
    this.name = name;
    this.lootDescription = lootDescription;
    this.itemList = itemList;
  }
}
