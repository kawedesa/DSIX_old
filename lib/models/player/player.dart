import 'dart:math';

import 'package:dsixv02app/models/game/item.dart';
import 'package:dsixv02app/models/player/playerBackground.dart';
import 'package:flutter/material.dart';
import 'package:dsixv02app/models/player/playerRace.dart';
import 'package:dsixv02app/models/player/option.dart';
import 'package:dsixv02app/models/player/playerAction.dart';
import 'package:dsixv02app/effect.dart';
import 'exceptions.dart';
import 'package:dsixv02app/models/player/bonus.dart';
import 'package:dsixv02app/models/game/shop.dart';

class PlayerColor {
  String name;
  Color primaryColor;
  Color secondaryColor;
  Color tertiaryColor;

  PlayerColor(
      this.name, this.primaryColor, this.secondaryColor, this.tertiaryColor);
}

Shop shop = Shop();

class Player {
  // var playerIndex;

  PlayerColor playerColor;

  bool characterFinished = false;

  int actionsTaken = 0;

//CHOOSE RACE AND SEX // DEFINE HP, ACTION POINTS, WEIGHT, ACTIONS

  List<PlayerRace> races = [
    PlayerRace(
        'human',
        'HUMAN',
        'Humans are everywhere. They are flexible and adapt to most circumstances, so you get an extra action point to spend anyway you want.',
        [
          Bonus(
              '+ ACTION POINT  ',
              'actionPoint',
              'Each action point allows you to improve the chance of success of an action for ever.',
              1)
        ]),
    PlayerRace(
        'orc',
        'ORC',
        'Orcs are tall and strong, making them good fighters but easy targets. They can carry more weight, but have a harder time moving around.',
        [
          Bonus('+ ATTACK  ', 'attack',
              'You use this action when you attack a target.', 1),
          Bonus(
              '- MOVE  ',
              'move',
              'You use this action when you jump, climb, hide, dodge or escape.',
              -1),
          Bonus(
              '+ WEIGHT  ',
              'maxWeight',
              'This represents the total amount of weight you can carry. Because of your strength, you can carry +6 weight.',
              6)
        ]),
    PlayerRace(
        'goblin',
        'GOBLIN',
        'Goblins are small, vicious creatures with sharp teeth and quick feet. They are not really strong, but are still very dangerous.',
        [
          Bonus('+ ATTACK  ', 'attack',
              'You use this action when you attack a target.', 1),
          Bonus(
              '+ MOVE  ',
              'move',
              'You use this action when you jump, climb, hide, dodge or escape.',
              1),
          Bonus(
              '- WEIGHT  ',
              'maxWeight',
              'This represents the total amount of weight you can carry. Because you are weak, you carry -6 weight.',
              -6)
        ]),
    PlayerRace(
        'dwarf',
        'DWARF',
        'Dwarfs are sturdy, allowing them to take more blows before going down. However, their small size and stubborn personality limits their perception.',
        [
          Bonus('+ DEFENSE  ', 'defense',
              'You use this action when you protect yourself or others.', 1),
          Bonus('- PERCEIVE  ', 'perceive',
              'You use this action when you search for something.', -1),
          Bonus(
              '+ HEALTH  ',
              'maxHealth',
              'This represents your total health and you die when it reaches zero. Because of your sturdy nature you have +6 HP.',
              6)
        ]),
    PlayerRace(
        'halfling',
        'HALFLING',
        'Halflings are small curious creatures, always looking for something new to learn. They are not really good at fighting and try to solve most problems without violence.',
        [
          Bonus('- ATTACK  ', 'attack',
              'You use this action when you attack a target.', -1),
          Bonus('+ PERCEIVE  ', 'perceive',
              'You use this action when you search for something.', 1),
          Bonus(
              '+ TALK  ',
              'talk',
              'You use this action when you talk to someone that can understand you.',
              1)
        ]),
    PlayerRace(
        'elf',
        'ELF',
        'Elves have slim bodies and sharp senses, making them very perceptive and agile. Because of their frail constitution, they rely on their reflexes to avoid danger.',
        [
          Bonus('- DEFENSE  ', 'defense',
              'You use this action when you protect yourself or others.', -1),
          Bonus('+ PERCEIVE  ', 'perceive',
              'You use this action when you search for something.', 1),
          Bonus(
              '+ MOVE  ',
              'move',
              'You use this action when you jump, climb, hide, dodge or escape.',
              1)
        ]),

    //PlayerRace('gnome','GNOME','Gnomes are small and curious creatures, that are always working on a crazy project.',Bonus(0,'INVENTION', 'Choose your invention:',[Option(0,'DAMAGE','You receive a bonus of +2 to your damage.','CON'),Option(0,'DAMAGE','You receive a bonus of +2 to your damage.','CON'),Option(0,'DAMAGE','You receive a bonus of +2 to your damage.','CON'),Option(0,'DAMAGE','You receive a bonus of +2 to your damage.','CON'),])),
    //PlayerRace('darkElf','DARK ELF','Dark elfs are smarter than most people, making them quite arrogant.',Bonus(1,'INTELLIGENCE', 'Intelligence represents how much you know about the world.',[])),
    //PlayerRace('machine','MACHINE','Machines are created with the ability to perform a task. They are everywhere, but only a few of them are conscious.',Bonus(0,'ABILITY', 'Choose your ability:',[Option(0,'DAMAGE','You receive a bonus of +2 to your damage.','CON'),Option(0,'DAMAGE','You receive a bonus of +2 to your damage.','CON'),Option(0,'DAMAGE','You receive a bonus of +2 to your damage.','CON'),Option(0,'DAMAGE','You receive a bonus of +2 to your damage.','CON'),])),
    //PlayerRace('elemental','ELEMENTAL','Elementals are powerful magical beings, that live in nature and protect their habitat.',Bonus(2,'MAGIC ARMOR', 'You have a defensive layer that protects against magic attacks.',[])),
    //PlayerRace('lizard','LIZARD','Lizards are covered with beautiful scales that offer protection.',Bonus(2,'ARMOR', 'Your scales protect against physical attacks.',[])),
    //PlayerRace('beast','BEAST','Beasts vary in size and power. Each one has a different ability that helps them survive in nature.',Bonus(0,'ABILITY', 'Choose your ability:',[Option(0,'DAMAGE','You receive a bonus of +2 to your damage.','CON'),Option(0,'DAMAGE','You receive a bonus of +2 to your damage.','CON'),Option(0,'DAMAGE','You receive a bonus of +2 to your damage.','CON'),Option(0,'DAMAGE','You receive a bonus of +2 to your damage.','CON'),])),
  ];

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
    this.race = races[index];

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
          this.maxWeight = 18; //WEIGHT
        }
        break;

      case 'GOBLIN':
        {
          this.actionPoints[1] = 1; //ATTACK
          this.actionPoints[5] = 1; //MOVE
          this.maxWeight = 6; //WEIGHT
        }
        break;

      case 'DWARF':
        {
          this.actionPoints[2] = 1; //DEFENSE
          this.actionPoints[3] = -1; //PERCEIVE
          this.maxHealth = 18; //HEALTH
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

  List<PlayerBackground> backgrounds = [
    PlayerBackground(
        'noble',
        'NOBLE',
        'Your life is filled with money and gifts. Your family is well known, and most people respect you.',
        [
          Bonus('GOLD', 'gold', 'You are rich! So you get an extra \$500 gold.',
              500)
        ],
        []),
    PlayerBackground(
        'fighter',
        'FIGHTER',
        'You move around, from place to place, looking for blood and coin. People stay out of your way, by will or by force.',
        [
          Bonus('+2 ARMOR   ', 'pArmor',
              'This represents how much damage you mitigate from attacks.', 2),
          Bonus('GLOVES', 'item', '${shop.armor[1].description}', 0),
          Bonus('BOOTS', 'item', '${shop.armor[0].description}', 0)
        ],
        [
          shop.armor[0],
          shop.armor[1],
        ]),
    PlayerBackground(
        'thief',
        'THIEF',
        'You have quick hands and a burning desire for treasure. Some people steal out of necessity, others do it for fun. You do it because you can.',
        [
          Bonus('+1 DAMAGE   ', 'pDamage',
              'This represents how much damage you deal with your attacks.', 1),
          Bonus('+1 ARMOR   ', 'pArmor',
              'This represents how much damage you mitigate from attacks.', 1),
          Bonus('2x KEYS   ', 'item', '${shop.resources[6].description}', 0)
        ],
        [
          shop.resources[6],
          shop.resources[6],
        ]),
    PlayerBackground(
        'mage',
        'MAGE',
        'You are familiar with magic. Either born with it or taught by a mentor. Most people see you as a freak and keep their distance.',
        [
          Bonus(
              '+1 MAGIC DAMAGE   ',
              'mDamage',
              'This represents how much magic damage you deal with your attacks.',
              1),
          Bonus('MAGIC ORB', 'item', '${shop.magicWeapons[0].description}', 0)
        ],
        [
          shop.magicWeapons[0],
        ]),
    PlayerBackground(
        'hunter',
        'HUNTER',
        'You spend most of your time hunting for game. You are not really used to people and feel more comfortable outdoors.',
        [
          Bonus('+2 DAMAGE   ', 'pDamage',
              'This represents how much damage you deal with your attacks.', 1),
          Bonus('AMMO  ', 'item', '${shop.resources[4].description}', 0),
          Bonus('HERBS  ', 'item', '${shop.resources[1].description}', 0)
        ],
        [
          shop.resources[4],
          shop.resources[1],
        ]),
    PlayerBackground(
        'medic',
        'MEDIC',
        'You already saved many lives and people respect you. Blood, diseases, guts and bones don\'t bother you.',
        [
          Bonus(
              '+1 MAGIC ARMOR   ',
              'mArmor',
              'This represents how much damage you mitigate from magic attacks.',
              1),
          Bonus('2x BANDAGES   ', 'item', '${shop.resources[0].description}', 0)
        ],
        [
          shop.resources[0],
          shop.resources[0]
        ]),
    PlayerBackground(
        '',
        'BACKGROUND',
        'This represents your story. How you where raised and how people see you. Click on the icons above to choose your background.',
        [
          Bonus(
              'BONUS',
              'bonus',
              'All backgrounds are unique and have different bonuses. They can be items, gold, and passive attributes, like armor and damage.',
              0)
        ],
        []),

    //OLD BACKGROUNDS

    //PlayerBackground(2,'Merchant','You are a successful merchant and know the real value of things. Nobody gets in between you and a good deal.','\$ 400',[]),
    //PlayerBackground(3,'Spy','You have many names, but none of them are real. You leave no footsteps behind.','GLOVES, BOOTS, GEAR',[shop.shopList[80], shop.shopList[67],shop.shopList[65],]),
    //PlayerBackground(4,'Prisoner','You are a criminal and nobody believes in you. You have nothing, but a key and the will to escape.','KEY',[shop.shopList[81]]),
    //PlayerBackground(5,'Pirate','You believe that laws are stupid and nobody can own something they can\'t protect. The world is there for the taking.','HAND CANNON',[shop.shopList[39]]),
    //PlayerBackground(7,'Worker','You are the pillar of any society and do the heavy lifting, while the nobles drink their wine.','TOOL GEAR',[shop.shopList[80],shop.shopList[80],]),
    //PlayerBackground(8,'Cook','You are an alchemist of smells and flavours. There is nothing more powerful than a tasty meal.','CLEAVER GEAR',[shop.shopList[80],shop.shopList[80],]),
    //PlayerBackground(10,'Detective','You are needed, because justice is blind. You can always tell when someone is lying.','WARD, WARD',[shop.shopList[82],shop.shopList[82],]),
    //PlayerBackground(11,'Performer','You are comfortable around people and love to the center of attention. Laughter, music, wine and love are your trade.','LUCKY CHARM, LUCKY CHARM',[shop.shopList[89],shop.shopList[89],]),
    //PlayerBackground(14,'Student','You are very curious about everything and believes that knowledge is power. There is always something new to be learned.','BOOK, BOOK, GEAR',[shop.shopList[78],shop.shopList[78],shop.shopList[80],]),
    //PlayerBackground(15,'Traveler','You wear different clothes and have a different accent. People don\'t know where you came from or where you are going.','SCROLL',[shop.shopList[46],shop.shopList[51],]),
    //PlayerBackground(16,'Assassin','You live a solitary life and trust no one. You are an agent of destruction and death is your only partner. ','DAGGER, KUNAI, ANTIDOTE',[shop.shopList[3],shop.shopList[35],shop.shopList[71],]),
    //PlayerBackground(18,'Fugitive','You are running from your past, and nothing will make you go back. You are going to be fine if you stay one step ahead.','FREE ACTION, BOOTS',[shop.shopList[65],shop.shopList[88],]),
  ];

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

    this.playerBackground = backgrounds[index];

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

  Item headEquip = Item(
    'head',
    '',
    '',
    '',
    '',
    0,
    0,
    0,
    0,
    0,
    0,
    0,
  );
  Item bodyEquip = Item(
    'body',
    '',
    '',
    '',
    '',
    0,
    0,
    0,
    0,
    0,
    0,
    0,
  );
  Item mainHandEquip = Item(
    'mainHand',
    '',
    '',
    '',
    '',
    0,
    0,
    0,
    0,
    0,
    0,
    0,
  );
  Item offHandEquip = Item(
    'offHand',
    '',
    '',
    '',
    '',
    0,
    0,
    0,
    0,
    0,
    0,
    0,
  );
  Item handsEquip = Item(
    'hands',
    '',
    '',
    '',
    '',
    0,
    0,
    0,
    0,
    0,
    0,
    0,
  );
  Item feetEquip = Item(
    'feet',
    '',
    '',
    '',
    '',
    0,
    0,
    0,
    0,
    0,
    0,
    0,
  );

  //CHOOSE SKILL

  List<PlayerAction> skills = [
    PlayerAction(
        'matterMorph',
        'MATTERMORPH',
        'You affect the environment around you and change it\'s physical properties.',
        [
          Option(
              'BRIGHTNESS',
              'You control the brightness of the environment around you, making it bright or dark.',
              'You control the brightness of a large area around you.',
              'You control the brightness of a medium area around you.',
              'You fail and something bad happens.',
              '',
              0),
          Option(
              'HARDNESS',
              'You control the hardness of things around you, making them hard or soft.',
              'You make things in a medium area around you hard or soft.',
              'You make things in a small area around you hard or soft.',
              'You fail and something bad happens.',
              '',
              0),
          Option(
              'FRICTION',
              'You control the friction of everything around you, making them very sticky or slippery.',
              'You make things in a medium area around you slippery or sticky.',
              'You make things in a small area around you slippery or sticky.',
              'You fail and something bad happens.',
              '',
              0)
        ],
        0,
        true),
    PlayerAction(
        'illusion',
        'ILLUSION',
        'You create an illusion that tricks people\'s senses. Making them see, hear, smell, taste or feel things that are not there.',
        [
          Option(
              'ILLUSION',
              'You create smells, tastes, sounds, images, or pretty much anything that affect people\'s senses.',
              'You You trick people\'s senses in a large area around you. Choose two senses.',
              'You You trick people\'s senses in a medium area around you. Choose one sense.',
              'You fail and something bad happens.',
              '',
              0),
        ],
        0,
        true),
    PlayerAction(
        'alchemy',
        'ALCHEMY',
        'You throw a mixture that splashes on contact and causes different effects.',
        [
          Option(
              'SMOKE',
              'It creates a cloud of thick smoke around the impact area.',
              'It creates a large cloud of thick smoke.',
              'It creates a medium cloud of thick smoke.',
              'You fail and something bad happens.',
              '',
              0),
          Option(
              'ICE',
              'It splashes around the impact point and freezes anything that it touches.',
              'It freezes everything in a medium area.',
              'It freezes everything in a small area.',
              'You fail and something bad happens.',
              '',
              0),
          Option(
              'FIRE',
              'It explodes on impact and sets fire to anything that it touches.',
              'It deals',
              '',
              'You fail and something bad happens.',
              'DAMAGE',
              0)
        ],
        0,
        false),
    PlayerAction(
        'callOfNature',
        'NATURE\'S CALL',
        'You call for help and nature comes to your aid. It follows your command, but may ask for something in return.',
        [
          Option(
              'ATTACK',
              'You mark a target and nature strikes it.',
              'It deals',
              '',
              'It fails and something bad happens.',
              'DAMAGE',
              0),
          Option(
              'DEFEND',
              'You mark a target and nature defends it.',
              'It protects',
              '',
              'Nature fails and it takes damage.',
              'PROTECT',
              0),
          Option(
              'SCOUT',
              'You ask nature for some information about a specific area.',
              'You receive meaningful information.',
              'You get information, but nature asks for something in return.',
              'You receive bad news.',
              '',
              0),
        ],
        0,
        false),
    PlayerAction(
        'faceshifter',
        'FACESHIFTER',
        'You transform into a person of your choice, taking their voice and appearance.',
        [
          Option(
              'TRANSFORM',
              'The transformation varies in strength depending on your luck.',
              'The transformation is a success.',
              'The transformation is incomplete and your voice remains the same.',
              'The transformation fails and something bad happens.',
              '',
              0)
        ],
        0,
        true),
    PlayerAction(
        'alterSenses',
        'ALTER SENSES',
        'You can bless or curse anyone you touch. Enhancing or taking away their senses.',
        [
          Option(
              'ENHANCE',
              'You enhance someone, allowing them to perform incredible feats. Like seeing through walls, hearing whispers from far away or tracking a scent.',
              'You enhance two of their senses.',
              'You enhance one of their senses.',
              'You fail and something bad happens.',
              '',
              0),
          Option(
              'REMOVE',
              'You curse someone and remove some of their senses. Making them blind, deaf, or numb. ',
              'You remove two of their senses.',
              'You remove one of their senses.',
              'You fail and something bad happens.',
              '',
              0)
        ],
        0,
        true),

    //OLD SKILLS

    //PlayerAction('callOfNature', 'CALL OF NATURE', 'You call for help and nature comes to your aid. It follows your command, but may ask for something in return.',[Option('ATTACK','You mark a target and nature strikes anyway it can.','Nature strikes your target with full force.', 'Nature strikes the target.', 'Nature fails and something bad happens.'), Option('DEFEND','You call for help and nature protects you any way it can.a wind to blow your enemies away, vines to hold them down, branches to block their attacks, etc.','Nature protects the target from the attack. Roll to see how much it protects.','Nature gets just in time to block part of the attack. Roll to see how much it protects.','It doesn\'t protect the target in time and something bad happens.' ), Option('SCOUT','You call birds to scout an area, mice to find an exit, snakes to scene a threat, etc.','You get meaningful information.','You get meaningful information, but nature asks for retribution.', 'You uncover an ugly truth.'),],0),
    //PlayerAction('alchemy', 'ALCHEMY', 'You throw a mixture that splashes on contact and causes different effects.',[Option('OIL','It makes the surface slippery and flammable.','You splash a medium area with a flammable fluid, making it slippery.', 'You splash a small area with a flammable fluid, making it slippery.','You miss the target and something bad happens.'), Option('SMOKE','It creates a cloud of thick smoke that blocks vision.','It makes a large cloud of thick smoke around the impact area.', 'It makes a medium cloud of thick smoke around the impact area.', 'You miss the target and something bad happens.'), Option('ICE','It freezes anything it touches.','You freeze a medium area around the impact point.', 'You freeze a small area around the impact point.', 'You miss and something bad happens.'), Option('FIRE','It explodes on impact and sets fire to anything near by.','It explodes on impact, setting fire to a medium area. Roll your damage.', 'It explodes on impact, setting fire to a small area. Roll your damage.', 'You miss and something bad happens.')],0),
    //PlayerAction('controlOverMatter', 'CONTROL OVER MATTER', 'You change the environment around you, changing it\'s physical properties.',[Option(0,'BRIGHTNESS','You make the environment around you bright or dark.',), Option(1,'HARDNESS','You make the things around you soft, hard or liquid.',), Option(2,'FRICTION','You make things around you slippery or sticky.',), Option(3,'VISIBILITY','You make things around you appear or disappear.',)],0),
    //PlayerAction('illusion', 'ILLUSION', 'You create an illusion that tricks people\'s senses. It requires focus.',[Option(0,'SOUND','You create sounds, noises, voices and music.',), Option(1,'SMELL','You create smells, scents, perfumes, etc.',), Option(2,'VISION','You create figures, shadows, animals, objects, etc.',), Option(3,'TASTE','You make them taste what you want.',), Option(4,'TOUCH','You make them feel any physical sensation, like warmth, cold, pain, pressure, etc.',)],0),
    //PlayerAction('alterSenses', 'ALTER SENSES', 'You can bless or curse anyone you touch. Enhancing or taking away their senses.',[Option(0,'SOUND','ENHANCE - They can hear things from further away, through walls, etc.\nREMOVE - You make them deaf.',), Option(1,'SMELL','ENHANCE - They can smell things from further away, track a scent, detect poisons, etc. \nREMOVE - You remove their sense of smell.',), Option(2,'VISION','ENHANCE - They can see things that are further away, in the dark, through walls, etc. \nREMOVE - You make them blind.',), Option(3,'TASTE','ENHANCE - They can distinguish the smallest variations in the things they taste. Like age, ingredients, where it\'s been, etc. \nREMOVE - You change or remove their sense of taste.',), Option(4,'TOUCH','ENHANCE - They feel the slightest changes in their environment, like vibrations, temperature, wind, etc. \nREMOVE - You make them numb and take away their pain.',)],0),

    //PlayerSkill(1,'skill','MATTER CONTROL', 'INT', 'You control the environment around you, changing it’s physical properties.',[Option(0,'BRIGHTNESS','Making it shiny bright or complete darkness.','INT'),Option(1,'HARDNESS','Making it soft, hard, or liquid.','INT',),Option(2,'FRICTION','Making it adherent of frictionless.','INT',),Option(3,'VISIBILITY','Making it visible or invisible.','INT'),], true,),
    //PlayerSkill(2,'skill','ILLUSION', 'INT', 'You create an illusion that tricks people’s senses.',[Option(0,'SIGHT','Making them see or not see things.','INT'),Option(1,'HEARING','Making them hear or not hear things.','INT',),Option(2,'SMELL','Smell or not smell things.','INT',),Option(3,'TOUCH','Touch things that don\'t exist.','INT'),], true,),
    //PlayerSkill(3,'skill','ALCHEMY', 'INT', 'Your create a toxin that can causes different effects.',[Option(0,'CHARM','Making the person follow your orders.','INT'),Option(1,'SLEEP','Making them fall asleep.','INT',),Option(2,'HEAL','Healing them for 1D6 HP.','INT',),Option(3,'DAMAGE','Damaging them for 1D6 HP.','INT'),], false,),
    //PlayerSkill(4,'skill','CALL OF NATURE', 'WIS', 'Nature follows your command.',[Option(0,'ATTACK','It attacks the target.','WIS'),Option(1,'DEFEND','It defends the target.','WIS',),Option(2,'ASSIST','It helps the target with the task at hand.','WIS',),Option(3,'SCOUT','It scouts the area and reports back with useful information.','WIS'),], true,),
    //PlayerSkill(5,'skill','FACESHIFTER', 'CHA', 'You take the appearance of a person you see or remember.',[], false,),
    //PlayerSkill(6,'skill','ALTER SENSES', 'WIS', 'You can affect peoples senses, enhancing or taking them away.',[Option(0,'SIGHT','Make them blind, see through walls, x-ray, etc.','WIS'),Option(1,'HEARING','Make them deaf, sense microwaves, understand different languages, etc.','CON',),Option(2,'TOUCH','Make them unable to move or run faster, etc.','WIS',),Option(3,'VOICE','Make them mute or sing better, shot louder, etc.','WIS'),], true,),
    //PlayerSkill(1,'skill','METAMORPHOSIS', 'CON', 'You transform into a creature of your choice.',[Option(0,'DAMAGE','You receive a bonus of +2 to your damage.','CON'),Option(1,'ARMOR','You receive a bonus of +2 to your armor.','CON',),Option(2,'ABILITY','You receive an ability that matches your new form.','CON',),Option(3,'ATTRIBUTE','You receive a bonus of +1 to the attribute of your choice.','CON'),], false,),
    //PlayerSkill(2,'skill','REGENERATION', 'CON', 'You gain the ability to regenerate.',[Option(0,'REGENERATE','You close your wounds and grow lost limbs. Heal 2D6 HP.','CON')], false,),
    //PlayerSkill(3,'skill','WAR CRY', 'CON', 'Your shouts roar through the battlefield.',[Option(0,'FEAR','You frightened your enemies and they run away.','CON'),Option(1,'TAUNT','You taunt your enemies and they run towards you.','CON',),Option(2,'STOP','Your shout makes your enemies stop.','CON',),Option(3,'DAMAGE','You receive a bonus of +2 to your damage.','CON'),], false,),
    //PlayerSkill(5,'skill','HOLY BLADE', 'WIS', '',[], false,),
    //PlayerSkill(11,'skill','WHISPER', 'CHA', 'Your whispers allow you to affect people’s thoughts.',[Option(0,'DREAMS','You enter their dreams.','CHA'),Option(1,'MEMORY','You change their memory by adding, changing or removing something.','CHA',),Option(2,'OBJECTIVE','You change their immediate objectives.','CHA',),Option(3,'BELIEFS','You change their belief in something or someone.','CHA'),], true,),
    //PlayerSkill(12,'skill','PERFORM', 'CHA', 'Your performance inspire your allies, making them better.',[Option(0,'DAMAGE','They receive a bonus of +2 to their damage.','CHA'),Option(1,'ATTRIBUTE','You receive a bonus of +1 to the attribute of your choice.','CHA',),Option(2,'WAKE UP','They wake up and recover from any mental state.','CHA',),Option(3,'DEFENCE','They receive a bonus of +1 to their armor.','CHA'),], true,),
  ];

  PlayerAction playerSkill = PlayerAction(
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
      false);

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
              'You miss and open your guard.',
              'DAMAGE',
              0),
          Option(
              'WEAPON',
              'You attack the target with your weapon, trying to bring them down.',
              'You deal',
              '',
              'You miss and open your guard.',
              'DAMAGE',
              0)
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
        'You jump, climb, dodge, hide, or escape from danger.',
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
    this.playerSkill = skills[index];
    this.playerAction[6] = this.playerSkill;

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
      element.value = this.mDamage;
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
        element.value = this.mDamage;
      });

      this.inventory.add(item);
      this.mainHandEquip = Item(
        'mainHand',
        '',
        '',
        '',
        '',
        0,
        0,
        0,
        0,
        0,
        0,
        0,
      );

      this.offHandEquip = Item(
        'offHand',
        '',
        '',
        '',
        '',
        0,
        0,
        0,
        0,
        0,
        0,
        0,
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
      element.value = this.mDamage;
    });

    this.inventory.add(item);

    switch (item.inventorySpace) {
      case 'head':
        {
          this.headEquip = Item(
            'head',
            '',
            '',
            '',
            '',
            0,
            0,
            0,
            0,
            0,
            0,
            0,
          );
        }
        break;
      case 'hands':
        {
          this.handsEquip = Item(
            'hands',
            '',
            '',
            '',
            '',
            0,
            0,
            0,
            0,
            0,
            0,
            0,
          );
        }
        break;
      case 'body':
        {
          this.bodyEquip = Item(
            'body',
            '',
            '',
            '',
            '',
            0,
            0,
            0,
            0,
            0,
            0,
            0,
          );
        }
        break;
      case 'feet':
        {
          this.feetEquip = Item(
            'feet',
            '',
            '',
            '',
            '',
            0,
            0,
            0,
            0,
            0,
            0,
            0,
          );
        }
        break;

      case '1hand':
        {
          if (item == this.mainHandEquip) {
            this.mainHandEquip = Item(
              'mainHand',
              '',
              '',
              '',
              '',
              0,
              0,
              0,
              0,
              0,
              0,
              0,
            );
          } else {
            this.offHandEquip = Item(
              'offHand',
              '',
              '',
              '',
              '',
              0,
              0,
              0,
              0,
              0,
              0,
              0,
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
          2));
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

  List<Item> inventory = [];

  List<Effect> effectList = [];

  Player(this.playerColor);

  void setColor(PlayerColor playerColor) {
    this.playerColor = playerColor;
  }
}
