import 'dart:math';
import 'package:dsixv02app/models/gm/character.dart';
import 'package:dsixv02app/models/gm/location.dart';

import 'locationList.dart';

class Quest {
  String icon = 'quest';
  String name = 'NEW QUEST';
  String questDescription =
      'Each quest should be unique, with their backstory. Double tap the text to edit it and write your own story.';
  String character = '-';
  String objective = '-';
  String target = '-';
  String location = '-';
  String threat = '-';
  List<Character> threatList = [];

  bool onGoing = false;

  LocationList locations = LocationList();

  // List<String> characterList = [
  //   'Human',
  //   'Dwarf',
  //   'Orc',
  //   'Elf',
  //   'Dark elf',
  //   'Goblin',
  //   'Gnome',
  //   'Halfling',
  //   // 'Beast',
  // ];

  // List<String> genderList = [
  //   'Female',
  //   'Male',
  // ];

  List<String> backgroundList = [
    'Merchant',
    'Nobleman',
    'Soldier',
    'Student',
    'Traveler',
    'Worker',
    'Wizzard',
    // 'Merchant',
    // 'Noble',
    // 'Spy',
    // 'Prisoner',
    // 'Pirate',
    // 'Medic',
    // 'Worker',
    // 'Chef',
    // 'Mercenary',
    // 'Detective',
    // 'Artist',
    // 'Wizard',
    // 'Student',
    // 'Traveler',
    // 'Hunter',
    // 'Assassin',
    // 'Thief',
    // 'Scientist',
    // 'Lawyer',
    // 'Farmer',
    // 'Tailor',
    // 'Gladiator',
    // 'Sailor',
    // 'Innkeeper',
    // 'Stablehand',
    // 'Soldier',
    // 'Politician',
    // 'Bureaucrat',
    // 'Shaman',
    // 'Homeless',
    // 'Knight',
    // 'Monk',
    // 'Gardener',
  ];

  List<String> objectiveList = [
    'Capture',
    'Control',
    'Destroy',
    'Hunt',
    'Kill',
    'Protect',
    'Save',
    'Steal',

    // 'Hunt',
    // 'Destroy',
    // 'Deliver',
    // 'Steal',
    // 'Capture',
    // 'Find',
    // 'Protect',
    // 'Save',
    // 'Learn',
    // 'Avenge',
    // 'Control',
    // 'Report',
    // 'Fight',

    // 'Create',
    // 'Flee',
    // 'Gather',
    // 'Spread',
    // 'Win',
    // 'Perform',
    // 'Solve',
    // 'Organize',
    // 'Investigate',
  ];

  // List<String> locationList = [
  //   'Arena',
  //   // 'Bar',
  //   'Ruins',
  //   'Fort',
  //   // 'Library',
  //   // 'Jail',
  //   // 'Ship',
  //   'Sewers',
  //   'Cemitery',
  //   'Farm',
  //   'Mine',
  //   // 'Market',
  //   'Wilderness',
  //   // 'Factory',
  //   // 'Caravan',
  //   // 'Slum',
  //   // 'Cassino',
  //   // 'Bank',
  //   // 'Port',
  //   // 'Court',
  //   'Cave',
  // ];

  List<String> rewardList = [
    'GOLD',
    'ITEM',
    // 'Information',
    'RESOURCES',
    'FAME',
    // 'Favor',
  ];

  Quest newQuest() {
    Quest newQuest = new Quest(
      icon: 'quest',
      name: 'NEW QUEST',
      questDescription:
          'Each quest should feel unique and have a different backstory. Double tap this text to edit the description and write your own story.',
      character: '-',
      objective: '-',
      target: '-',
      location: '-',
      onGoing: false,
    );
    return newQuest;
  }

  List<Character> spawnCharacters(int xp, Location location) {
    List<Character> characterList = [];
    List<Character> possibleCharacters = [];

//NARROW THE SEARCH

    while (possibleCharacters.length < 3) {
      Character randomCharacter = location.possibleCharacters[
              Random().nextInt(location.possibleCharacters.length)]
          .newCharacter();

      if (possibleCharacters.isEmpty) {
        if (randomCharacter.baseXp <= 50) {
          possibleCharacters.add(randomCharacter);
        }
      }
      if (possibleCharacters.isNotEmpty) {
        if (randomCharacter.baseXp > 50) {
          possibleCharacters.add(randomCharacter);
        }
      }
    }

//ADD THE CHARACTER TO THE LIST

    bool check = true;

    while (xp > 0) {
      check = true;
      Character randomCharacter =
          possibleCharacters[Random().nextInt(possibleCharacters.length)]
              .newCharacter();

      //Check random character XP
      if (randomCharacter.baseXp <= xp) {
        //Check to see if it's the first character to be added
        if (characterList.isEmpty) {
          randomCharacter.totalXp = randomCharacter.baseXp;
          randomCharacter.totalLoot = (randomCharacter.baseLoot).toInt();
          randomCharacter.maxHealth = randomCharacter.baseHealth;
          randomCharacter.currentHealth = randomCharacter.maxHealth;
          characterList.add(randomCharacter);
          xp -= randomCharacter.baseXp;
        } else {
          //Loop to see if the character already exists and I can put more of them together on the same pack
          while (check) {
            characterList.forEach((element) {
              if (element.name == randomCharacter.name &&
                  element.totalXp < 100) {
                element.amount++;
                //change Health
                element.maxHealth += randomCharacter.baseHealth;
                element.currentHealth = element.maxHealth;
                //change Xp
                element.totalXp += randomCharacter.baseXp;
                //change Loot
                element.totalLoot = (element.baseLoot * element.amount).toInt();
                xp -= randomCharacter.baseXp;
                check = false;
              }
            });
            if (check) {
              //Add new character if it's not equal to any other character
              randomCharacter.totalXp = randomCharacter.baseXp;
              randomCharacter.totalLoot = (randomCharacter.baseLoot).toInt();
              randomCharacter.maxHealth = randomCharacter.baseHealth;
              randomCharacter.currentHealth = randomCharacter.maxHealth;
              characterList.add(randomCharacter);
              xp -= randomCharacter.baseXp;
              check = false;
            } //If
          } //While
        }
      }
    }

    return characterList;
  }

  Quest newRandomQuest(int xp) {
    Location randomLocation =
        locations.locations[Random().nextInt(locations.locations.length)];

    List<Character> randomThreat = [];

    randomThreat = spawnCharacters(xp, randomLocation);

    String randomCharacter =
        '${backgroundList[Random().nextInt(backgroundList.length)]}';
    String randomObjective =
        '${objectiveList[Random().nextInt(objectiveList.length)]}';

    String randomTarget;

    switch (randomObjective) {
      case 'Capture':
        {
          int XP = 0;
          randomThreat.forEach((element) {
            if (element.totalXp > XP) {
              XP = element.totalXp;
              randomTarget = element.name;
            }
          });
        }
        break;
      case 'Control':
        {
          List<String> possibleTarget = [
            'Camp',
            'Tomb',
            'Outpost',
            'Fort',
            'Altar',
            'Machine',
          ];
          randomTarget =
              possibleTarget[Random().nextInt(possibleTarget.length)];
        }
        break;
      case 'Destroy':
        {
          List<String> possibleTarget = [
            'Item',
            'Bridge',
            'Wall',
            'Altar',
            'Evidence',
            'Machine',
          ];
          randomTarget =
              possibleTarget[Random().nextInt(possibleTarget.length)];
        }
        break;
      case 'Hunt':
        {
          int XP = 0;
          randomThreat.forEach((element) {
            if (element.totalXp > XP) {
              XP = element.totalXp;
              randomTarget = element.name;
            }
          });
        }
        break;
      case 'Kill':
        {
          int XP = 0;
          randomThreat.forEach((element) {
            if (element.totalXp > XP) {
              XP = element.totalXp;
              randomTarget = element.name;
            }
          });
        }
        break;
      case 'Protect':
        {
          randomTarget =
              backgroundList[Random().nextInt(backgroundList.length)];
        }
        break;
      case 'Save':
        {
          randomTarget =
              backgroundList[Random().nextInt(backgroundList.length)];
        }
        break;
      case 'Steal':
        {
          List<String> possibleTarget = [
            'Item',
            'Creature',
            'Weapon',
            'Tool',
            'Technology',
            'Equipment',
          ];

          randomTarget =
              possibleTarget[Random().nextInt(possibleTarget.length)];
        }
        break;
    }

    // String randomTarget = (target == 'Person')
    //     ? '${backgroundList[Random().nextInt(backgroundList.length)]}'
    //     : 'Group of ${backgroundList[Random().nextInt(backgroundList.length)]}s';

    Quest newRandomQuest = new Quest(
      icon: 'quest',
      name: randomObjective,
      questDescription:
          '$randomObjective a $randomTarget at the ${randomLocation.name}.',
      character: randomCharacter,
      objective: randomObjective,
      target: randomTarget,
      location: randomLocation.name,
      threat: randomThreat.last.name,
      threatList: randomThreat,
      onGoing: false,
    );
    return newRandomQuest;
  }

  Quest({
    String icon,
    String name,
    String questDescription,
    String character,
    String objective,
    String target,
    String location,
    String threat,
    List<Character> threatList,
    bool onGoing,
  }) {
    this.icon = icon;
    this.name = name;
    this.questDescription = questDescription;
    this.character = character;
    this.objective = objective;
    this.target = target;
    this.location = location;
    this.threat = threat;
    this.threatList = threatList;
    this.onGoing = onGoing;
  }
}
