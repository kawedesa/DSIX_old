import 'dart:math';
import 'package:dsixv02app/models/player/playerRaceList.dart';
import 'package:dsixv02app/models/shared/item.dart';
import 'package:dsixv02app/models/player/playerBackground.dart';
import 'package:flutter/material.dart';
import 'package:dsixv02app/models/player/playerRace.dart';
import 'package:dsixv02app/models/player/newOption.dart';
import 'package:dsixv02app/models/player/playerAction.dart';
import 'package:dsixv02app/models/player/effect.dart';
import '../shared/exceptions.dart';
import 'package:dsixv02app/models/player/bonus.dart';
import 'package:dsixv02app/models/shared/shop.dart';
import 'package:dsixv02app/models/player/playerBackgroundList.dart';
import 'package:dsixv02app/models/player/playerSkillList.dart';
import 'package:dsixv02app/models/player/effectList.dart';
import 'result.dart';
import 'package:dsixv02app/models/player/outcome.dart';

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

  int fame = 0;
  int gold = 0;
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

      newPermanentEffect('FAME');
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
      icon: 'action',
      name: 'ACTION',
      description:
          'These represents the strenghts and weaknesses of your character. Use the arrows on the left to make your character better. The more points you have, the better you are in that action.',
      option: [
        Option(
            name: 'OPTIONS',
            description: 'Each action has different options to choose from.',
            value: 0)
      ],
      value: 0,
      bonus: 0,
    ),
    PlayerAction(
      icon: 'attack',
      name: 'ATTACK',
      description: 'You try to attack or grapple a target.',
      option: [
        Option(
            name: 'PUNCH',
            description: 'You punch the target with your fists.',
            value: 0),
        Option(
            name: 'WEAPON',
            description:
                'You attack the target with your weapon, trying to bring them down.',
            value: 0),
        Option(
            name: 'GRAPPLE',
            description: 'You try to grapple the target, holding them down.',
            value: 0),
      ],
      value: 0,
      bonus: 0,
    ),
    PlayerAction(
      icon: 'defend',
      name: 'DEFEND',
      description: 'You protect yourself and others.',
      option: [
        Option(name: 'DEFEND', description: 'You try to protect.', value: 0),
        Option(name: 'RESIST', description: 'You try to resist.', value: 0),
        Option(name: 'HELP', description: 'You try to help.', value: 0),
      ],
      value: 0,
      bonus: 0,
    ),
    PlayerAction(
      icon: 'look',
      name: 'LOOK',
      description: 'You look around and notice things.',
      option: [
        Option(
            name: 'RESOURCES',
            description: 'You search for something useful.',
            value: 0),
        Option(
            name: 'INFORMATION',
            description: 'You try to gather information.',
            value: 0),
        // Option(
        //     'SECRETE',
        //     'You try to find a hidden door or chest.',
        //     'You find a secrete.',
        //     'You find a secrete, but it\'s blocked.',
        //     'You find something bad',
        //     'SECRETE',
        //     false)
      ],
      value: 0,
      bonus: 0,
    ),
    PlayerAction(
      icon: 'talk',
      name: 'TALK',
      description: 'You talk to someone that can understand you.',
      option: [
        Option(
            name: 'TRADE', description: 'You try to strike a deal.', value: 0),
        Option(
            name: 'INFORMATION',
            description: 'You try to gather information.',
            value: 0),
        Option(
            name: 'CONVINCE',
            description: 'You try to change people\'s minds.',
            value: 0),
      ],
      value: 0,
      bonus: 0,
    ),
    PlayerAction(
      icon: 'move',
      name: 'MOVE',
      description: 'You climb, swim, hide or try to escape.',
      option: [
        Option(
            name: 'DODGE',
            description: 'You try to get out of the way.',
            value: 0),
        Option(
            name: 'ESCAPE',
            description: 'You try to escape from a tough situation.',
            value: 0),
        Option(name: 'HIDE', description: 'You try to hide.', value: 0),
        Option(
            name: 'JUMP',
            description: 'You try to jump over an obstacle.',
            value: 0),
        Option(name: 'CLIMB', description: 'You try to climb.', value: 0),
        Option(name: 'SWIM', description: 'You try to swim.', value: 0)
      ],
      value: 0,
      bonus: 0,
    ),
    PlayerAction(
      icon: 'skill',
      name: 'SKILL',
      description:
          'This is your special move and what you are known for. Choose your skill by clicking on the icons above.',
      option: [
        Option(
            name: 'OPTIONS',
            description: 'Each skill has different options to choose from.',
            value: 0)
      ],
      value: 0,
      bonus: 0,
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

//HEAL PLAYERS

  void changeHealth(int value) {
    if (this.currentHealth + value > this.race.maxHealth) {
      this.currentHealth = this.race.maxHealth;
      return;
    }
    if (this.currentHealth + value < 1) {
      this.currentHealth = 0;
      return;
    }

    this.currentHealth += value;
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

  void use(Item item) {
    switch (item.name) {
      case 'BANDAGES':
        this.inventory.remove(item);
        playerTurn();
        throw new UseItemException(message: '${item.name}');
        break;

      case 'FOOD':
        if (this.currentHealth == this.race.maxHealth) {
          throw new MaxHpException();
        }
        this.inventory.remove(item);
        playerTurn();
        healPlayer(3);

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
        newTemporaryEffect('MAGIC RESISTANCE', 3);

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
        playerTurn();

        this.effects.forEach((element) {
          if (element.typeOfEffect == 'TEMPORARY') {
            element.duration = 0;
          }
        });
        checkEffects();
        this.inventory.remove(item);

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

//CHECK WEAPON
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

  Result result = Result().blankResult();

  List<Item> foundResources = [];

  void action(Option option) {
// Roll Dice

    result.blankResult();

    int numberOfDice = 2;

    while (numberOfDice > 0) {
      this.result.diceResult.add(Random().nextInt(6) + 1);
      numberOfDice--;
    }
    print('  ${this.result.diceResult}');

    this.result.total =
        this.result.diceResult.fold(0, (p, element) => p + element) +
            option.value;
    this.result.sum =
        '${this.result.diceResult[0]} + ${this.result.diceResult[1]} + ${option.value} = ${this.result.total}';

    this.result.color = Colors.green;

    print('  ${this.result.total}');
    print('  ${this.result.sum}');

    switch (option.name) {
      case 'PUNCH':
        {
          if (this.result.total >= 10) {
            //10+
            this.result.outcomeTitle = 'SUCCESS';
            this.result.outcomeType = '2D6';
            this.result.outcomeAction = 'DAMAGE';
            this.result.outcomeText = 'You hit the target.';
            this.result.outcomeOptions = [];
            this.result.outcomeValue = 0;
            this.result.outcomeBonus = 0;
          } else if (this.result.total >= 7 && this.result.total <= 9) {
            //7-9
            this.result.outcomeTitle = 'HALF SUCCESS';
            this.result.outcomeType = '1D6';
            this.result.outcomeAction = 'DAMAGE';
            this.result.outcomeText = 'You hit the target.';
            this.result.outcomeOptions = [];
            this.result.outcomeValue = 0;
            this.result.outcomeBonus = 0;
          } else {
            //6-
            List<Outcome> possibleOutcomes = [
              Outcome(description: 'You miss and the enemy takes an action.'),
              Outcome(description: 'You miss and the enemy holds you.'),
            ];
            this.result.color = Colors.red;
            this.result.outcomeTitle = 'FAIL';
            this.result.outcomeType = 'TEXT';
            this.result.outcomeAction = '';
            this.result.outcomeText =
                '${possibleOutcomes[Random().nextInt(possibleOutcomes.length)].description}';
            this.result.outcomeOptions = [];
            this.result.outcomeValue = 0;
            this.result.outcomeBonus = 0;
          }
        }
        break;

      case 'WEAPON':
        {
          checkWeapon();
          reduceAmmo();

          if (this.result.total >= 10) {
            //10+
            this.result.outcomeTitle = 'SUCCESS';
            this.result.outcomeType = '2D6';
            this.result.outcomeAction = 'DAMAGE';
            this.result.outcomeText = 'You hit the target';
            this.result.outcomeOptions = [];
            this.result.outcomeValue = 2;
            this.result.outcomeBonus = this.pDamage + this.mDamage;
          } else if (this.result.total >= 7 && this.result.total <= 9) {
            //7-9
            this.result.outcomeTitle = 'HALF SUCCESS';
            this.result.outcomeType = '1D6';
            this.result.outcomeAction = 'DAMAGE';
            this.result.outcomeText = 'You hit the target.';
            this.result.outcomeOptions = [];
            this.result.outcomeValue = 1;
            this.result.outcomeBonus = this.pDamage + this.mDamage;
          } else {
            //6-
            List<Outcome> possibleOutcomes = [
              Outcome(description: 'You miss and the enemy takes an action.'),
              Outcome(description: 'You miss and the enemy holds you.'),
              Outcome(description: 'You miss and drop your weapon.'),
            ];

            this.result.color = Colors.red;
            this.result.outcomeTitle = 'FAIL';
            this.result.outcomeType = 'TEXT';
            this.result.outcomeAction = '';
            this.result.outcomeText =
                '${possibleOutcomes[Random().nextInt(possibleOutcomes.length)].description}';
            this.result.outcomeOptions = [];
            this.result.outcomeValue = 0;
            this.result.outcomeBonus = 0;
          }
        }
        break;
      case 'GRAPPLE':
        {
          if (this.result.total >= 10) {
            //10+
            this.result.outcomeTitle = 'SUCCESS';
            this.result.outcomeType = 'TEXT';
            this.result.outcomeAction = '';
            this.result.outcomeText =
                'You hold them in place and they are unable to move.';
            this.result.outcomeOptions = [];
            this.result.outcomeValue = 0;
            this.result.outcomeBonus = 0;
          } else if (this.result.total >= 7 && this.result.total <= 9) {
            //7-9
            this.result.outcomeTitle = 'HALF SUCCESS';
            this.result.outcomeType = 'TEXT';
            this.result.outcomeAction = '';
            this.result.outcomeText = 'You hold one of their arms or legs.';
            this.result.outcomeOptions = [];
            this.result.outcomeValue = 0;
            this.result.outcomeBonus = 0;
          } else {
            //6-
            List<Outcome> possibleOutcomes = [
              Outcome(description: 'They escape and take an action.'),
              Outcome(description: 'They escape and hold you down.'),
            ];
            this.result.color = Colors.red;
            this.result.outcomeTitle = 'FAIL';
            this.result.outcomeType = 'TEXT';
            this.result.outcomeAction = '';
            this.result.outcomeText =
                '${possibleOutcomes[Random().nextInt(possibleOutcomes.length)].description}';
            this.result.outcomeOptions = [];
            this.result.outcomeValue = 0;
            this.result.outcomeBonus = 0;
          }
        }
        break;
      case 'DEFEND':
        {
          if (this.result.total >= 10) {
            //10+
            this.result.outcomeTitle = 'SUCCESS';
            this.result.outcomeType = '2D6';
            this.result.outcomeAction = 'DEFEND';
            this.result.outcomeText = 'You protect some damage.';
            this.result.outcomeOptions = [];
            this.result.outcomeValue = 0;
            this.result.outcomeBonus = 0;
          } else if (this.result.total >= 7 && this.result.total <= 9) {
            //7-9
            this.result.outcomeTitle = 'HALF SUCCESS';
            this.result.outcomeType = '1D6';
            this.result.outcomeAction = 'DEFEND';
            this.result.outcomeText = 'You protect some damage.';
            this.result.outcomeOptions = [];
            this.result.outcomeValue = 0;
            this.result.outcomeBonus = 0;
          } else {
            //6-
            List<Outcome> possibleOutcomes = [
              Outcome(description: 'You take damage and are stunned.'),
              Outcome(
                  description: 'You take damage and drop a piece of armor.'),
            ];
            this.result.color = Colors.red;
            this.result.outcomeTitle = 'FAIL';
            this.result.outcomeType = 'TEXT';
            this.result.outcomeAction = '';
            this.result.outcomeText =
                '${possibleOutcomes[Random().nextInt(possibleOutcomes.length)].description}';
            this.result.outcomeOptions = [];
            this.result.outcomeValue = 0;
            this.result.outcomeBonus = 0;
          }
        }
        break;
      case 'RESIST':
        {
          if (this.result.total >= 10) {
            //10+
            this.result.outcomeTitle = 'SUCCESS';
            this.result.outcomeType = 'TEXT';
            this.result.outcomeAction = '';
            this.result.outcomeText = 'You clear all negative effects.';
            this.result.outcomeOptions = [];
            this.result.outcomeValue = 0;
            this.result.outcomeBonus = 0;
          } else if (this.result.total >= 7 && this.result.total <= 9) {
            //7-9
            this.result.outcomeTitle = 'HALF SUCCESS';
            this.result.outcomeType = 'TEXT';
            this.result.outcomeAction = '';
            this.result.outcomeText =
                'You don\'t receive any additional effect.';
            this.result.outcomeOptions = [];
            this.result.outcomeValue = 0;
            this.result.outcomeBonus = 0;
          } else {
            //6-
            List<Outcome> possibleOutcomes = [
              Outcome(description: 'You don\'t resist.'),
            ];
            this.result.color = Colors.red;
            this.result.outcomeTitle = 'FAIL';
            this.result.outcomeType = 'TEXT';
            this.result.outcomeAction = '';
            this.result.outcomeText =
                '${possibleOutcomes[Random().nextInt(possibleOutcomes.length)].description}';
            this.result.outcomeOptions = [];
            this.result.outcomeValue = 0;
            this.result.outcomeBonus = 0;
          }
        }
        break;
      case 'HELP':
        {
          if (this.result.total >= 10) {
            //10+
            this.result.outcomeTitle = 'SUCCESS';
            this.result.outcomeType = 'TEXT';
            this.result.outcomeAction = '';
            this.result.outcomeText = 'You are super helpful.';
            this.result.outcomeOptions = [];
            this.result.outcomeValue = 0;
            this.result.outcomeBonus = 0;
          } else if (this.result.total >= 7 && this.result.total <= 9) {
            //7-9
            this.result.outcomeTitle = 'HALF SUCCESS';
            this.result.outcomeType = 'TEXT';
            this.result.outcomeAction = '';
            this.result.outcomeText = 'You help them.';
            this.result.outcomeOptions = [];
            this.result.outcomeValue = 0;
            this.result.outcomeBonus = 0;
          } else {
            //6-
            List<Outcome> possibleOutcomes = [
              Outcome(description: 'You get on their way.'),
            ];
            this.result.color = Colors.red;
            this.result.outcomeTitle = 'FAIL';
            this.result.outcomeType = 'TEXT';
            this.result.outcomeAction = '';
            this.result.outcomeText =
                '${possibleOutcomes[Random().nextInt(possibleOutcomes.length)].description}';
            this.result.outcomeOptions = [];
            this.result.outcomeValue = 0;
            this.result.outcomeBonus = 0;
          }
        }
        break;
      //voltar pra ca <----------
      case 'RESOURCES':
        {
          this.foundResources = [];
          if (this.result.total >= 10) {
            //10+
            this.result.outcomeTitle = 'SUCCESS';
            this.result.outcomeType = 'OPTIONS';
            this.result.outcomeAction = 'RESOURCES';
            this.result.outcomeText = 'You find something useful.';
            this.result.outcomeValue = 2;
            this.result.outcomeBonus = 0;
            this.foundResources = this.resources(this.result.outcomeValue);
            this.result.outcomeOptions = [];

            this.foundResources.forEach((element) {
              this.result.outcomeOptions.add(Outcome(
                  name: element.name, itemList: [element], selected: false));
            });
          } else if (this.result.total >= 7 && this.result.total <= 9) {
            //7-9
            this.result.outcomeTitle = 'HALF SUCCESS';
            this.result.outcomeType = 'OPTIONS';
            this.result.outcomeAction = 'RESOURCES';
            this.result.outcomeText = 'You find something.';
            this.result.outcomeValue = 1;
            this.result.outcomeBonus = 0;
            this.foundResources = this.resources(this.result.outcomeValue);
            this.result.outcomeOptions = [];
            this.foundResources.forEach((element) {
              this.result.outcomeOptions.add(Outcome(
                  name: element.name, itemList: [element], selected: false));
            });
          } else {
            //6-
            List<Outcome> possibleOutcomes = [
              Outcome(description: 'You find a new danger.'),
              Outcome(description: 'You find a new obstacle.'),
            ];
            this.result.color = Colors.red;
            this.result.outcomeTitle = 'FAIL';
            this.result.outcomeType = 'TEXT';
            this.result.outcomeAction = '';
            this.result.outcomeText =
                '${possibleOutcomes[Random().nextInt(possibleOutcomes.length)].description}';
            this.result.outcomeOptions = [];
            this.result.outcomeValue = 0;
            this.result.outcomeBonus = 0;
          }
        }
        break;
      case 'INFORMATION':
        {
          if (this.result.total >= 10) {
            //10+
            this.result.outcomeTitle = 'SUCCESS';
            this.result.outcomeType = 'OPTIONS';
            this.result.outcomeAction = 'INFORMATION';
            this.result.outcomeText = 'You discover something important.';
            this.result.outcomeValue = 2;
            this.result.outcomeBonus = 0;
            List<Outcome> possibleOutcomes = [
              Outcome(
                  name: 'STORY',
                  description: 'You learn something about the story.',
                  selected: false),
              Outcome(
                  name: 'DANGER',
                  description: 'You learn about a danger.',
                  selected: false),
              Outcome(
                  name: 'SECRETE',
                  description: 'You learn about a secrete.',
                  selected: false),
              Outcome(
                  name: 'OBSTACLE',
                  description: 'You learn about an obstacle.',
                  selected: false),
              Outcome(
                  name: 'CHARACTER',
                  description: 'You learn about a character.',
                  selected: false),
            ];
            this.result.outcomeOptions = possibleOutcomes;
            this.result.outcomeOptions.shuffle();
            while (this.result.outcomeOptions.length > 3) {
              this.result.outcomeOptions.removeLast();
            }
          } else if (this.result.total >= 7 && this.result.total <= 9) {
            //7-9
            this.result.outcomeTitle = 'HALF SUCCESS';
            this.result.outcomeType = 'OPTIONS';
            this.result.outcomeAction = 'INFORMATION';
            this.result.outcomeText = 'You discover something.';
            this.result.outcomeValue = 1;
            this.result.outcomeBonus = 0;
            List<Outcome> possibleOutcomes = [
              Outcome(
                  name: 'STORY',
                  description: 'You learn something about the story.',
                  selected: false),
              Outcome(
                  name: 'DANGER',
                  description: 'You learn about a danger.',
                  selected: false),
              Outcome(
                  name: 'SECRETE',
                  description: 'You learn about a secrete.',
                  selected: false),
              Outcome(
                  name: 'OBSTACLE',
                  description: 'You learn about an obstacle.',
                  selected: false),
              Outcome(
                  name: 'CHARACTER',
                  description: 'You learn about a character.',
                  selected: false),
            ];
            this.result.outcomeOptions = possibleOutcomes;
            this.result.outcomeOptions.shuffle();
            while (this.result.outcomeOptions.length > 3) {
              this.result.outcomeOptions.removeLast();
            }
          } else {
            //6-
            List<Outcome> possibleOutcomes = [
              Outcome(description: 'You find a new danger.'),
              Outcome(description: 'You find a new obstacle.'),
            ];
            this.result.color = Colors.red;
            this.result.outcomeTitle = 'FAIL';
            this.result.outcomeType = 'TEXT';
            this.result.outcomeAction = '';
            this.result.outcomeText =
                '${possibleOutcomes[Random().nextInt(possibleOutcomes.length)].description}';
            this.result.outcomeOptions = [];
            this.result.outcomeValue = 0;
            this.result.outcomeBonus = 0;
          }
        }
        break;
      case 'TRADE':
        {
          if (this.result.total >= 10) {
            //10+
            this.result.outcomeTitle = 'SUCCESS';
            this.result.outcomeType = 'TEXT';
            this.result.outcomeAction = '';
            this.result.outcomeText = 'They accept your offer.';
            this.result.outcomeOptions = [];
            this.result.outcomeValue = 0;
            this.result.outcomeBonus = 0;
          } else if (this.result.total >= 7 && this.result.total <= 9) {
            //7-9
            List<Outcome> possibleOutcomes = [
              Outcome(description: 'They raise the price.'),
              Outcome(description: 'They ask for an aditional favor.'),
            ];
            this.result.outcomeTitle = 'HALF SUCCESS';
            this.result.outcomeType = 'TEXT';
            this.result.outcomeAction = '';
            this.result.outcomeText =
                '${possibleOutcomes[Random().nextInt(possibleOutcomes.length)].description}';
            this.result.outcomeOptions = [];
            this.result.outcomeValue = 0;
            this.result.outcomeBonus = 0;
          } else {
            //6-
            List<Outcome> possibleOutcomes = [
              Outcome(description: 'The deal is off.'),
              Outcome(description: 'They call for backup'),
            ];
            this.result.color = Colors.red;
            this.result.outcomeTitle = 'FAIL';
            this.result.outcomeType = 'TEXT';
            this.result.outcomeAction = '';
            this.result.outcomeText =
                '${possibleOutcomes[Random().nextInt(possibleOutcomes.length)].description}';
            this.result.outcomeOptions = [];
            this.result.outcomeValue = 0;
            this.result.outcomeBonus = 0;
          }
        }
        break;

      case 'CONVINCE':
        {
          if (this.result.total >= 10) {
            //10+
            this.result.outcomeTitle = 'SUCCESS';
            this.result.outcomeType = 'TEXT';
            this.result.outcomeAction = '';
            this.result.outcomeText = 'You change their minds.';
            this.result.outcomeOptions = [];
            this.result.outcomeValue = 0;
            this.result.outcomeBonus = 0;
          } else if (this.result.total >= 7 && this.result.total <= 9) {
            //7-9
            List<Outcome> possibleOutcomes = [
              Outcome(description: 'They ask for \$50.'),
              Outcome(description: 'They ask for \$100.'),
              Outcome(description: 'They ask for a favor.'),
            ];
            this.result.outcomeTitle = 'HALF SUCCESS';
            this.result.outcomeType = 'TEXT';
            this.result.outcomeAction = '';
            this.result.outcomeText =
                '${possibleOutcomes[Random().nextInt(possibleOutcomes.length)].description}';
            this.result.outcomeOptions = [];
            this.result.outcomeValue = 0;
            this.result.outcomeBonus = 0;
          } else {
            //6-
            List<Outcome> possibleOutcomes = [
              Outcome(description: 'They take an action.'),
              Outcome(description: 'They call for backup.'),
            ];
            this.result.color = Colors.red;
            this.result.outcomeTitle = 'FAIL';
            this.result.outcomeType = 'TEXT';
            this.result.outcomeAction = '';
            this.result.outcomeText =
                '${possibleOutcomes[Random().nextInt(possibleOutcomes.length)].description}';
            this.result.outcomeOptions = [];
            this.result.outcomeValue = 0;
            this.result.outcomeBonus = 0;
          }
        }
        break;

      case 'DODGE':
        {
          if (this.result.total >= 10) {
            //10+
            this.result.outcomeTitle = 'SUCCESS';
            this.result.outcomeType = 'TEXT';
            this.result.outcomeAction = '';
            this.result.outcomeText = 'You dodge.';
            this.result.outcomeOptions = [];
            this.result.outcomeValue = 0;
            this.result.outcomeBonus = 0;
          } else if (this.result.total >= 7 && this.result.total <= 9) {
            //7-9
            List<Outcome> possibleOutcomes = [
              Outcome(description: 'You take half damage.'),
              Outcome(description: 'You dodge, but drop something.'),
              Outcome(description: 'You dodge, but find another obstacle.'),
            ];
            this.result.outcomeTitle = 'HALF SUCCESS';
            this.result.outcomeType = 'TEXT';
            this.result.outcomeAction = '';
            this.result.outcomeText =
                '${possibleOutcomes[Random().nextInt(possibleOutcomes.length)].description}';
            this.result.outcomeOptions = [];
            this.result.outcomeValue = 0;
            this.result.outcomeBonus = 0;
          } else {
            //6-
            List<Outcome> possibleOutcomes = [
              Outcome(description: 'You take damage and fall.'),
              Outcome(description: 'You take damage and get stuck.'),
            ];
            this.result.color = Colors.red;
            this.result.outcomeTitle = 'FAIL';
            this.result.outcomeType = 'TEXT';
            this.result.outcomeAction = '';
            this.result.outcomeText =
                '${possibleOutcomes[Random().nextInt(possibleOutcomes.length)].description}';
            this.result.outcomeOptions = [];
            this.result.outcomeValue = 0;
            this.result.outcomeBonus = 0;
          }
        }
        break;
      case 'ESCAPE':
        {
          if (this.result.total >= 10) {
            //10+
            this.result.outcomeTitle = 'SUCCESS';
            this.result.outcomeType = 'TEXT';
            this.result.outcomeAction = '';
            this.result.outcomeText = 'You escape.';
            this.result.outcomeOptions = [];
            this.result.outcomeValue = 0;
            this.result.outcomeBonus = 0;
          } else if (this.result.total >= 7 && this.result.total <= 9) {
            //7-9
            List<Outcome> possibleOutcomes = [
              Outcome(description: 'One of your arms or legs gets stuck.'),
              Outcome(description: 'You escape, but leave something behind.'),
              Outcome(description: 'You escape, but find a new obstacle.'),
            ];
            this.result.outcomeTitle = 'HALF SUCCESS';
            this.result.outcomeType = 'TEXT';
            this.result.outcomeAction = '';
            this.result.outcomeText =
                '${possibleOutcomes[Random().nextInt(possibleOutcomes.length)].description}';
            this.result.outcomeOptions = [];
            this.result.outcomeValue = 0;
            this.result.outcomeBonus = 0;
          } else {
            //6-
            List<Outcome> possibleOutcomes = [
              Outcome(description: 'You are stuck and take damage.'),
              Outcome(description: 'You are stuck and loose something.'),
            ];
            this.result.color = Colors.red;
            this.result.outcomeTitle = 'FAIL';
            this.result.outcomeType = 'TEXT';
            this.result.outcomeAction = '';
            this.result.outcomeText =
                '${possibleOutcomes[Random().nextInt(possibleOutcomes.length)].description}';
            this.result.outcomeOptions = [];
            this.result.outcomeValue = 0;
            this.result.outcomeBonus = 0;
          }
        }
        break;
      case 'HIDE':
        {
          if (this.result.total >= 10) {
            //10+
            this.result.outcomeTitle = 'SUCCESS';
            this.result.outcomeType = 'TEXT';
            this.result.outcomeAction = '';
            this.result.outcomeText = 'You are hidden.';
            this.result.outcomeOptions = [];
            this.result.outcomeValue = 0;
            this.result.outcomeBonus = 0;
          } else if (this.result.total >= 7 && this.result.total <= 9) {
            //7-9
            List<Outcome> possibleOutcomes = [
              Outcome(description: 'You make a sound.'),
              Outcome(description: 'You drop something.'),
              Outcome(description: 'You loose your cover.'),
            ];
            this.result.outcomeTitle = 'HALF SUCCESS';
            this.result.outcomeType = 'TEXT';
            this.result.outcomeAction = '';
            this.result.outcomeText =
                '${possibleOutcomes[Random().nextInt(possibleOutcomes.length)].description}';
            this.result.outcomeOptions = [];
            this.result.outcomeValue = 0;
            this.result.outcomeBonus = 0;
          } else {
            //6-
            List<Outcome> possibleOutcomes = [
              Outcome(description: 'They find you and take an action.'),
              Outcome(description: 'They find you and call for backup.'),
            ];
            this.result.color = Colors.red;
            this.result.outcomeTitle = 'FAIL';
            this.result.outcomeType = 'TEXT';
            this.result.outcomeAction = '';
            this.result.outcomeText =
                '${possibleOutcomes[Random().nextInt(possibleOutcomes.length)].description}';
            this.result.outcomeOptions = [];
            this.result.outcomeValue = 0;
            this.result.outcomeBonus = 0;
          }
        }
        break;
      case 'JUMP':
        {
          if (this.result.total >= 10) {
            //10+
            this.result.outcomeTitle = 'SUCCESS';
            this.result.outcomeType = 'TEXT';
            this.result.outcomeAction = '';
            this.result.outcomeText = 'You land right on spot.';
            this.result.outcomeOptions = [];
            this.result.outcomeValue = 0;
            this.result.outcomeBonus = 0;
          } else if (this.result.total >= 7 && this.result.total <= 9) {
            //7-9
            List<Outcome> possibleOutcomes = [
              Outcome(description: 'You land in a dangerous place.'),
              Outcome(description: 'You fall on the landing.'),
            ];
            this.result.outcomeTitle = 'HALF SUCCESS';
            this.result.outcomeType = 'TEXT';
            this.result.outcomeAction = '';
            this.result.outcomeText =
                '${possibleOutcomes[Random().nextInt(possibleOutcomes.length)].description}';
            this.result.outcomeOptions = [];
            this.result.outcomeValue = 0;
            this.result.outcomeBonus = 0;
          } else {
            //6-
            List<Outcome> possibleOutcomes = [
              Outcome(description: 'You land in a bad place.'),
              Outcome(description: 'You freeze and the enemy takes an action.'),
            ];
            this.result.color = Colors.red;
            this.result.outcomeTitle = 'FAIL';
            this.result.outcomeType = 'TEXT';
            this.result.outcomeAction = '';
            this.result.outcomeText =
                '${possibleOutcomes[Random().nextInt(possibleOutcomes.length)].description}';
            this.result.outcomeOptions = [];
            this.result.outcomeValue = 0;
            this.result.outcomeBonus = 0;
          }
        }
        break;
      case 'CLIMB':
        {
          if (this.result.total >= 10) {
            //10+
            this.result.outcomeTitle = 'SUCCESS';
            this.result.outcomeType = 'TEXT';
            this.result.outcomeAction = '';
            this.result.outcomeText = 'You reach your goal.';
            this.result.outcomeOptions = [];
            this.result.outcomeValue = 0;
            this.result.outcomeBonus = 0;
          } else if (this.result.total >= 7 && this.result.total <= 9) {
            //7-9
            List<Outcome> possibleOutcomes = [
              Outcome(
                  description:
                      'You reach your goal, but leave something behind.'),
              Outcome(
                  description:
                      'You reach your goal, but find another obstacle.'),
              Outcome(description: 'You climb halfway.'),
            ];
            this.result.outcomeTitle = 'HALF SUCCESS';
            this.result.outcomeType = 'TEXT';
            this.result.outcomeAction = '';
            this.result.outcomeText =
                '${possibleOutcomes[Random().nextInt(possibleOutcomes.length)].description}';
            this.result.outcomeOptions = [];
            this.result.outcomeValue = 0;
            this.result.outcomeBonus = 0;
          } else {
            //6-
            List<Outcome> possibleOutcomes = [
              Outcome(description: 'You slide and fall.'),
              Outcome(description: 'You freeze and the enemy takes an action.'),
            ];
            this.result.color = Colors.red;
            this.result.outcomeTitle = 'FAIL';
            this.result.outcomeType = 'TEXT';
            this.result.outcomeAction = '';
            this.result.outcomeText =
                '${possibleOutcomes[Random().nextInt(possibleOutcomes.length)].description}';
            this.result.outcomeOptions = [];
            this.result.outcomeValue = 0;
            this.result.outcomeBonus = 0;
          }
        }
        break;
      case 'SWIM':
        {
          if (this.result.total >= 10) {
            //10+
            this.result.outcomeTitle = 'SUCCESS';
            this.result.outcomeType = 'TEXT';
            this.result.outcomeAction = '';
            this.result.outcomeText = 'You reach your goal.';
            this.result.outcomeOptions = [];
            this.result.outcomeValue = 0;
            this.result.outcomeBonus = 0;
          } else if (this.result.total >= 7 && this.result.total <= 9) {
            //7-9
            List<Outcome> possibleOutcomes = [
              Outcome(description: 'You swim halfway.'),
              Outcome(
                  description:
                      'You reach your goal, but find another obstacle.'),
              Outcome(
                  description:
                      'You reach your goal, but leave something behind.'),
            ];
            this.result.outcomeTitle = 'HALF SUCCESS';
            this.result.outcomeType = 'TEXT';
            this.result.outcomeAction = '';
            this.result.outcomeText =
                '${possibleOutcomes[Random().nextInt(possibleOutcomes.length)].description}';
            this.result.outcomeOptions = [];
            this.result.outcomeValue = 0;
            this.result.outcomeBonus = 0;
          } else {
            //6-
            List<Outcome> possibleOutcomes = [
              Outcome(description: 'You drink water.'),
              Outcome(description: 'You freeze and the enemy takes an action.'),
              Outcome(description: 'You sink.'),
              Outcome(description: 'You get stuck.'),
            ];
            this.result.color = Colors.red;
            this.result.outcomeTitle = 'FAIL';
            this.result.outcomeType = 'TEXT';
            this.result.outcomeAction = '';
            this.result.outcomeText =
                '${possibleOutcomes[Random().nextInt(possibleOutcomes.length)].description}';
            this.result.outcomeOptions = [];
            this.result.outcomeValue = 0;
            this.result.outcomeBonus = 0;
          }
        }
        break;
      case 'MORPH':
        {
          if (this.result.total >= 10) {
            //10+
            this.result.outcomeTitle = 'SUCCESS';
            this.result.outcomeType = 'OPTIONS';
            this.result.outcomeAction = 'MORPH';
            this.result.outcomeText = '';
            this.result.outcomeValue = 1;
            this.result.outcomeBonus = 0;
            List<Outcome> possibleOutcomes = [
              Outcome(name: 'TIGER', selected: false),
              Outcome(name: 'SHARK', selected: false),
              Outcome(name: 'GORILLA', selected: false),
              Outcome(name: 'RHYNO', selected: false),
              Outcome(name: 'GIANT EAGLE', selected: false),
              Outcome(name: 'BEAR', selected: false),
            ];
            this.result.outcomeOptions = possibleOutcomes;
            this.result.outcomeOptions.shuffle();
            while (this.result.outcomeOptions.length > 3) {
              this.result.outcomeOptions.removeLast();
            }
          } else if (this.result.total >= 7 && this.result.total <= 9) {
            //7-9
            this.result.outcomeTitle = 'HALF SUCCESS';
            this.result.outcomeType = 'OPTIONS';
            this.result.outcomeAction = 'MORPH';
            this.result.outcomeText = '';
            this.result.outcomeValue = 1;
            this.result.outcomeBonus = 0;
            List<Outcome> possibleOutcomes = [
              Outcome(name: 'FISH', selected: false),
              Outcome(name: 'LIZZARD', selected: false),
              Outcome(name: 'MONKEY', selected: false),
              Outcome(name: 'HORSE', selected: false),
              Outcome(name: 'BAT', selected: false),
              Outcome(name: 'WOLF', selected: false),
            ];
            this.result.outcomeOptions = possibleOutcomes;
            this.result.outcomeOptions.shuffle();
            while (this.result.outcomeOptions.length > 3) {
              this.result.outcomeOptions.removeLast();
            }
          } else {
            //6-
            this.result.color = Colors.red;
            this.result.outcomeTitle = 'FAIL';
            this.result.outcomeType = 'OPTIONS';
            this.result.outcomeAction = 'MORPH';
            this.result.outcomeText = '';
            this.result.outcomeValue = 1;
            this.result.outcomeBonus = 0;
            List<Outcome> possibleOutcomes = [
              Outcome(name: 'ANT', selected: false),
              Outcome(name: 'TURTLE', selected: false),
              Outcome(name: 'RAT', selected: false),
              Outcome(name: 'GOLD FISH', selected: false),
              Outcome(name: 'BUG', selected: false),
              Outcome(name: 'FROG', selected: false),
            ];
            this.result.outcomeOptions = possibleOutcomes;
            this.result.outcomeOptions.shuffle();
            while (this.result.outcomeOptions.length > 3) {
              this.result.outcomeOptions.removeLast();
            }
          }
        }
        break;
      case 'ILLUSION':
        {
          if (this.result.total >= 10) {
            //10+
            this.result.outcomeTitle = 'SUCCESS';
            this.result.outcomeType = 'OPTIONS';
            this.result.outcomeAction = 'ILLUSION';
            this.result.outcomeText = '';
            this.result.outcomeValue = 2;
            this.result.outcomeBonus = 0;
            List<Outcome> possibleOutcomes = [
              Outcome(name: 'LARGE CREATURE', selected: false),
              Outcome(name: 'GROUP OF PEOPLE', selected: false),
              Outcome(name: 'STRUCTURE', selected: false),
              Outcome(name: 'OBJECTS', selected: false),
              Outcome(name: 'OBSTACLE', selected: false),
              Outcome(name: 'ANIMALS', selected: false),
            ];
            this.result.outcomeOptions = possibleOutcomes;
            this.result.outcomeOptions.shuffle();
            while (this.result.outcomeOptions.length > 3) {
              this.result.outcomeOptions.removeLast();
            }
          } else if (this.result.total >= 7 && this.result.total <= 9) {
            //7-9
            this.result.outcomeTitle = 'HALF SUCCESS';
            this.result.outcomeType = 'OPTIONS';
            this.result.outcomeAction = 'ILLUSION';
            this.result.outcomeText = '';
            this.result.outcomeValue = 2;
            this.result.outcomeBonus = 0;
            List<Outcome> possibleOutcomes = [
              Outcome(name: 'PERSON', selected: false),
              Outcome(name: 'ANIMAL', selected: false),
              Outcome(name: 'OBJECT', selected: false),
              Outcome(name: 'LIGHT', selected: false),
              Outcome(name: 'SOUND', selected: false),
              Outcome(name: 'SMALL CREATURE', selected: false),
            ];
            this.result.outcomeOptions = possibleOutcomes;
            this.result.outcomeOptions.shuffle();
            while (this.result.outcomeOptions.length > 3) {
              this.result.outcomeOptions.removeLast();
            }
          } else {
            //6-
            List<Outcome> possibleOutcomes = [
              Outcome(description: 'People see through your illusions.'),
              Outcome(
                  description:
                      'Someone touchs your illusion and gets confused.'),
              Outcome(description: 'You loose control.'),
              Outcome(description: 'You release a loud noise.'),
              Outcome(description: 'You release a blinding light.'),
            ];
            this.result.color = Colors.red;
            this.result.outcomeTitle = 'FAIL';
            this.result.outcomeType = 'TEXT';
            this.result.outcomeAction = '';
            this.result.outcomeText =
                '${possibleOutcomes[Random().nextInt(possibleOutcomes.length)].description}';
            this.result.outcomeOptions = [];
            this.result.outcomeValue = 0;
            this.result.outcomeBonus = 0;
          }
        }
        break;
      case 'FIRE BOMB':
        {
          if (this.result.total >= 10) {
            //10+
            this.result.outcomeTitle = 'SUCCESS';
            this.result.outcomeType = '2D6';
            this.result.outcomeAction = 'DAMAGE';
            this.result.outcomeText = 'You hit the target';
            this.result.outcomeOptions = [];
            this.result.outcomeValue = 2;
            this.result.outcomeBonus = this.mDamage;
          } else if (this.result.total >= 7 && this.result.total <= 9) {
            //7-9
            this.result.outcomeTitle = 'HALF SUCCESS';
            this.result.outcomeType = '1D6';
            this.result.outcomeAction = 'DAMAGE';
            this.result.outcomeText = 'You hit the target.';
            this.result.outcomeOptions = [];
            this.result.outcomeValue = 1;
            this.result.outcomeBonus = this.mDamage;
          } else {
            //6-
            List<Outcome> possibleOutcomes = [
              Outcome(description: 'You miss and the enemy takes an action.'),
              Outcome(
                  description:
                      'You miss and the explosion creates a new obstacle'),
            ];

            this.result.color = Colors.red;
            this.result.outcomeTitle = 'FAIL';
            this.result.outcomeType = 'TEXT';
            this.result.outcomeAction = '';
            this.result.outcomeText =
                '${possibleOutcomes[Random().nextInt(possibleOutcomes.length)].description}';
            this.result.outcomeOptions = [];
            this.result.outcomeValue = 0;
            this.result.outcomeBonus = 0;
          }
        }
        break;
      case 'SMOKE BOMB':
        {
          if (this.result.total >= 10) {
            //10+
            this.result.outcomeTitle = 'SUCCESS';
            this.result.outcomeType = 'TEXT';
            this.result.outcomeAction = '';
            this.result.outcomeText =
                'You hit the target and create a cloud of smoke.';
            this.result.outcomeOptions = [];
            this.result.outcomeValue = 0;
            this.result.outcomeBonus = 0;
          } else if (this.result.total >= 7 && this.result.total <= 9) {
            //7-9
            List<Outcome> possibleOutcomes = [
              Outcome(
                  description:
                      'It lands near the target and creates a cloud of smoke.'),
              Outcome(
                  description:
                      'You hit the target, but the effect is a litte weaker.'),
            ];
            this.result.outcomeTitle = 'HALF SUCCESS';
            this.result.outcomeType = 'TEXT';
            this.result.outcomeAction = '';
            this.result.outcomeText =
                '${possibleOutcomes[Random().nextInt(possibleOutcomes.length)].description}';
            this.result.outcomeOptions = [];
            this.result.outcomeValue = 0;
            this.result.outcomeBonus = 0;
          } else {
            //6-
            List<Outcome> possibleOutcomes = [
              Outcome(description: 'You miss and the enemy takes an action.'),
              Outcome(
                  description:
                      'You miss and the explosion creates a new obstacle'),
              Outcome(
                  description:
                      'It falls from your hand and lands on your feet.'),
            ];
            this.result.color = Colors.red;
            this.result.outcomeTitle = 'FAIL';
            this.result.outcomeType = 'TEXT';
            this.result.outcomeAction = '';
            this.result.outcomeText =
                '${possibleOutcomes[Random().nextInt(possibleOutcomes.length)].description}';
            this.result.outcomeOptions = [];
            this.result.outcomeValue = 0;
            this.result.outcomeBonus = 0;
          }
        }
        break;
      case 'ICE BOMB':
        {
          if (this.result.total >= 10) {
            //10+
            this.result.outcomeTitle = 'SUCCESS';
            this.result.outcomeType = 'TEXT';
            this.result.outcomeAction = '';
            this.result.outcomeText =
                'You hit the target and freeze everything around it.';
            this.result.outcomeOptions = [];
            this.result.outcomeValue = 0;
            this.result.outcomeBonus = 0;
          } else if (this.result.total >= 7 && this.result.total <= 9) {
            //7-9
            List<Outcome> possibleOutcomes = [
              Outcome(
                  description:
                      'It lands near the target and freeze everything around it.'),
              Outcome(
                  description:
                      'You hit the target, but the effect is a litte weaker.'),
            ];
            this.result.outcomeTitle = 'HALF SUCCESS';
            this.result.outcomeType = 'TEXT';
            this.result.outcomeAction = '';
            this.result.outcomeText =
                '${possibleOutcomes[Random().nextInt(possibleOutcomes.length)].description}';
            this.result.outcomeOptions = [];
            this.result.outcomeValue = 0;
            this.result.outcomeBonus = 0;
          } else {
            //6-
            List<Outcome> possibleOutcomes = [
              Outcome(description: 'You miss and the enemy takes an action.'),
              Outcome(
                  description:
                      'You miss and the explosion creates a new obstacle'),
              Outcome(
                  description:
                      'It falls from your hand and lands on your feet.'),
            ];
            this.result.color = Colors.red;
            this.result.outcomeTitle = 'FAIL';
            this.result.outcomeType = 'TEXT';
            this.result.outcomeAction = '';
            this.result.outcomeText =
                '${possibleOutcomes[Random().nextInt(possibleOutcomes.length)].description}';
            this.result.outcomeOptions = [];
            this.result.outcomeValue = 0;
            this.result.outcomeBonus = 0;
          }
        }
        break;

//VOLTA AQUI <-----

      case 'DIG':
        {
          if (this.result.total >= 10) {
            //10+
            this.result.outcomeTitle = 'SUCCESS';
            this.result.outcomeType = 'TEXT';
            this.result.outcomeAction = '';
            this.result.outcomeText = 'You dig a hole.';
            this.result.outcomeOptions = [];
            this.result.outcomeValue = 0;
            this.result.outcomeBonus = 0;
          } else if (this.result.total >= 7 && this.result.total <= 9) {
            //7-9
            List<Outcome> possibleOutcomes = [
              Outcome(description: 'You dig a small hole.'),
              Outcome(description: 'You dig a hole near you.'),
            ];
            this.result.outcomeTitle = 'HALF SUCCESS';
            this.result.outcomeType = 'TEXT';
            this.result.outcomeAction = '';
            this.result.outcomeText =
                '${possibleOutcomes[Random().nextInt(possibleOutcomes.length)].description}';
            this.result.outcomeOptions = [];
            this.result.outcomeValue = 0;
            this.result.outcomeBonus = 0;
          } else {
            //6-
            List<Outcome> possibleOutcomes = [
              Outcome(description: 'You loose control and destroy something.'),
              Outcome(
                  description:
                      'You loose control and the enemy takes an action.'),
              Outcome(
                  description: 'You loose control and put a friend in a hole.'),
              Outcome(
                  description: 'You loose control and get stuck in a hole.'),
            ];
            this.result.color = Colors.red;
            this.result.outcomeTitle = 'FAIL';
            this.result.outcomeType = 'TEXT';
            this.result.outcomeAction = '';
            this.result.outcomeText =
                '${possibleOutcomes[Random().nextInt(possibleOutcomes.length)].description}';
            this.result.outcomeOptions = [];
            this.result.outcomeValue = 0;
            this.result.outcomeBonus = 0;
          }
        }
        break;
      case 'HOLD':
        {
          if (this.result.total >= 10) {
            //10+
            this.result.outcomeTitle = 'SUCCESS';
            this.result.outcomeType = 'TEXT';
            this.result.outcomeAction = '';
            this.result.outcomeText = 'You hold them.';
            this.result.outcomeOptions = [];
            this.result.outcomeValue = 0;
            this.result.outcomeBonus = 0;
          } else if (this.result.total >= 7 && this.result.total <= 9) {
            //7-9

            this.result.outcomeTitle = 'HALF SUCCESS';
            this.result.outcomeType = 'TEXT';
            this.result.outcomeAction = '';
            this.result.outcomeText = 'You hold one of their arms or legs.';
            this.result.outcomeOptions = [];
            this.result.outcomeValue = 0;
            this.result.outcomeBonus = 0;
          } else {
            //6-
            List<Outcome> possibleOutcomes = [
              Outcome(description: 'They escape and take an action.'),
              Outcome(description: 'You loose control and it backfires.'),
              Outcome(description: 'You loose control and hold a friend.'),
              Outcome(
                  description: 'You loose control and  create new obstacle.'),
            ];
            this.result.color = Colors.red;
            this.result.outcomeTitle = 'FAIL';
            this.result.outcomeType = 'TEXT';
            this.result.outcomeAction = '';
            this.result.outcomeText =
                '${possibleOutcomes[Random().nextInt(possibleOutcomes.length)].description}';
            this.result.outcomeOptions = [];
            this.result.outcomeValue = 0;
            this.result.outcomeBonus = 0;
          }
        }
        break;
      case 'BUILD':
        {
          if (this.result.total >= 10) {
            //10+
            this.result.outcomeTitle = 'SUCCESS';
            this.result.outcomeType = 'OPTIONS';
            this.result.outcomeAction = 'BUILD';
            this.result.outcomeText = '';
            this.result.outcomeValue = 1;
            this.result.outcomeBonus = 0;
            List<Outcome> possibleOutcomes = [
              Outcome(name: 'FULL COVER', selected: false),
              Outcome(name: 'LARGE STRUCTURE', selected: false),
              Outcome(name: 'FUNITURE', selected: false),
              Outcome(name: 'LARGE OBSTACLE', selected: false),
              Outcome(name: 'PATH', selected: false),
              Outcome(name: 'TRAP', selected: false),
            ];
            this.result.outcomeOptions = possibleOutcomes;
            this.result.outcomeOptions.shuffle();
            while (this.result.outcomeOptions.length > 3) {
              this.result.outcomeOptions.removeLast();
            }
          } else if (this.result.total >= 7 && this.result.total <= 9) {
            //7-9
            this.result.outcomeTitle = 'HALF SUCCESS';
            this.result.outcomeType = 'OPTIONS';
            this.result.outcomeAction = 'BUILD';
            this.result.outcomeText = '';
            this.result.outcomeValue = 1;
            this.result.outcomeBonus = 0;
            List<Outcome> possibleOutcomes = [
              Outcome(name: 'HALF COVER', selected: false),
              Outcome(name: 'STRUCTURE', selected: false),
              Outcome(name: 'FUNITURE', selected: false),
              Outcome(name: 'OBSTACLE', selected: false),
              Outcome(name: 'OPENING', selected: false),
              Outcome(name: 'SMALL TRAP', selected: false),
            ];
            this.result.outcomeOptions = possibleOutcomes;
            this.result.outcomeOptions.shuffle();
            while (this.result.outcomeOptions.length > 3) {
              this.result.outcomeOptions.removeLast();
            }
          } else {
            //6-
            List<Outcome> possibleOutcomes = [
              Outcome(description: 'You loose control and destroy something.'),
              Outcome(
                  description:
                      'You have to concentrate and the enemy takes an action.'),
              Outcome(description: 'You loose control and lock a friend.'),
              Outcome(description: 'You loose control and it backfires'),
            ];
            this.result.color = Colors.red;
            this.result.outcomeTitle = 'FAIL';
            this.result.outcomeType = 'TEXT';
            this.result.outcomeAction = '';
            this.result.outcomeText =
                '${possibleOutcomes[Random().nextInt(possibleOutcomes.length)].description}';
            this.result.outcomeOptions = [];
            this.result.outcomeValue = 0;
            this.result.outcomeBonus = 0;
          }
        }
        break;
      case 'DESTROY':
        {
          if (this.result.total >= 10) {
            //10+
            this.result.outcomeTitle = 'SUCCESS';
            this.result.outcomeType = 'TEXT';
            this.result.outcomeAction = '';
            this.result.outcomeText = 'You destroy a structure.';
            this.result.outcomeOptions = [];
            this.result.outcomeValue = 0;
            this.result.outcomeBonus = 0;
          } else if (this.result.total >= 7 && this.result.total <= 9) {
            //7-9

            this.result.outcomeTitle = 'HALF SUCCESS';
            this.result.outcomeType = 'TEXT';
            this.result.outcomeAction = '';
            this.result.outcomeText = 'You destroy half of it.';
            this.result.outcomeOptions = [];
            this.result.outcomeValue = 0;
            this.result.outcomeBonus = 0;
          } else {
            //6-
            List<Outcome> possibleOutcomes = [
              Outcome(
                  description:
                      'You create an explosion around you that sends everyone flying.'),
              Outcome(
                  description:
                      'You destroy the wrong thing and create an obstacle.'),
            ];
            this.result.color = Colors.red;
            this.result.outcomeTitle = 'FAIL';
            this.result.outcomeType = 'TEXT';
            this.result.outcomeAction = '';
            this.result.outcomeText =
                '${possibleOutcomes[Random().nextInt(possibleOutcomes.length)].description}';
            this.result.outcomeOptions = [];
            this.result.outcomeValue = 0;
            this.result.outcomeBonus = 0;
          }
        }
        break;
      case 'TRANSFORM':
        {
          if (this.result.total >= 10) {
            //10+
            this.result.outcomeTitle = 'SUCCESS';
            this.result.outcomeType = 'TEXT';
            this.result.outcomeAction = '';
            this.result.outcomeText = 'You transform into someone else.';
            this.result.outcomeOptions = [];
            this.result.outcomeValue = 0;
            this.result.outcomeBonus = 0;
          } else if (this.result.total >= 7 && this.result.total <= 9) {
            //7-9
            List<Outcome> possibleOutcomes = [
              Outcome(description: 'Your voice become like someone\'s elses.'),
              Outcome(
                  description: 'Your appearance become like someone\'s elses.'),
            ];
            this.result.outcomeTitle = 'HALF SUCCESS';
            this.result.outcomeType = 'TEXT';
            this.result.outcomeAction = '';
            this.result.outcomeText =
                '${possibleOutcomes[Random().nextInt(possibleOutcomes.length)].description}';
            this.result.outcomeOptions = [];
            this.result.outcomeValue = 0;
            this.result.outcomeBonus = 0;
          } else {
            //6-
            List<Outcome> possibleOutcomes = [
              Outcome(description: 'You become a little kid.'),
              Outcome(description: 'You become an old lady.'),
              Outcome(description: 'You become blind.'),
              Outcome(description: 'You make a loud noise.'),
            ];
            this.result.color = Colors.red;
            this.result.outcomeTitle = 'FAIL';
            this.result.outcomeType = 'TEXT';
            this.result.outcomeAction = '';
            this.result.outcomeText =
                '${possibleOutcomes[Random().nextInt(possibleOutcomes.length)].description}';
            this.result.outcomeOptions = [];
            this.result.outcomeValue = 0;
            this.result.outcomeBonus = 0;
          }
        }
        break;
      case 'ENHANCE':
        {
          if (this.result.total >= 10) {
            //10+
            this.result.outcomeTitle = 'SUCCESS';
            this.result.outcomeType = 'OPTIONS';
            this.result.outcomeAction = 'ENHANCE';
            this.result.outcomeText = '';
            this.result.outcomeValue = 2;
            this.result.outcomeBonus = 0;
            List<Outcome> possibleOutcomes = [
              Outcome(name: 'NIGHT VISION', selected: false),
              Outcome(name: 'INFRARED VISION', selected: false),
              Outcome(name: 'X-RAY VISION', selected: false),
              Outcome(name: 'ULTRASONIC HEARING', selected: false),
              Outcome(name: 'SPEED', selected: false),
              Outcome(name: 'POWER', selected: false),
              Outcome(name: 'CLIMB', selected: false),
              Outcome(name: 'FLY', selected: false),
              Outcome(name: 'BREATH UNDERWATER', selected: false),
              Outcome(name: 'THICK SKIN', selected: false),
              Outcome(name: 'SUPER STRENGTH', selected: false),
              Outcome(name: 'SUPER JUMP', selected: false),
            ];
            this.result.outcomeOptions = possibleOutcomes;
            this.result.outcomeOptions.shuffle();
            while (this.result.outcomeOptions.length > 3) {
              this.result.outcomeOptions.removeLast();
            }
          } else if (this.result.total >= 7 && this.result.total <= 9) {
            //7-9
            this.result.outcomeTitle = 'HALF SUCCESS';
            this.result.outcomeType = 'OPTIONS';
            this.result.outcomeAction = 'ENHANCE';
            this.result.outcomeText = '';
            this.result.outcomeValue = 1;
            this.result.outcomeBonus = 0;
            List<Outcome> possibleOutcomes = [
              Outcome(name: 'NIGHT VISION', selected: false),
              Outcome(name: 'INFRARED VISION', selected: false),
              Outcome(name: 'X-RAY VISION', selected: false),
              Outcome(name: 'ULTRASONIC HEARING', selected: false),
              Outcome(name: 'SPEED', selected: false),
              Outcome(name: 'POWER', selected: false),
              Outcome(name: 'CLIMB', selected: false),
              Outcome(name: 'FLY', selected: false),
              Outcome(name: 'BREATH UNDERWATER', selected: false),
              Outcome(name: 'THICK SKIN', selected: false),
              Outcome(name: 'SUPER STRENGTH', selected: false),
              Outcome(name: 'SUPER JUMP', selected: false),
            ];
            this.result.outcomeOptions = possibleOutcomes;
            this.result.outcomeOptions.shuffle();
            while (this.result.outcomeOptions.length > 3) {
              this.result.outcomeOptions.removeLast();
            }
          } else {
            //6-
            List<Outcome> possibleOutcomes = [
              Outcome(description: 'You become blind.'),
              Outcome(description: 'You make them blind.'),
              Outcome(description: 'You make them numb.'),
              Outcome(description: 'You fail and the enemy takes an action.'),
            ];
            this.result.color = Colors.red;
            this.result.outcomeTitle = 'FAIL';
            this.result.outcomeType = 'TEXT';
            this.result.outcomeAction = '';
            this.result.outcomeText =
                '${possibleOutcomes[Random().nextInt(possibleOutcomes.length)].description}';
            this.result.outcomeOptions = [];
            this.result.outcomeValue = 0;
            this.result.outcomeBonus = 0;
          }
        }
        break;
      case 'CURSE':
        {
          if (this.result.total >= 10) {
            //10+
            this.result.outcomeTitle = 'SUCCESS';
            this.result.outcomeType = 'OPTIONS';
            this.result.outcomeAction = 'CURSE';
            this.result.outcomeText = '';
            this.result.outcomeValue = 2;
            this.result.outcomeBonus = 0;
            List<Outcome> possibleOutcomes = [
              Outcome(name: 'WEAK', selected: false),
              Outcome(name: 'VULNERABLE', selected: false),
              Outcome(name: 'BLIND', selected: false),
              Outcome(name: 'MUTE', selected: false),
              Outcome(name: 'NUMB', selected: false),
              Outcome(name: 'DEAF', selected: false),
              Outcome(name: 'PARALIZED', selected: false),
              Outcome(name: 'CHARM', selected: false),
              Outcome(name: 'FORGET', selected: false),
              Outcome(name: 'SCARED', selected: false),
              Outcome(name: 'SLOW', selected: false),
              Outcome(name: 'UGLY', selected: false),
            ];
            this.result.outcomeOptions = possibleOutcomes;
            this.result.outcomeOptions.shuffle();
            while (this.result.outcomeOptions.length > 3) {
              this.result.outcomeOptions.removeLast();
            }
          } else if (this.result.total >= 7 && this.result.total <= 9) {
            //7-9
            this.result.outcomeTitle = 'HALF SUCCESS';
            this.result.outcomeType = 'OPTIONS';
            this.result.outcomeAction = 'CURSE';
            this.result.outcomeText = '';
            this.result.outcomeValue = 1;
            this.result.outcomeBonus = 0;
            List<Outcome> possibleOutcomes = [
              Outcome(name: 'WEAK', selected: false),
              Outcome(name: 'VULNERABLE', selected: false),
              Outcome(name: 'BLIND', selected: false),
              Outcome(name: 'MUTE', selected: false),
              Outcome(name: 'NUMB', selected: false),
              Outcome(name: 'DEAF', selected: false),
              Outcome(name: 'PARALIZED', selected: false),
              Outcome(name: 'CHARM', selected: false),
              Outcome(name: 'FORGET', selected: false),
              Outcome(name: 'SCARED', selected: false),
              Outcome(name: 'SLOW', selected: false),
              Outcome(name: 'UGLY', selected: false),
            ];
            this.result.outcomeOptions = possibleOutcomes;
            this.result.outcomeOptions.shuffle();
            while (this.result.outcomeOptions.length > 3) {
              this.result.outcomeOptions.removeLast();
            }
          } else {
            //6-
            List<Outcome> possibleOutcomes = [
              Outcome(description: 'You become blind.'),
              Outcome(description: 'You make them stronger.'),
              Outcome(description: 'You make them faster.'),
              Outcome(description: 'You fail and the enemy takes an action.'),
            ];
            this.result.color = Colors.red;
            this.result.outcomeTitle = 'FAIL';
            this.result.outcomeType = 'TEXT';
            this.result.outcomeAction = '';
            this.result.outcomeText =
                '${possibleOutcomes[Random().nextInt(possibleOutcomes.length)].description}';
            this.result.outcomeOptions = [];
            this.result.outcomeValue = 0;
            this.result.outcomeBonus = 0;
          }
        }
        break;
    }

    //Count player turn
    playerTurn();
  }

  void secondRoll(int numberDice) {
    this.result.diceResult.clear();

    for (int i = 0; i < numberDice; i++) {
      this.result.diceResult.add(Random().nextInt(6) + 1);
    }
    print('  ${this.result.diceResult}');

    this.result.total =
        this.result.diceResult.fold(0, (p, element) => p + element) +
            this.result.outcomeBonus;
    this.result.sum =
        '${this.result.total - this.result.outcomeBonus} + ${this.result.outcomeBonus} = ${this.result.total}';
  }

  void chooseOutcome() {
    switch (this.result.outcomeAction) {
      case 'RESOURCES':
        {
          this.result.outcomeOptions.forEach((outcome) {
            if (outcome.selected) {
              this.inventory.add(outcome.itemList.first);
            }
          });
        }
        break;

      case 'INFORMATION':
        {}
        break;

      case 'MORPH':
        {}
        break;

      case 'ILLUSION':
        {}
        break;

      case 'ENHANCE':
        {}
        break;
      case 'CURSE':
        {}
        break;
    }
  }

  // void action(Option option) {
  //   //Count player turn
  //   playerTurn();

  //   //Reduce ammunition
  //   if (option.name == 'WEAPON') {
  //     this.reduceAmmo();
  //   }

  //   //Prepare for second roll
  //   option.firstRoll = false;
  // }

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

//FIND RESOURCES

  List<Item> resources(int numberDice) {
    List<Item> lootList = [];

    if (numberDice > 1) {
//10+

      for (int i = 0; i < 3; i++) {
        lootList.add(shop.randomResourceRange(100, 300));
      }
    } else {
//9-7
      for (int i = 0; i < 3; i++) {
        lootList.add(shop.randomResourceRange(100, 100));
      }
    }
    // if (numberDice > 1) {
    //   int randomGold = (Random().nextInt(4) + 1) * 25;
    //   this.gold += randomGold;
    //   lootList.add('\$ $randomGold');
    // }

    // int loot = Random().nextInt(shop.resources.length);
    // inventory.add(shop.resources[loot]);

    // lootList.add('${shop.resources[loot].name}');
    return lootList;
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
      this.playerTurn();
    }
  }

  void playerTurn() {
    if (this.turn.contains(false)) {
      this.actionsTaken++;
      this.runEffects();
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

// EFFECTS

  void newPermanentEffect(String name) {
    switch (name) {
      case 'FAME':
        {
          this.fame++;
        }
        break;
    }

    this.effects.add(this.effectList.newPermanentEffect(name).copyEffect());
  }

  void removePermanentEffect(String name) {
    List<Effect> currentEffects = [];

    switch (name) {
      case 'FAME':
        {
          this.fame--;
        }
        break;
    }
    currentEffects
        .add(this.effects.lastWhere((element) => element.name == name));
    currentEffects.forEach((element) {
      this.effects.remove(element);
    });
  }

  void newTemporaryEffect(String name, int duration) {
    switch (name) {
      case 'MAGIC RESISTANCE':
        {
          this.mArmor += 3;
        }
        break;
      case 'FAST':
        {
          this.playerAction[5].value++;
        }
        break;
      case 'POWERFUL':
        {
          this.playerAction[1].value++;
        }
        break;
      case 'PERCEPTIVE':
        {
          this.playerAction[3].value++;
        }
        break;
    }

    this
        .effects
        .add(this.effectList.newTemporaryEffect(name, duration).copyEffect());
  }

  void removeTemporaryEffect(Effect effect) {
    switch (effect.name) {
      case 'MAGIC RESISTANCE':
        {
          this.mArmor -= 3;
        }
        break;
      case 'FAST':
        {
          this.playerAction[5].value--;
        }
        break;
      case 'POWERFUL':
        {
          this.playerAction[1].value--;
        }
        break;
      case 'PERCEPTIVE':
        {
          this.playerAction[3].value--;
        }
        break;
    }
  }

  void selectEffect(int index) {
    this.effect = this.effects[index].copyEffect();
  }

  void runEffects() {
    if (this.effects.isEmpty == true) {
      return;
    }
    this.effects.forEach((element) {
      if (element.typeOfEffect == 'PERMANENT') {
        return;
      }
      element.duration--;
    });
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

      if (element.duration < 1) {
        removeTemporaryEffect(element);
        currentEffects.add(element);
      }
    });

    if (currentEffects.isNotEmpty) {
      currentEffects.forEach((element) {
        this.effects.remove(element);
      });
    }
  }

  void checkSkillEffects(List<String> itemList) {
    List<Effect> deleteEffects = [];

    this.effects.forEach((effect) {
      if (effect.typeOfEffect == 'PERMANENT') {
        return;
      }

      itemList.forEach((item) {
        if (item == effect.name) {
          removeTemporaryEffect(effect);
          deleteEffects.add(effect);
        }
      });
    });

    if (deleteEffects.isNotEmpty) {
      deleteEffects.forEach((element) {
        this.effects.remove(element);
      });
    }
  }

  void changeFame(int value) {
    if (this.fame + value < 1) {
      removePermanentEffect('FAME');

      return;
    }
  }

//CREATE RANDOM PLAYER

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

    //Assign the action value to each option
    this.playerAction.forEach((action) {
      action.option.forEach((option) {
        option.value = action.value;
      });
    });

    this.characterFinished = true;
  }

  Player(this.playerColor);

  void setColor(PlayerColor playerColor) {
    this.playerColor = playerColor;
  }

//FINISH CHARACTER

  void finishCharacter(String name) {
    this.playerColor.name = name;

//Assign the action value to each option
    this.playerAction.forEach((action) {
      action.option.forEach((option) {
        option.value = action.value;
      });
    });

    this.characterFinished = true;
  }
}
