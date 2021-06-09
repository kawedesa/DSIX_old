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
import 'package:dsixv02app/models/game/effectList.dart';

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
    race: 'RACES',
    description:
        'There are many races in this world. They vary in size, culture and color. Click on the icons above to choose a race.',
    bonus: [
      Bonus(
        'BONUS',
        'bonus',
        'Each race has different strenghs and weaknesses that make them unique.',
      )
    ],
  );

  String playerSex = 'female';

  int currentHealth;

  int currentWeight;

  void chooseRace(int index) {
    this.race = this.availableRaces[index];
    this.currentHealth = this.race.maxHealth;
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
      'This is your story. Where you were born, how you where raised and if people like you or not. Click on the icons above to choose a background.',
      [
        Bonus(
          'THINGS',
          'bonus',
          'Every background starts with different things.',
        )
      ],
      []);

  int pDamage = 0;
  int mDamage = 0;
  int pArmor = 0;
  int mArmor = 0;

  int fame;
  int gold;
  EffectList effectList = EffectList();

  List<Effect> effects = [];

  void chooseBackground(int index) {
    this.gold = 500;
    this.fame = 0;
    this.inventory.clear();
    this.currentWeight = 0;

    // ASSIGN BONUSES

    this.playerBackground = availableBackgrounds[index];

    if (this.playerBackground.background == 'NOBLE') {
      this.gold += 400; //GOLD
      this.fame = 1;
      this.effects.add(effectList.effectList[0]);
    }

    for (Item item in this.playerBackground.bonusItem) {
      this.inventory.add(item.copyItem());
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
      'These represents the strenghts and weaknesses of your character. Use the arrows on the left to make your character better. The more points you have, the better you are in that action.',
      [
        Option('OPTIONS', 'Each action has different options to choose from.',
            '', '', '', '', false)
      ],
      0,
    ),
    PlayerAction(
      'attack',
      'ATTACK',
      'You attack a target or try to hold it down.',
      [
        Option(
            'PUNCH',
            'You punch the target with your bare fists, trying to knock them out.',
            'You deal a lot of damage.',
            'You hit the target.',
            'You miss the target and open your guard.',
            'DAMAGE',
            true),
        Option(
            'WEAPON',
            'You attack the target with your weapon, trying to bring them down.',
            'You deal a lot of damage.',
            'You hit the target.',
            'You miss the target.',
            'DAMAGE',
            true),
        Option(
            'GRAPPLE',
            'You try to grapple the target, holding them down.',
            'You hold them in place and they are unable to move.',
            'You hold them, but they can still move a little.',
            'They escape your grasp.',
            'HOLD',
            false),
      ],
      0,
    ),
    PlayerAction(
      'defend',
      'DEFEND',
      'You protect yourself or others around you.',
      [
        Option(
            'DEFEND',
            'You face the danger, raise your shield and brace for impact. ',
            'You protect a lot of damage.',
            'You protect some damage.',
            'You can\'t raise your guard in time and take full damage.',
            'PROTECT',
            true),
        Option(
            'RESIST',
            'You cast an enchantment that defends yourself and others around you.',
            'You resist a lot of damage.',
            'You resist some damage.',
            'You can\'t defend in time and take full damage.',
            'PROTECT',
            true),
        Option(
            'HELP',
            'You help someone, making it easier for them to succeed.',
            'You give them a real advantage.',
            'You make things easier for them.',
            'You get in the way and make things harder for them.',
            'HELP',
            false),
      ],
      0,
    ),
    PlayerAction(
      'look',
      'LOOK',
      'You look around and search for things.',
      [
        Option(
            'RESOURCES',
            'You search for something useful, like potions, food, and resources.',
            'You find loot and gold.',
            'You find loot.',
            'You find something bad',
            'RESOURCES',
            true),
        Option(
            'INFORMATION',
            'You look around and try to gather more information.',
            'You gather meaningful information.',
            'You gather information, but it costs you.',
            'You find something bad.',
            'INFORMATION',
            false),
        // Option(
        //     'DANGER',
        //     'You search for signs of danger, trying to prevent an encounter.',
        //     'You spot danger before it becomes a problem.',
        //     'You spot danger coming your way.',
        //     'You are exposed to a hidden danger.',
        //     '',
        //     0),
        Option(
            'PLACE',
            'You try to gather more information about your surroundings.',
            'You find a hidden passage, door or secrete.',
            'You find a secrete, but it\'s blocked.',
            'You find something bad',
            'SECRETE',
            false)
      ],
      0,
    ),
    PlayerAction(
      'talk',
      'TALK',
      'You talk to someone that can understand you.',
      [
        Option(
            'TRADE',
            'You try to strike a deal on your favor.',
            'They accept your offer.',
            'They accept, but ask for more in return.',
            'The deal is off and they dislike you.',
            'DEAL',
            false),
        Option(
            'INFORMATION',
            'You talk to someone and try to gather meaningful information.',
            'You receive valuable information.',
            'They will share what they know, but ask for something in return.',
            'You receive bad news.',
            'INFORMATION',
            false),
        Option(
            'CONVINCE',
            'You convince people to follow your lead or see things your way.',
            'You change their minds.',
            'They see your point, but ask for something in return.',
            'They are offended and dislike you.',
            '',
            false),
        Option(
            'ENTERTAIN',
            'You entertain people around you.',
            'Everyone loves your performance and becomes friendly.',
            'Some people enjoy your performance and become friendly.',
            'They think you suck and are mean to you.',
            'PERFORM',
            false),
      ],
      0,
    ),
    PlayerAction(
      'move',
      'MOVE',
      'You move around, hide or try to escape.',
      [
        Option(
            'DODGE',
            'You dodge and take no damage.',
            'You dodge and take no damage.',
            'You take half damage.',
            'You can\'t dodge and take full damage.',
            'AVOID',
            false),
        Option(
            'ESCAPE',
            'You release your shackles, run away from danger or free yourself from a tough situation.',
            'You escape without trouble.',
            'You escape, but call unwanted attention.',
            'You can\'t escape.',
            'ESCAPE',
            false),
        Option(
            'HIDE',
            'You avoid being seen by someone or sneak pass some guards.',
            'You are hidden.',
            'You are noticed.',
            'You are exposed.',
            'HIDE',
            false),
        Option(
            'JUMP',
            'You jump over a gap, try to reach for something or pass over an obstacle.',
            'You land where you wanted.',
            'You land somewhere close.',
            'You stumble and fail.',
            'JUMP',
            false),
        Option(
            'CLIMB',
            'You climb a wall, a rope or the back of a giant.',
            'You have no trouble.',
            'You face some difficulty.',
            'You slide and fall.',
            'CLIMB',
            false),
        Option(
            'SWIM',
            'You swim, dive or hold your breath under water.',
            'You have no trouble.',
            'You face some difficulty.',
            'You can\'t stay afloat.',
            'SWIM',
            false)
      ],
      0,
    ),
    PlayerAction(
      'skill',
      'SKILL',
      'This is your special move and what you are known for. Choose your skill by clicking on the icons above.',
      [
        Option('OPTIONS', 'Each skill has different options to choose from.',
            'Success.', 'Half Success.', 'Fail.', 'OPTIONS', false)
      ],
      0,
    ),
  ];

  void chooseSkill(int index) {
    this.playerAction[6] = availableSkills[index];

    for (int i = 0; i < this.playerAction.length; i++) {
      this.playerAction[i].value = this.race.actionPoints[i];
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
    if (this.playerAction[index].value != this.race.actionPoints[index]) {
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

    if (this.race.maxWeight - this.currentWeight < item.weight) {
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
        if (this.currentHealth == this.race.maxHealth) {
          throw new MaxHpException();
        }
        this.currentHealth += Random().nextInt(2) + 1;
        if (this.currentHealth > this.race.maxHealth) {
          this.currentHealth = this.race.maxHealth;
        }
        this.inventory.remove(item);
        playerTurn();
        break;

      case 'FOOD':
        if (this.currentHealth == this.race.maxHealth) {
          throw new MaxHpException();
        }
        this.currentHealth += Random().nextInt(5) + 1;
        if (this.currentHealth > this.race.maxHealth) {
          this.currentHealth = this.race.maxHealth;
        }
        this.inventory.remove(item);
        playerTurn();
        break;

      case 'MAGIC RUNE':
        this.inventory.remove(item);

        break;

      case 'HEALING POTION':
        if (this.currentHealth == this.race.maxHealth) {
          throw new MaxHpException();
        }
        this.currentHealth += Random().nextInt(7) + 6;
        if (this.currentHealth > this.race.maxHealth) {
          this.currentHealth = this.race.maxHealth;
        }
        this.inventory.remove(item);
        playerTurn();
        break;
      case 'RESISTANCE POTION':
        this.effects.add(effectList.effectList[1]);
        this.mArmor += 3;
        this.inventory.remove(item);
        playerTurn();
        break;
      case 'KEY':
        this.inventory.remove(item);
        playerTurn();
        break;
      case 'BOOK':
        this.inventory.remove(item);
        playerTurn();
        break;
      case 'HERBS':
        this.inventory.remove(item);
        playerTurn();
        break;
      case 'TOOL':
        this.inventory.remove(item);
        playerTurn();
        break;
      case 'WARD':
        this.inventory.remove(item);
        playerTurn();
        break;
      case 'ANTIDOTE':
        this.effects.forEach((element) {
          element.duration = 0;
        });
        this.checkEffects();

        this.inventory.remove(item);
        playerTurn();
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

  void action(Option option) {
    //Count player turn
    playerTurn();

    //Reduce ammunition
    if (option.name == 'WEAPON') {
      this.reduceAmmo();
    }

    //Prepare for second roll
    option.firstRoll = false;
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

// PLAYER TURN

  bool endTurn = false;

  List<bool> turn = [false, false];

  void newTurn() {
    turn = [false, false];
    endTurn = false;
  }

  bool checkTurn() {
    if (turn.contains(false)) {
      endTurn = false;
    } else {
      endTurn = true;
    }
    return endTurn;
  }

  void playerTurn() {
    if (endTurn) {
      return;
    }
    this.actionsTaken++;
    this.checkEffects();

    if (turn[0]) {
      turn[1] = true;
    } else {
      turn[0] = true;
    }

    checkTurn();
  }

  void checkEffects() {
    if (this.effects.isEmpty == true) {
      return;
    }

    this.effects.forEach((element) {
      if (element.duration > 10) {
        return;
      }
      element.duration--;
    });

    this.effects.forEach((element) {
      if (element.duration > 0) {
        return;
      }
      switch (element.name) {
        case 'MAGIC RESISTANCE':
          {
            this.mArmor -= 3;
          }
          break;
      }
    });

    this.effects.removeWhere((element) => element.duration < 1);
  }

  List<String> resources(int numberDice) {
    List<String> lootList = [];

    if (numberDice > 1) {
      int randomGold = (Random().nextInt(4) + 1) * 25;
      this.gold += randomGold;
      lootList.add('\$ $randomGold');
    }

    int loot = Random().nextInt(shop.resources.length);
    inventory.add(shop.resources[loot]);

    lootList.add('${shop.resources[loot].name}');
    return lootList;
  }

  void createRandomPlayer() {
    chooseRace(Random().nextInt(this.availableRaces.length));
    chooseBackground(Random().nextInt(this.availableBackgrounds.length));
    chooseSkill(Random().nextInt(this.availableSkills.length));
    while (this.playerAction[0].value > 0) {
      int random = Random().nextInt(5) + 1;
      increaseActionPoint(random);
    }
    this.playerColor.name =
        '${Random().nextInt(10)}${Random().nextInt(10)}${Random().nextInt(10)}';
    this.characterFinished = true;
  }

  Player(this.playerColor);

  void setColor(PlayerColor playerColor) {
    this.playerColor = playerColor;
  }
}
