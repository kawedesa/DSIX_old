import 'dart:math';

import 'package:dsixv02app/shared/app_Icons.dart';

import 'item.dart';

class Shop {
  Item randomItem() {
    Item newItem;
    int randomItem;
    switch (randomCategory()) {
      case 'lightWeapons':
        randomItem = Random().nextInt(this.lightWeapons.length);
        newItem = lightWeapons[randomItem];
        break;
      case 'heavyWeapons':
        randomItem = Random().nextInt(this.heavyWeapons.length);
        newItem = heavyWeapons[randomItem];
        break;
      case 'armor':
        randomItem = Random().nextInt(this.armor.length);
        newItem = armor[randomItem];
        break;
    }
    return newItem;
  }

  String randomCategory() {
    List<String> category = [
      'lightWeapons',
      'heavyWeapons',
      'armor',
    ];
    int randomCategory = Random().nextInt(category.length);
    return category[randomCategory];
  }

  List<Item> lightWeapons = [
    Item(
      icon: AppIcons.dagger,
      name: 'dagger',
      itemSlot: 'oneHand',
      pDamage: 1,
      mDamage: 0,
      pArmor: 0,
      mArmor: 0,
      weight: 1,
      weaponRange: 5,
    ),
  ];
  List<Item> heavyWeapons = [
    Item(
      icon: AppIcons.longSpear,
      name: 'long spear',
      itemSlot: 'twoHands',
      pDamage: 3,
      mDamage: 0,
      pArmor: 0,
      mArmor: 0,
      weight: 2,
      weaponRange: 30,
    ),
  ];

  List<Item> armor = [
    Item(
      icon: AppIcons.boots,
      name: 'boots',
      itemSlot: 'feet',
      pDamage: 0,
      pArmor: 1,
      mDamage: 0,
      mArmor: 0,
      weight: 1,
      weaponRange: 0,
    ),
    Item(
      icon: AppIcons.gloves,
      name: 'gloves',
      itemSlot: 'hands',
      pDamage: 0,
      pArmor: 1,
      mDamage: 0,
      mArmor: 0,
      weight: 1,
      weaponRange: 0,
    ),
    Item(
      icon: AppIcons.helmet,
      name: 'helmet',
      itemSlot: 'head',
      pDamage: 0,
      pArmor: 2,
      mDamage: 0,
      mArmor: 0,
      weight: 1,
      weaponRange: 0,
    ),
    Item(
      icon: AppIcons.lightArmor,
      name: 'light armor',
      itemSlot: 'body',
      pDamage: 0,
      pArmor: 4,
      mDamage: 0,
      mArmor: 0,
      weight: 4,
      weaponRange: 0,
    ),
  ];
}
