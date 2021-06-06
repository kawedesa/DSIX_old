import 'dart:math';

class Quest {
  String icon = 'quest';
  String name = 'NEW QUEST';
  String questDescription =
      'Each quest should be unique, with their backstory. Double tap the text to edit it and write your own story.';
  String objective = '-';
  String target = '-';
  String location = '-';
  String reward = '-';
  int questXP;
  int questGold;
  int questFame;
  bool onGoing = false;

  List<String> characterList = [
    'Human',
    'Dwarf',
    'Orc',
    'Elf',
    'Dark elf',
    'Goblin',
    'Gnome',
    'Halfling',
    // 'Beast',
  ];

  List<String> genderList = [
    'Female',
    'Male',
  ];

  List<String> backgroundList = [
    'Merchant',
    'Noble',
    'Spy',
    'Prisoner',
    'Pirate',
    'Medic',
    'Worker',
    'Chef',
    'Mercenary',
    'Detective',
    'Artist',
    'Wizard',
    'Student',
    'Traveler',
    'Hunter',
    'Assassin',
    'Thief',
    'Scientist',
    'Lawyer',
    'Farmer',
    'Tailor',
    'Gladiator',
    'Sailor',
    'Innkeeper',
    'Stablehand',
    'Soldier',
    'Politician',
    'Bureaucrat',
    'Shaman',
    'Homeless',
    'Knight',
    'Monk',
    'Gardener',
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

  List<String> targetList = [
    'Person',
    'Beast',
    'Insect',
    'Group',
    'Machine',
    'Place',
    'Item',
  ];

  List<String> locationList = [
    'Arena',
    'Bar',
    'Ruins',
    'Fort',
    'Library',
    'Jail',
    'Ship',
    'Sewers',
    'Cemitery',
    'Farm',
    'Mine',
    'Market',
    'Wilderness',
    'Factory',
    'Caravan',
    'Slum',
    'Cassino',
    'Bank',
    'Port',
    'Court',
    'Cave',
  ];

  List<String> rewardList = [
    'Gold',
    'Item',
    'Information',
    'Resources',
    'Fame',
    'Favor',
  ];

  Quest newQuest() {
    Quest newQuest = new Quest(
      icon: 'quest',
      name: 'NEW QUEST',
      questDescription:
          'Each quest should feel unique and have a different backstory. Double tap this text to edit the description and write your own story.',
      objective: '-',
      target: '-',
      location: '-',
      reward: '-',
    );
    return newQuest;
  }

  Quest newRandomQuest() {
    String randomObjective =
        '${objectiveList[Random().nextInt(objectiveList.length)]}';
    String randomTarget = (target == 'Person')
        ? '${characterList[Random().nextInt(characterList.length)]} ${backgroundList[Random().nextInt(backgroundList.length)]}'
        : 'Group of ${backgroundList[Random().nextInt(backgroundList.length)]} ${characterList[Random().nextInt(characterList.length)]}s';
    String randomLocation =
        '${locationList[Random().nextInt(locationList.length)]}';
    String randomReward = '${rewardList[Random().nextInt(rewardList.length)]}';

    Quest newRandomQuest = new Quest(
      icon: 'quest',
      name: randomObjective,
      questDescription:
          '$randomObjective a $randomTarget at the $randomLocation and you will get $randomReward.',
      objective: randomObjective,
      target: randomTarget,
      location: randomLocation,
      reward: randomReward,
    );
    return newRandomQuest;
  }

  void chooseQuest(String category) {
    switch (category) {
      case 'objective':
        this.objective = objectiveList[Random().nextInt(objectiveList.length)];
        break;

      case 'target':
        this.target = targetList[Random().nextInt(targetList.length)];
        if (target == 'Person') {
          this.target =
              '${characterList[Random().nextInt(characterList.length)]} ${backgroundList[Random().nextInt(backgroundList.length)]}';
        } else if (target == 'Group') {
          this.target =
              'Group of ${characterList[Random().nextInt(characterList.length)]} \n${backgroundList[Random().nextInt(backgroundList.length)]}s';
        }

        break;

      case 'location':
        this.location = locationList[Random().nextInt(locationList.length)];
        break;

      case 'reward':
        this.reward = rewardList[Random().nextInt(rewardList.length)];
        break;
    }
  }

  Quest({
    String icon,
    String name,
    String questDescription,
    String objective,
    String target,
    String location,
    String reward,
  }) {
    this.icon = icon;
    this.name = name;
    this.questDescription = questDescription;
    this.objective = objective;
    this.target = target;
    this.location = location;
    this.reward = reward;
  }
}
