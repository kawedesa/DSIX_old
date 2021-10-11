import 'dart:math';
import 'package:dsixv02app/models/dsix/item.dart';
import 'package:dsixv02app/models/dsix/effect.dart';
import 'package:dsixv02app/models/player/action/playerAction.dart';
import 'package:dsixv02app/models/player/playerBackground.dart';
import 'package:dsixv02app/models/player/playerRace.dart';
import 'package:flutter/material.dart';

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
