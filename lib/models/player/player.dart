import 'dart:math';
import 'package:dsixv02app/models/player/playerRaceList.dart';
import 'package:dsixv02app/models/game/item.dart';
import 'package:dsixv02app/models/player/playerBackground.dart';
import 'package:flutter/material.dart';
import 'package:dsixv02app/models/player/playerRace.dart';
import 'package:dsixv02app/models/player/option.dart';
import 'package:dsixv02app/models/player/playerAction.dart';
import 'package:dsixv02app/models/game/effect.dart';
import 'exceptions.dart';
import 'package:dsixv02app/models/player/bonus.dart';
import 'package:dsixv02app/models/game/shop.dart';
import 'package:dsixv02app/models/player/playerBackgroundList.dart';
import 'package:dsixv02app/models/player/playerSkillList.dart';

class PlayerColor {
  String name;
  Color primaryColor;
  Color secondaryColor;
  Color tertiaryColor;

  PlayerColor(
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

Shop shop = new Shop();

class Player {
  // var playerIndex;

  PlayerColor playerColor;

  bool characterFinished = false;

  int actionsTaken = 0;

//CHOOSE RACE AND SEX // DEFINE HP, ACTION POINTS, WEIGHT, ACTIONS

  List<PlayerRace> availableRaces = PlayerRaceList().races;

  PlayerRace race = PlayerRace(
    'null',
    'RACES',
    'There are many races that live in this world. They vary in size, culture and color. Click on the icons above to choose your race.',
    [
      Bonus(
          'BONUS',
          'bonus',
          'Each race is unique and has different bonuses. Some are good, while others are bad. They affect how the game plays and the outcome of your actions.',
          0)
    ],
  );

  String playerSex = 'female';

  // int availableActionPoint;
  // List<int> originalActionPoint;

  List<int> actionPoints = [
    0, //0-Available Action Points
    0, //1-ATTACK
    0, //2-DEFENSE
    0, //3-PERCEIVE
    0, //4-TALK
    0, //5-MOVE
    0, //6-SKILL
  ];

  int currentHealth;
  int maxHealth;
  int currentWeight;
  int maxWeight;

  void chooseRace(int index) {
    this.race = this.availableRaces[index];

    this.maxHealth = 12;
    this.maxWeight = 12;

    for (int i = 0; i < actionPoints.length; i++) {
      actionPoints[i] = 0;
    }

    this.actionPoints[0] = 3;

    for (PlayerAction playerAction in this.playerAction) {
      playerAction.value = 0;
    }

    switch (this.race.race) {
      case 'HUMAN':
        {
          this.actionPoints[0] = 4; //ACTION POINT
        }
        break;

      case 'ORC':
        {
          this.actionPoints[1] = 1; //ATTACK
          this.actionPoints[5] = -1; //MOVE
          this.maxWeight = 16; //WEIGHT
        }
        break;

      case 'GOBLIN':
        {
          this.actionPoints[1] = 1; //ATTACK
          this.actionPoints[5] = 1; //MOVE
          this.maxWeight = 8; //WEIGHT
        }
        break;

      case 'DWARF':
        {
          this.actionPoints[2] = 1; //DEFENSE
          this.actionPoints[3] = -1; //PERCEIVE
          this.maxHealth = 16; //HEALTH
        }
        break;

      case 'HALFLING':
        {
          this.actionPoints[1] = -1; //ATTACK
          this.actionPoints[3] = 1; //PERCEIVE
          this.actionPoints[4] = 1; //TALK
        }
        break;

      case 'ELF':
        {
          this.actionPoints[2] = -1; //DEFENCE
          this.actionPoints[3] = 1; //PERCEIVE
          this.actionPoints[5] = 1; //MOVE
        }
        break;
    }

    this.currentHealth = this.maxHealth;
    this.currentWeight = 0;
  }

  void chooseSex() {
    if (this.playerSex == 'female') {
      this.playerSex = 'male';
    } else {
      this.playerSex = 'female';
    }
  }

//CHOOSE BACKGROUND // DEFINE MONEY, INVENTORY, PASSIVE ATTRIBUTES

  List<Item> inventory = [];

  List<PlayerBackground> availableBackgrounds =
      PlayerBackgroundList().backgrounds;

  PlayerBackground playerBackground = PlayerBackground(
      'null',
      'BACKGROUND',
      'This represents your story. How you where raised and how people see you. Click on the icons above to choose your background.',
      [
        Bonus(
            'BONUS',
            'bonus',
            'All backgrounds are unique and have different bonuses. They can be items, gold, and passive attributes, like armor and damage.',
            0)
      ],
      []);

  int pDamage;
  int mDamage;
  int pArmor;
  int mArmor;

  int gold;

  void chooseBackground(int index) {
    this.pDamage = 0;
    this.mDamage = 0;
    this.pArmor = 0;
    this.mArmor = 0;

    this.gold = 1000;

    this.inventory.clear();

    this.currentWeight = 0;

    // ASSIGN BONUSES

    this.playerBackground = availableBackgrounds[index];

    switch (this.playerBackground.background) {
      case 'NOBLE':
        {
          this.gold = 1500; //GOLD
        }
        break;

      case 'FIGHTER':
        {
          this.pArmor = 2;
          for (Item item in this.playerBackground.bonusItem) {
            this.inventory.add(item.copyItem());
          }
        }
        break;

      case 'THIEF':
        {
          this.pDamage = 1;
          this.pArmor = 1;
          for (Item item in this.playerBackground.bonusItem) {
            this.inventory.add(item.copyItem());
          }
        }
        break;

      case 'MAGE':
        {
          this.mDamage = 1;
          for (Item item in this.playerBackground.bonusItem) {
            this.inventory.add(item.copyItem());
          }
        }
        break;

      case 'HUNTER':
        {
          this.pDamage = 2;
          for (Item item in this.playerBackground.bonusItem) {
            this.inventory.add(item.copyItem());
          }
        }
        break;

      case 'MEDIC':
        {
          this.mArmor = 1;
          for (Item item in this.playerBackground.bonusItem) {
            this.inventory.add(item.copyItem());
          }
        }
        break;
    }

    //ASSIGN CURRENT WEIGHT

    for (Item item in this.inventory) {
      this.currentWeight += item.weight;
    }
  }

  //PLAYER ACTIONS AND SKILLS

  List<PlayerAction> availableSkills = PlayerSkillList().skills;

  List<PlayerAction> playerAction = [
    PlayerAction(
        'action',
        'ACTION',
        'These are the actions your character can make throughout the game. Use the arrows on the left to add or remove points from a specific action. The more points you have, the easier it will be to get a good result on that action.',
        [
          Option(
              'OPTIONS',
              'Some actions have more than one option or effect to choose from.',
              '',
              '',
              '',
              '',
              0)
        ],
        0,
        false),
    PlayerAction(
        'attack',
        'ATTACK',
        'You attack the target with your fists or weapon.',
        [
          Option(
              'PUNCH',
              'You punch the target with your bare fists, trying to knock them out.',
              'You deal',
              '',
              'You miss the target and open your guard.',
              'DAMAGE',
              0),
          Option(
              'WEAPON',
              'You attack the target with your weapon, trying to bring them down.',
              'You deal',
              '',
              'You miss the target.',
              'DAMAGE',
              0),
          Option(
              'GRAPPLE',
              'You try to grapple the target, holding them down.',
              'You hold them in place and they are unable to move.',
              'You hold them, but they can still move a little.',
              'They escape your grasp.',
              '',
              0),
        ],
        0,
        false),
    PlayerAction(
        'defend',
        'DEFEND',
        'You defend yourself and others around you.',
        [
          Option(
              'PHYSICAL DEFENSE',
              'You face the danger, raise your shield and brace for impact. ',
              'You protect',
              '',
              'You can\'t raise your guard in time and take full damage.',
              'PROTECT',
              0),
          Option(
              'MAGIC DEFENSE',
              'You cast an enchantment that defends yourself and others around you.',
              'You protect',
              '',
              'You can\'t defend in time and take full damage.',
              'PROTECT',
              0)
        ],
        0,
        false),
    PlayerAction(
        'perceive',
        'PERCEIVE',
        'You look around and search of something.',
        [
          Option(
              'RESOURCES',
              'You search for something useful, like potions, items, and resources.',
              'You find something useful.',
              '',
              'You find something bad',
              'LOOT',
              0),
          Option(
              'INFORMATION',
              'You look around and try to gather information for this questions: \n\n - What happened here? \n - What\'s about to happen? \n - Who is in control?',
              'You gather meaningful information.',
              'You gather information, but it costs you.',
              'You find something bad.',
              '',
              0),
          Option(
              'DANGER',
              'You search for signs of danger, trying to prevent an encounter.',
              'You spot danger before it becomes a problem.',
              'You spot danger coming your way.',
              'You are exposed to a hidden danger.',
              '',
              0),
          Option(
              'PLACE',
              'You look for secrete doors, passages or rooms.',
              'You find a secrete.',
              'You find a secrete, but it\'s blocked.',
              'You find something bad',
              '',
              0)
        ],
        0,
        false),
    PlayerAction(
        'talk',
        'TALK',
        'You talk to someone that can understand you.',
        [
          Option(
              'BARGAIN',
              'You bargain with them, trying to strike a deal on your favor.',
              'They accept your offer.',
              'They accept, but ask for something in return.',
              'The deal is off and they dislike you.',
              '',
              0),
          Option(
              'INFORMATION',
              'You talk to someone and try to gather information on a specific subject.',
              'You receive valuable information.',
              'They will share what they know, but ask for something in return.',
              'You receive bad news.',
              '',
              0),
          Option(
              'PERSUADE',
              'You persuade people to follow your lead or see things your way.',
              'You change their minds.',
              'They see your point, but ask for something in return.',
              'They are offended and dislike you.',
              '',
              0),
        ],
        0,
        false),
    PlayerAction(
        'move',
        'MOVE',
        'You jump, climb, swim, dodge, hide, or escape.',
        [
          Option(
              'DODGE',
              'You dodge and take no damage.',
              'You dodge and take no damage.',
              'You dodge partially and take half damage.',
              'You can\'t dodge in time and take damage.',
              '',
              0),
          Option(
              'ESCAPE',
              'You release your shackles, run away from danger or free yourself from a tough situation.',
              'You escape without trouble.',
              'You escape, but call unwanted attention.',
              'You can\'t escape.',
              '',
              0),
          Option(
              'HIDE',
              'You avoid being seen by someone or sneak pass some guards.',
              'You are hidden.',
              'You are noticed.',
              'You are exposed.',
              '',
              0),
          Option(
              'JUMP',
              'You jump over a gap, try to reach for something or pass over an obstacle.',
              'You land where you wanted.',
              'You land somewhere close.',
              'You stumble and fail.',
              '',
              0),
          Option(
              'CLIMB',
              'You climb a wall, a rope or the back of a giant.',
              'You have no trouble.',
              'You face some difficulty.',
              'You slide and fall.',
              '',
              0),
          Option(
              'SWIM',
              'You swim, dive or hold your breath under water.',
              'You have no trouble.',
              'You face some difficulty.',
              'You can\'t stay afloat.',
              '',
              0)
        ],
        0,
        false),
    PlayerAction(
        'skill',
        'SKILL',
        'This is your signature move and what you are known for. Choose your skill by clicking on the icons above.',
        [
          Option(
              'OPTIONS',
              'Some skills have more than one option or effect to choose from.',
              'Success.',
              'Half Success.',
              'Fail.',
              '',
              0)
        ],
        0,
        false),
  ];

  void chooseSkill(int index) {
    this.playerAction[6] = availableSkills[index];

    for (int i = 0; i < playerAction.length; i++) {
      playerAction[i].value = actionPoints[i];
    }
  }

//INCREASE OR DECREASE ACTION POINTS

  void increaseActionPoint(int index) {
    if (this.playerAction[0].value == 0) {
      return;
    }

    if (this.playerAction[index].value < 3) {
      this.playerAction[index].value++;
      this.playerAction[0].value--;
    }
  }

  void decreaseActionPoint(int index) {
    if (this.playerAction[index].value != this.actionPoints[index]) {
      this.playerAction[index].value--;
      this.playerAction[0].value++;
    }
  }

//MANAGE ITEMS AND INVENTORY

  void buyItem(Item item) {
    if (this.gold < item.value) {
      throw new NoGoldException(
          'You don\'t have enough gold to buy this item.');
    }

    if (this.maxWeight - this.currentWeight < item.weight) {
      throw new TooHeavyException(
          'You are carrying too much weight and can\'t carry this item.');
    }

    this.gold -= item.value;
    this.currentWeight += item.weight;

    this.inventory.add(item.copyItem());
  }

  void use(Item item) {
    switch (item.name) {
      case 'BANDAGES':
        if (this.currentHealth == this.maxHealth) {
          throw new MaxHpException();
        }
        this.currentHealth += Random().nextInt(2) + 1;
        if (this.currentHealth > this.maxHealth) {
          this.currentHealth = this.maxHealth;
        }
        this.inventory.remove(item);

        break;

      case 'FOOD':
        if (this.currentHealth == this.maxHealth) {
          throw new MaxHpException();
        }
        this.currentHealth += Random().nextInt(5) + 1;
        if (this.currentHealth > this.maxHealth) {
          this.currentHealth = this.maxHealth;
        }
        this.inventory.remove(item);

        break;

      case 'MAGIC RUNE':
        this.inventory.remove(item);

        break;

      case 'HEALING POTION':
        if (this.currentHealth == this.maxHealth) {
          throw new MaxHpException();
        }
        this.currentHealth += Random().nextInt(10) + 2;
        if (this.currentHealth > this.maxHealth) {
          this.currentHealth = this.maxHealth;
        }
        this.inventory.remove(item);

        break;
      case 'RESISTANCE POTION':
        print('here');
        this.effectList.add(Effect('mArmor', 'MAGIC ARMOR',
            'Increase your magic armor by tree.', 3, 3));
        this.mArmor += 3;

        this.inventory.remove(item);

        break;
      case 'KEY':
        this.inventory.remove(item);

        break;
      case 'BOOK':
        this.inventory.remove(item);

        break;
      case 'HERBS':
        this.inventory.remove(item);

        break;
      case 'TOOL':
        this.inventory.remove(item);

        break;
      case 'WARD':
        this.inventory.remove(item);

        break;
      case 'ANTIDOTE':
        this.effectList.forEach((element) {
          element.duration = 0;
        });
        this.effects();

        this.inventory.remove(item);

        break;
      case 'AMMO':
        if (item.uses > 4) {
          throw new MaxAmmoException();
        }
        if (this.gold < 50) {
          throw new NoGoldException('You don\'t have enough gold for a refil.');
        } else {
          item.uses = 5;
          this.gold -= 50;
        }

        break;
    }
  }

  Item headEquip = Item(
    icon: 'head',
    name: '',
    itemClass: '',
    inventorySpace: '',
    description: '',
    pDamage: 0,
    pArmor: 0,
    mDamage: 0,
    mArmor: 0,
    weight: 0,
    uses: 0,
    value: 0,
  );
  Item bodyEquip = Item(
    icon: 'body',
    name: '',
    itemClass: '',
    inventorySpace: '',
    description: '',
    pDamage: 0,
    pArmor: 0,
    mDamage: 0,
    mArmor: 0,
    weight: 0,
    uses: 0,
    value: 0,
  );
  Item mainHandEquip = Item(
    icon: 'mainHand',
    name: '',
    itemClass: '',
    inventorySpace: '',
    description: '',
    pDamage: 0,
    pArmor: 0,
    mDamage: 0,
    mArmor: 0,
    weight: 0,
    uses: 0,
    value: 0,
  );
  Item offHandEquip = Item(
    icon: 'offHand',
    name: '',
    itemClass: '',
    inventorySpace: '',
    description: '',
    pDamage: 0,
    pArmor: 0,
    mDamage: 0,
    mArmor: 0,
    weight: 0,
    uses: 0,
    value: 0,
  );
  Item handsEquip = Item(
    icon: 'hands',
    name: '',
    itemClass: '',
    inventorySpace: '',
    description: '',
    pDamage: 0,
    pArmor: 0,
    mDamage: 0,
    mArmor: 0,
    weight: 0,
    uses: 0,
    value: 0,
  );
  Item feetEquip = Item(
    icon: 'feet',
    name: '',
    itemClass: '',
    inventorySpace: '',
    description: '',
    pDamage: 0,
    pArmor: 0,
    mDamage: 0,
    mArmor: 0,
    weight: 0,
    uses: 0,
    value: 0,
  );

  void useOrEquip(Item item, String buttonText) {
    if (item.inventorySpace == 'consumable') {
      use(item);
    } else if (buttonText == 'EQUIP') {
      equip(item, buttonText);
    } else {
      unequip(item);
    }
  }

  void equip(Item item, String check) {
    this.mArmor += item.mArmor;
    this.pArmor += item.pArmor;
    this.mDamage += item.mDamage;
    this.pDamage += item.pDamage;

    this.playerAction[1].option[1].value = this.pDamage + this.mDamage;
    this.playerAction[2].option[0].value = this.pArmor;
    this.playerAction[2].option[1].value = this.mArmor;
    this.playerAction[6].option.forEach((element) {
      if (element.result == 'PROTECT') {
        element.value = this.mArmor;
      } else {
        element.value = this.mDamage;
      }
    });

    switch (item.inventorySpace) {
      case 'head':
        {
          this.unequip(headEquip);
          this.headEquip = item;
          this.inventory.remove(item);
        }
        break;
      case 'body':
        {
          this.unequip(bodyEquip);
          this.bodyEquip = item;
          this.inventory.remove(item);
        }
        break;
      case 'hands':
        {
          this.unequip(handsEquip);
          this.handsEquip = item;
          this.inventory.remove(item);
        }
        break;
      case 'feet':
        {
          this.unequip(feetEquip);
          this.feetEquip = item;
          this.inventory.remove(item);
        }
        break;

      case '1hand':
        {
          if (this.mainHandEquip.name == '') {
            this.mainHandEquip = item;
            this.inventory.remove(item);
          } else if (this.offHandEquip.name == '') {
            this.offHandEquip = item;
            this.inventory.remove(item);
          } else if (this.mainHandEquip.name != '') {
            unequip(this.mainHandEquip);
            this.mainHandEquip = item;
            this.inventory.remove(item);
          }
        }
        break;

      case '2hand':
        {
          this.unequip(mainHandEquip);
          this.unequip(offHandEquip);
          this.mainHandEquip = item;
          this.offHandEquip = item;
          this.inventory.remove(item);
        }
        break;
    }
  }

  void unequip(Item item) {
    if (item.name == '') {
      return;
    }

    if (item.itemClass == 'resource') {
      return;
    }

    if (item.inventorySpace == '2hand') {
      this.mArmor -= item.mArmor;
      this.pArmor -= item.pArmor;
      this.mDamage -= item.mDamage;
      this.pDamage -= item.pDamage;

      this.playerAction[1].option[1].value = this.pDamage + this.mDamage;
      this.playerAction[2].option[0].value = this.pArmor;
      this.playerAction[2].option[1].value = this.mArmor;
      this.playerAction[6].option.forEach((element) {
        if (element.result == 'PROTECT') {
          element.value = this.mArmor;
        } else {
          element.value = this.mDamage;
        }
      });

      this.inventory.add(item);
      this.mainHandEquip = Item(
        icon: 'mainHand',
        name: '',
        itemClass: '',
        inventorySpace: '',
        description: '',
        pDamage: 0,
        pArmor: 0,
        mDamage: 0,
        mArmor: 0,
        weight: 0,
        uses: 0,
        value: 0,
      );

      this.offHandEquip = Item(
        icon: 'offHand',
        name: '',
        itemClass: '',
        inventorySpace: '',
        description: '',
        pDamage: 0,
        pArmor: 0,
        mDamage: 0,
        mArmor: 0,
        weight: 0,
        uses: 0,
        value: 0,
      );

      return;
    }

    this.mArmor -= item.mArmor;
    this.pArmor -= item.pArmor;
    this.mDamage -= item.mDamage;
    this.pDamage -= item.pDamage;

    this.playerAction[1].option[1].value = this.pDamage + this.mDamage;
    this.playerAction[2].option[0].value = this.pArmor;
    this.playerAction[2].option[1].value = this.mArmor;
    this.playerAction[6].option.forEach((element) {
      if (element.result == 'PROTECT') {
        element.value = this.mArmor;
      } else {
        element.value = this.mDamage;
      }
    });

    this.inventory.add(item);

    switch (item.inventorySpace) {
      case 'head':
        {
          this.headEquip = Item(
            icon: 'head',
            name: '',
            itemClass: '',
            inventorySpace: '',
            description: '',
            pDamage: 0,
            pArmor: 0,
            mDamage: 0,
            mArmor: 0,
            weight: 0,
            uses: 0,
            value: 0,
          );
        }
        break;
      case 'hands':
        {
          this.handsEquip = Item(
            icon: 'hands',
            name: '',
            itemClass: '',
            inventorySpace: '',
            description: '',
            pDamage: 0,
            pArmor: 0,
            mDamage: 0,
            mArmor: 0,
            weight: 0,
            uses: 0,
            value: 0,
          );
        }
        break;
      case 'body':
        {
          this.bodyEquip = Item(
            icon: 'body',
            name: '',
            itemClass: '',
            inventorySpace: '',
            description: '',
            pDamage: 0,
            pArmor: 0,
            mDamage: 0,
            mArmor: 0,
            weight: 0,
            uses: 0,
            value: 0,
          );
        }
        break;
      case 'feet':
        {
          this.feetEquip = Item(
            icon: 'feet',
            name: '',
            itemClass: '',
            inventorySpace: '',
            description: '',
            pDamage: 0,
            pArmor: 0,
            mDamage: 0,
            mArmor: 0,
            weight: 0,
            uses: 0,
            value: 0,
          );
        }
        break;

      case '1hand':
        {
          if (item == this.mainHandEquip) {
            this.mainHandEquip = Item(
              icon: 'mainHand',
              name: '',
              itemClass: '',
              inventorySpace: '',
              description: '',
              pDamage: 0,
              pArmor: 0,
              mDamage: 0,
              mArmor: 0,
              weight: 0,
              uses: 0,
              value: 0,
            );
          } else {
            this.offHandEquip = Item(
              icon: 'offHand',
              name: '',
              itemClass: '',
              inventorySpace: '',
              description: '',
              pDamage: 0,
              pArmor: 0,
              mDamage: 0,
              mArmor: 0,
              weight: 0,
              uses: 0,
              value: 0,
            );
          }
        }
        break;
    }
  }

  void sellItem(Item item, String equipOrUnequip) {
    if (equipOrUnequip == 'UNEQUIP') {
      unequip(item);
    }

    this.gold += item.value ~/ 2;
    this.currentWeight -= item.weight;
    this.inventory.remove(item);
  }

  void destroyItem(Item item, String equipOrUnequip) {
    if (equipOrUnequip == 'UNEQUIP') {
      unequip(item);
    }

    this.currentWeight -= item.weight;
    this.inventory.remove(item);
  }

//ACTION

  void action(bool focus, Option option) {
    this.effects();
    this.actionsTaken++;
    this.focus(focus);
    if (option.name == 'WEAPON') {
      this.reduceAmmo();
    }
  }

  void reduceAmmo() {
    if (this.mainHandEquip.itemClass == 'thrownWeapon') {
      this.mainHandEquip.uses--;
      if (this.mainHandEquip.uses < 1) {
        destroyItem(this.mainHandEquip, 'UNEQUIP');
      }
    }

    if (this.offHandEquip.itemClass == 'thrownWeapon') {
      this.offHandEquip.uses--;
      if (this.offHandEquip.uses < 1) {
        destroyItem(this.mainHandEquip, 'UNEQUIP');
      }
    }

    if (this.mainHandEquip.itemClass != 'rangedWeapon' &&
        this.offHandEquip.itemClass != 'rangedWeapon') {
      return;
    }

    for (int check = 0; check < this.inventory.length; check++) {
      if (this.inventory[check].icon == 'ammo') {
        this.inventory[check].uses--;

        if (this.inventory[check].uses < 1) {
          this.inventory.removeAt(check);
        }
        return;
      }
    }
  }

  void checkWeapon() {
    if (this.mainHandEquip.name == '' && this.offHandEquip.name == '') {
      throw new NoWeaponException();
    }

    if (this.mainHandEquip.itemClass == 'rangedWeapon' ||
        this.offHandEquip.itemClass == 'rangedWeapon') {
      for (int check = 0; check < this.inventory.length; check++) {
        if (this.inventory[check].icon == 'ammo') {
          return;
        }
      }
      throw new NoAmmoException('Not enough ammo.');
    }
  }

//EFFECTS

  void effects() {
    if (this.effectList.isEmpty == true) {
      return;
    }

    this.effectList.forEach((element) {
      element.duration--;
    });

    this.effectList.forEach((element) {
      if (element.duration > 0) {
        return;
      }
      switch (element.name) {
        case 'focus':
          {
            this.playerAction[6].value++;
          }
          break;

        case 'RESISTANCE POTION':
          {
            this.mArmor -= 3;
          }
          break;
      }
    });

    this.effectList.removeWhere((element) => element.duration < 1);
  }

  void focus(bool focus) {
    if (focus == true) {
      this.effectList.add(Effect(
          playerAction[6].icon,
          'focus',
          'This action requires you to focus and it will have a lower chance of success if taken consecutively.',
          -1,
          1));
      this.playerAction[6].value--;
    }
  }

  List<String> lootResources(int value) {
    List<String> itemList = [];

    while (value > 0) {
      Random randomDrop = new Random();
      int randomLoot = randomDrop.nextInt(shop.resources.length);

      if (shop.resources[randomLoot].value <= value &&
          shop.resources[randomLoot].weight <=
              this.maxWeight - this.currentWeight) {
        this.inventory.add(shop.resources[randomLoot].copyItem());

        itemList.add(shop.resources[randomLoot].name);
        value -= shop.resources[randomLoot].value;
        this.currentWeight += shop.resources[randomLoot].weight;
      }
    }
    return itemList;
  }

  List<Effect> effectList = [];

  Player(this.playerColor);

  void setColor(PlayerColor playerColor) {
    this.playerColor = playerColor;
  }
}
