import 'dart:math';
import 'package:dsixv02app/models/player/playerRaceList.dart';
import 'package:dsixv02app/models/shared/item.dart';
import 'package:dsixv02app/models/player/playerBackground.dart';
import 'package:flutter/material.dart';
import 'package:dsixv02app/models/player/playerRace.dart';
import 'package:dsixv02app/models/player/option.dart';
import 'package:dsixv02app/models/player/playerAction.dart';
import 'package:dsixv02app/models/player/effect.dart';
import '../shared/exceptions.dart';
import 'package:dsixv02app/models/player/bonus.dart';
import 'package:dsixv02app/models/shared/shop.dart';
import 'package:dsixv02app/models/player/playerBackgroundList.dart';
import 'package:dsixv02app/models/player/playerSkillList.dart';
import 'package:dsixv02app/models/player/effectList.dart';

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
  Effect effect = Effect();
  List<Effect> effects = [];

  void chooseBackground(int index) {
    this.gold = 300;
    this.fame = 0;
    this.inventory.clear();
    this.currentWeight = 0;
    this.effects = [];

    // ASSIGN BONUSES

    this.playerBackground = availableBackgrounds[index];

    if (this.playerBackground.background == 'NOBLE') {
      this.gold += 300; //GOLD
      this.fame = 1;
      this.effects.add(effectList.permanent[0].copyEffect());
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
      'You try to attack or grapple a target.',
      [
        Option(
            'PUNCH',
            'You punch the target with your fists.',
            'You hit in a weak spot.',
            'You hit the target.',
            'You miss and open your guard.',
            'DAMAGE',
            true),
        Option(
            'WEAPON',
            'You attack the target with your weapon, trying to bring them down.',
            'You hit in a weak spot.',
            'You hit the target.',
            'You miss and open your guard.',
            'DAMAGE',
            true),
        Option(
            'GRAPPLE',
            'You try to grapple the target, holding them down.',
            'You hold them in place and they are unable to move.',
            'You hold one of their arms or legs.',
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
            'You try to protect.',
            'You protect a lot of damage.',
            'You protect some damage.',
            'You can\'t raise your guard in time and take full damage.',
            'PROTECT',
            true),
        Option(
            'RESIST',
            'You try to resist.',
            'You resist a lot of damage.',
            'You resist some damage.',
            'You can\'t defend in time and take full damage.',
            'RESIST',
            true),
        Option(
            'HELP',
            'You try to help.',
            'You give them a real advantage.',
            'You make things easier for them.',
            'You make things harder for them.',
            'HELP',
            false),
      ],
      0,
    ),
    PlayerAction(
      'look',
      'LOOK',
      'You look around and notice things.',
      [
        Option(
            'RESOURCES',
            'You search for something useful.',
            'You find resources and gold.',
            'You find resources.',
            'You find something bad',
            'RESOURCES',
            true),
        Option(
            'INFORMATION',
            'You try to gather information.',
            'You gather meaningful information.',
            'You gather information, but it costs you.',
            'You find something bad.',
            'INFORMATION',
            false),
        Option(
            'SECRETE',
            'You try to find a hidden door or chest.',
            'You find a secrete.',
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
            'You try to strike a deal.',
            'They accept your offer.',
            'They ask for more.',
            'The deal is off and they dislike you.',
            'DEAL',
            false),
        Option(
            'INFORMATION',
            'You try to gather information.',
            'You gather information.',
            'You gather information, but at a cost.',
            'You receive bad news.',
            'INFORMATION',
            false),
        Option(
            'CONVINCE',
            'You try to change people\'s minds.',
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
      'You climb, swim, hide or try to escape.',
      [
        Option(
            'DODGE',
            'You try to get out of the way.',
            'You dodge and take no damage.',
            'You take half damage.',
            'You take full damage.',
            'AVOID',
            false),
        Option(
            'ESCAPE',
            'You try to escape from a tough situation.',
            'You escape.',
            'You escape, but call unwanted attention.',
            'You can\'t escape.',
            'ESCAPE',
            false),
        Option('HIDE', 'You try to hide.', 'You are hidden.',
            'You are noticed.', 'You are exposed.', 'HIDE', false),
        Option(
            'JUMP',
            'You try to jump over an obstacle.',
            'You land where you wanted.',
            'You land somewhere close.',
            'You stumble and fail.',
            'JUMP',
            false),
        Option('CLIMB', 'You try to climb.', 'You have no trouble.',
            'You face some difficulty.', 'You slide and fall.', 'CLIMB', false),
        Option(
            'SWIM',
            'You try to swim.',
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
      throw new NoGoldException();
    }

    if (this.race.maxWeight - this.currentWeight < item.weight) {
      throw new TooHeavyException();
    }

    this.gold -= item.value;
    this.currentWeight += item.weight;

    this.inventory.add(item.copyItem());
    throw new BuyException(message: '- \$${item.value}');
  }

  void sellItem(Item item) {
    if (item.action == 'UNEQUIP') {
      unequip(item);
    }

    this.gold += item.value ~/ 2;
    this.currentWeight -= item.weight;
    this.inventory.remove(item);
    throw new SellException(message: '+ \$${item.value ~/ 2}');
  }

  void destroyItem(Item item) {
    if (item.action == 'UNEQUIP') {
      unequip(item);
    }

    this.currentWeight -= item.weight;
    this.inventory.remove(item);
  }

  void receiveItem(Item item) {
    if (item.weight + this.currentWeight > this.race.maxWeight) {
      throw new TooHeavyException();
    }
    this.currentWeight += item.weight;
    this.inventory.add(item);
  }

  void giveItem(Item item) {
    this.currentWeight -= item.weight;
    this.inventory.remove(item);
  }

  void healPlayer(int value) {
    if (this.currentHealth + value > this.race.maxHealth) {
      this.currentHealth = this.race.maxHealth;
      throw new MaxHpException();
    } else {
      this.currentHealth += value;
      throw new HealException(message: '$value');
    }
  }

  void use(Item item) {
    switch (item.name) {
      case 'BANDAGES':
        if (this.currentHealth == this.race.maxHealth) {
          throw new MaxHpException();
        }
        this.inventory.remove(item);
        playerTurn();
        int randomNumber = Random().nextInt(2) + 1;

        healPlayer(randomNumber);

        break;

      case 'FOOD':
        if (this.currentHealth == this.race.maxHealth) {
          throw new MaxHpException();
        }
        this.inventory.remove(item);
        playerTurn();
        int randomNumber = Random().nextInt(5) + 1;

        healPlayer(randomNumber);

        break;

      case 'HEALING POTION':
        if (this.currentHealth == this.race.maxHealth) {
          throw new MaxHpException();
        }
        this.inventory.remove(item);
        playerTurn();
        int randomNumber = Random().nextInt(7) + 3;

        healPlayer(randomNumber);

        break;

      case 'RESISTANCE POTION':
        playerTurn();
        this.effects.add(effectList.temporary[1].copyEffect());
        this.mArmor += 3;
        this.inventory.remove(item);

        throw new UseItemException(message: '${item.name}');
        break;
      case 'KEY':
        this.inventory.remove(item);
        playerTurn();
        throw new UseItemException(message: '${item.name}');
        break;
      case 'BOOK':
        this.inventory.remove(item);
        playerTurn();
        throw new UseItemException(message: '${item.name}');
        break;
      case 'HERBS':
        this.inventory.remove(item);
        playerTurn();
        throw new UseItemException(message: '${item.name}');
        break;
      case 'TOOL':
        this.inventory.remove(item);
        playerTurn();
        throw new UseItemException(message: '${item.name}');
        break;
      case 'WARD':
        this.inventory.remove(item);
        playerTurn();
        throw new UseItemException(message: '${item.name}');
        break;
      case 'ANTIDOTE':
        this.effects.forEach((element) {
          if (element.typeOfEffect == 'TEMPORARY') {
            element.duration = 0;
          }
        });
        this.inventory.remove(item);
        playerTurn();
        throw new UseItemException(message: '${item.name}');
        break;
    }
  }

  List<Item> availableItemsForEnchant() {
    List<Item> availableItems = [];
    this.inventory.forEach((item) {
      if (item.inventorySpace != 'consumable' &&
          item.itemClass != 'thrownWeapon' &&
          item.enchant < 3) {
        availableItems.add(item);
      }
    });

    if (availableItems.isEmpty) {
      throw new NoAvailableItemsException();
    }
    return availableItems;
  }

  void restock(Item item) {
    if (item.uses > 4) {
      throw new MaxAmmoException();
    }
    if (this.gold < 50) {
      throw new NoGoldException();
    } else {
      item.uses = 5;
      this.gold -= 50;
      throw new RestockException();
    }
  }

  void enchant(Item item) {
    item.enchant++;
    item.value += 600;

    if (item.itemClass == 'armor') {
      item.mArmor++;
    } else {
      item.mDamage++;
    }
  }

  void useOrEquip(Item item) {
    switch (item.action) {
      case 'ENCHANT':
        {
          throw new EnchantException();
        }
        break;

      case 'USE':
        {
          use(item);
        }
        break;
      case 'EAT':
        {
          use(item);
        }
        break;
      case 'DRINK':
        {
          use(item);
        }
        break;
      case 'RESTOCK':
        {
          restock(item);
        }
        break;

      case 'EQUIP':
        {
          equip(item);
        }
        break;

      case 'UNEQUIP':
        {
          unequip(item);
        }
        break;
    }
  }

  void equip(Item item) {
    item.action = 'UNEQUIP';
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

    item.action = 'EQUIP';

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
        destroyItem(this.mainHandEquip);
      }
    }

    if (this.offHandEquip.itemClass == 'thrownWeapon') {
      this.offHandEquip.uses--;
      if (this.offHandEquip.uses < 1) {
        destroyItem(this.mainHandEquip);
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
      throw new NoAmmoException();
    }
  }

// PLAYER TURN

  List<bool> turn = [false, false];

  void newTurn() {
    turn = [false, false];
  }

  bool checkTurn() {
    bool endTurn = false;
    if (turn.contains(false)) {
      endTurn = false;
    } else {
      endTurn = true;
    }
    return endTurn;
  }

  void changeTurn(int index) {
    if (this.turn[index]) {
      this.turn[index] = false;
    } else {
      this.turn[index] = true;
    }
  }

  void playerTurn() {
    if (this.turn.contains(false)) {
      this.actionsTaken++;
      this.checkEffects();

      if (turn[0]) {
        turn[1] = true;
      } else {
        turn[0] = true;
      }

      checkTurn();
    } else {
      return;
    }
  }

  void selectEffect(int index) {
    this.effect = this.effects[index].copyEffect();
  }

  void checkEffects() {
    if (this.effects.isEmpty == true) {
      return;
    }

    List<Effect> currentEffects = [];

    this.effects.forEach((element) {
      if (element.typeOfEffect == 'PERMANENT') {
        return;
      }

      element.duration--;

      if (element.duration < 1) {
        switch (element.name) {
          case 'MAGIC RESISTANCE':
            {
              this.mArmor -= 3;
              currentEffects.add(element);
            }
            break;
        }
      }
    });

    if (currentEffects.isNotEmpty) {
      currentEffects.forEach((element) {
        this.effects.remove(element);
      });
    }
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
        '${this.race.race} ${this.playerBackground.background}';
    this.characterFinished = true;
  }

  Player(this.playerColor);

  void setColor(PlayerColor playerColor) {
    this.playerColor = playerColor;
  }
}
