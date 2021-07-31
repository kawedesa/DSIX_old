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
    // 'Merchant',
    // 'Noble',
    // 'Spy',
    'Prisoner',
    // 'Pirate',
    'Medic',
    'Worker',
    // 'Chef',
    'Mercenary',
    // 'Detective',
    // 'Artist',
    'Wizard',
    'Student',
    'Traveler',
    'Hunter',
    'Assassin',
    'Thief',
    // 'Scientist',
    // 'Lawyer',
    // 'Farmer',
    // 'Tailor',
    'Gladiator',
    // 'Sailor',
    // 'Innkeeper',
    // 'Stablehand',
    'Soldier',
    // 'Politician',
    // 'Bureaucrat',
    'Shaman',
    // 'Homeless',
    // 'Knight',
    // 'Monk',
    // 'Gardener',
  ];

  List<String> objectiveList = [
    'Hunt',
    'Destroy',
    'Deliver',
    'Steal',
    'Capture',
    'Find',
    'Protect',
    'Save',
    'Learn',
    'Avenge',
    'Control',
    'Report',
    'Fight',

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

  Quest newRandomQuest(int xp) {
    Location randomLocation =
        locations.locations[Random().nextInt(locations.locations.length)];

    int totalXp = xp;

    List<Character> randomThreat = [];

    while (totalXp > 0) {
      Character randomCharacter = randomLocation
          .characters[Random().nextInt(randomLocation.characters.length)]
          .newCharacter();

      if (randomCharacter.baseXp <= totalXp) {
        randomCharacter.totalXp = randomCharacter.baseXp;
        randomCharacter.totalLoot = (randomCharacter.baseLoot).toInt();
        randomCharacter.maxHealth = randomCharacter.baseHealth;
        randomCharacter.currentHealth = randomCharacter.maxHealth;
        randomThreat.add(randomCharacter);
        totalXp -= randomCharacter.baseXp;
      }
    }

    String randomCharacter =
        '${backgroundList[Random().nextInt(backgroundList.length)]}';
    String randomObjective =
        '${objectiveList[Random().nextInt(objectiveList.length)]}';
    String randomTarget = (target == 'Person')
        ? '${backgroundList[Random().nextInt(backgroundList.length)]}'
        : 'Group of ${backgroundList[Random().nextInt(backgroundList.length)]}s';

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

  // void chooseQuest(String category) {
  //   switch (category) {
  //     case 'objective':
  //       this.objective = objectiveList[Random().nextInt(objectiveList.length)];
  //       break;

  //     case 'target':
  //       this.target = targetList[Random().nextInt(targetList.length)];
  //       if (target == 'Person') {
  //         this.target =
  //             '${backgroundList[Random().nextInt(backgroundList.length)]}';
  //       } else if (target == 'Group') {
  //         this.target =
  //             'Group of ${backgroundList[Random().nextInt(backgroundList.length)]}s';
  //       }

  //       break;

  //     case 'location':
  //       this.location = locationList[Random().nextInt(locationList.length)];
  //       break;
  //   }
  // }

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
