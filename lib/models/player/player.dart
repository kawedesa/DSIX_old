import 'dart:math';
import 'package:dsixv02app/core/app_images.dart';
import 'package:dsixv02app/models/dsix/item.dart';
import 'package:dsixv02app/models/dsix/effect.dart';
import 'package:dsixv02app/models/gm/character/character.dart';
import 'package:dsixv02app/models/gm/character/characterSprite.dart';
import 'package:dsixv02app/models/gm/gm.dart';
import 'package:dsixv02app/models/gm/loot/loot.dart';
import 'package:dsixv02app/models/gm/map/mapTile.dart';
import 'package:dsixv02app/models/player/action/playerAction.dart';
import 'package:dsixv02app/models/player/enemySprite.dart';
import 'package:dsixv02app/models/player/playerBackground.dart';
import 'package:dsixv02app/models/player/playerRace.dart';
import 'package:dsixv02app/models/player/playerSprite.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Player {
//Check player
  bool playerCreated = false;

//Name and color

  String name;
  Color primaryColor;
  Color secondaryColor;
  Color tertiaryColor;

  //Race
  PlayerRace race;

  //Background
  PlayerBackground background;

  //Actions
  int actionPoints;
  List<PlayerAction> actions = [];

//Health

  int health;

  void changeHealth(int value) {
    if (this.health + value > this.race.maxHealth) {
      this.health = this.race.maxHealth;
      return;
    }
    if (this.health + value < 1) {
      this.health = 0;
      return;
    }

    this.health += value;
  }

//Gold

  int gold;

  void changeGold(int value) {
    if (this.gold + value < 1) {
      this.gold = 0;
      return;
    }

    this.gold += value;
  }

//Fame
  int fame;

//Damage and Armor

  int pDamageEffect = 0;
  int mDamageEffect = 0;
  int pArmorEffect = 0;
  int mArmorEffect = 0;

  int pDamageTotal = 0;
  int mDamageTotal = 0;
  int pArmorTotal = 0;
  int mArmorTotal = 0;

  int pDamageItem = 0;
  int mDamageItem = 0;
  int pArmorItem = 0;
  int mArmorItem = 0;

//Items
  int weight = 0;
  List<Item> bag = [];

  Item headSlot = Item(icon: '');
  Item bodySlot = Item(icon: '');
  Item handSlot = Item(icon: '');
  Item feetSlot = Item(icon: '');
  Item mainHandSlot = Item(icon: '');
  Item offHandSlot = Item(icon: '');

//Effects
  List<Effect> currentEffects = [];

  void updateStats() {
    this.pDamageTotal = this.pDamageItem + this.pDamageEffect;
    this.mDamageTotal = this.mDamageItem + this.mDamageEffect;
    this.pArmorTotal = this.pArmorItem + this.pArmorEffect;
    this.mArmorTotal = this.mArmorItem + this.mArmorEffect;
  }

  void addItemStats(Item item) {
    this.pArmorItem += item.pArmor;
    this.pDamageItem += item.pDamage;
    this.mArmorItem += item.mArmor;
    this.mDamageItem += item.mDamage;
    updateStats();
  }

  void removeItemStats(Item item) {
    this.pArmorItem -= item.pArmor;
    this.pDamageItem -= item.pDamage;
    this.mArmorItem -= item.mArmor;
    this.mDamageItem -= item.mDamage;
    updateStats();
  }

  void unequipItem(Item item, String itemSlot) {
    if (itemSlot == 'bag') {
      return;
    }

    removeItemStats(item);
    this.bag.add(item);
    switch (item.inventorySpace) {
      case 'head':
        this.headSlot = new Item(icon: '');
        break;
      case 'body':
        this.bodySlot = new Item(icon: '');
        break;
      case 'hands':
        this.handSlot = new Item(icon: '');
        break;
      case 'feet':
        this.feetSlot = new Item(icon: '');
        break;
      case '1hand':
        if (itemSlot == 'mainHand') {
          this.mainHandSlot = new Item(icon: '');
        } else {
          this.offHandSlot = new Item(icon: '');
        }

        break;
      case '2hand':
        this.mainHandSlot = new Item(icon: '');
        this.offHandSlot = new Item(icon: '');
        break;
    }
  }

  void equipItem(Item item) {
    switch (item.inventorySpace) {
      case '1hand':
        if (checkEquip(mainHandSlot)) {
          this.mainHandSlot = item;
          addItemStats(item);
          this.bag.remove(item);
          return;
        }

        if (checkEquip(offHandSlot)) {
          this.offHandSlot = item;
          addItemStats(item);
          this.bag.remove(item);
          return;
        }

        unequipItem(this.mainHandSlot, 'mainHand');
        this.mainHandSlot = item;
        addItemStats(item);
        this.bag.remove(item);

        break;
      case '2hand':
        if (checkEquip(mainHandSlot) && checkEquip(offHandSlot)) {
          this.mainHandSlot = item;
          this.offHandSlot = item;
          addItemStats(item);
          this.bag.remove(item);
          return;
        }

        if (checkEquip(mainHandSlot) != true) {
          unequipItem(this.mainHandSlot, 'mainHand');
        }

        if (checkEquip(offHandSlot) != true) {
          unequipItem(this.offHandSlot, 'offHand');
        }

        this.mainHandSlot = item;
        this.offHandSlot = item;
        addItemStats(item);
        this.bag.remove(item);

        break;
      case 'head':
        if (checkEquip(this.headSlot)) {
          this.headSlot = item;
          addItemStats(item);
          this.bag.remove(item);
        } else {
          unequipItem(this.headSlot, 'head');
          this.headSlot = item;
          addItemStats(item);
          this.bag.remove(item);
        }
        break;
      case 'body':
        if (checkEquip(this.bodySlot)) {
          this.bodySlot = item;
          addItemStats(item);
          this.bag.remove(item);
        } else {
          unequipItem(this.bodySlot, 'body');
          this.bodySlot = item;
          addItemStats(item);
          this.bag.remove(item);
        }
        break;
      case 'hands':
        if (checkEquip(this.handSlot)) {
          this.handSlot = item;
          addItemStats(item);
          this.bag.remove(item);
        } else {
          unequipItem(this.handSlot, 'hands');
          this.handSlot = item;
          addItemStats(item);
          this.bag.remove(item);
        }
        break;
      case 'feet':
        if (checkEquip(this.feetSlot)) {
          this.feetSlot = item;
          addItemStats(item);
          this.bag.remove(item);
        } else {
          unequipItem(this.feetSlot, 'feet');
          this.feetSlot = item;
          addItemStats(item);
          this.bag.remove(item);
        }
        break;
    }
  }

  bool checkEquip(Item item) {
    if (item.icon == '') {
      return true;
    } else {
      return false;
    }
  }

  void sellItem(Item item, String itemSlot) {
    unequipItem(item, itemSlot);
    this.gold += item.value ~/ 2;
    this.bag.remove(item);
  }

  void useItem(Item item) {
    this.bag.remove(item);
  }

  void buyItem(Item item) {
    if (checkWeight(item)) {
      //TODO snackbars

      return;
    }
    if (checkGold(item)) {
      return;
    }

    this.gold -= item.value;
    this.weight += item.weight;
    this.bag.add(item.copyItem());
  }

  void heal(int min, max) {
    int _randomNumber = Random().nextInt(max + 1 - min) + min;
    if (this.health + _randomNumber > this.race.maxHealth) {
      this.health = this.race.maxHealth;
    } else {
      this.health += _randomNumber;
    }
  }

  bool checkGold(Item item) {
    if (item.value > this.gold) {
      //True se passar do valor
      return true;
    } else {
      return false;
    }
  }

  bool checkWeight(Item item) {
    if (item.weight + this.weight > this.race.maxWeight) {
      //True se passar do peso
      return true;
    } else {
      return false;
    }
  }

  double visionRange;
  double walkRange;

  void buildCanvas() {
    this.canvas = [];
    this.canvas.add(this.map);

    //Add enemies
    this.enemy.forEach((element) {
      if ((element.location - this.location).distance <= this.visionRange / 2) {
        this.canvas.add(element);
      }
    });

    //Add self
    this.canvas.add(this.sprite);

    //Add loot
    this.loot.forEach((element) {
      this.canvas.add(element);
    });
  }

  MapTile map;

  PlayerSprite sprite;

  List<EnemySprite> enemy = [];
  List<Loot> loot = [];

  // PlayerSprite newSprite = PlayerSprite(
  //   image: element.race.sprite.layers,
  //   size: element.race.size,
  //   visionRange: element.actions[2].value * 300.0,
  //   location: element.location,
  //   updateLocation: (details) async {
  //     print(element.location);

  //     element.location = Offset(element.location.dx + details.dx,
  //         element.location.dy + details.dy);

  //     element.navigation = TransformationController(Matrix4(
  //         3,
  //         0,
  //         0,
  //         0,
  //         0,
  //         3,
  //         0,
  //         0,
  //         0,
  //         0,
  //         3,
  //         0,
  //         -element.location.dx * 3 +
  //             (MediaQuery.of(context).size.width * 1.45) / 3 -
  //             element.race.size / 2,
  //         -element.location.dy * 3 +
  //             (MediaQuery.of(context).size.height * 1.2) / 3 -
  //             element.race.size / 2,
  //         0,
  //         1));

  //     print(element.location);
  //   },
  // );
  // element.canvas.add(newSprite);

  Offset location = Offset(0, 0);

  void updateLocation(Offset newPosition) {
    this.location = Offset(
        this.location.dx + newPosition.dx, this.location.dy + newPosition.dy);
  }

  TransformationController navigation = TransformationController(
      Matrix4(3, 0, 0, 0, 0, 3, 0, 0, 0, 0, 2, 0, 0, 0, 0, 3));

  List<Widget> canvas = [];

  // Widget vision = Container();

  // void setVision() {
  //   double visionRange = 300 + 60 * this.race.actionPoints[2].toDouble();

  //   this.vision = Positioned(
  //     left: this.race.sprite.location.dx -
  //         visionRange / 2 +
  //         this.race.sprite.size / 2,
  //     top: this.race.sprite.location.dy -
  //         visionRange / 2 +
  //         this.race.sprite.size / 2,
  //     child: SvgPicture.asset(
  //       AppImages.playerVision,
  //       color: Colors.black,
  //       width: visionRange,
  //       height: visionRange,
  //     ),
  //   );
  // }

  Player(
      {String name,
      Color primaryColor,
      Color secondaryColor,
      Color tertiaryColor}) {
    this.name = name;
    this.primaryColor = primaryColor;
    this.secondaryColor = secondaryColor;
    this.tertiaryColor = tertiaryColor;
  }
}
