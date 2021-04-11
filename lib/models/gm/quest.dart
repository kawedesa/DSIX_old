import 'dart:math';

class Quest {
  String icon = 'quest';
  String name = 'NEW QUEST';
  String questDescription =
      'Each quest should be unique, with their backstory. Double tap the text to edit it and write your own story.';
  String character = '-';
  String background = '-';
  String personality = '-';
  String characterDescription = '-';
  String objective = '-';
  String target = '-';
  String location = '-';
  String reward = '-';

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

  List<String> personalityList = [
    'Brave',
    'Clever',
    'Coward',
    'Friendly',
    'Generous',
    'Grumpy',
    'Honest',
    'Kind',
    'Lazy',
    'Nervous',
    'Popular',
    'Selfish',
    'Serious',
    'Shy',
    'Stupid',
    'Vain',
    'Religious',
    'Proud',
    'Flamboyant',
    'Stubborn',
    'Obsessed',
    'Greedy',
    'Calm',
    'Slow',
  ];

  List<String> characterDescriptionList = [
    'Smelly',
    'Old',
    'Ugly',
    'Weird',
    'Sick',
    'Weak',
    'Strong',
    'Hairy',
    'Mute',
    'Young',
    'Blind',
    'Pale',
    'Tall',
    'Short',
    'Deaf',
    'Bald',
    'Fit',
    'Fat',
    'Gorgeous',
    'Skinny',
    'Tattooed',
    'Unkempt',
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

  void chooseQuest(String category) {
    switch (category) {
      case 'character':
        this.character =
            '${genderList[Random().nextInt(genderList.length)]} ${characterList[Random().nextInt(characterList.length)]}';
        break;

      case 'background':
        this.background =
            backgroundList[Random().nextInt(backgroundList.length)];
        break;

      case 'personality':
        this.personality =
            personalityList[Random().nextInt(personalityList.length)];
        break;

      case 'characterDescription':
        this.characterDescription = characterDescriptionList[
            Random().nextInt(characterDescriptionList.length)];
        break;

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
    String character,
    String background,
    String personality,
    String characterDescription,
    String objective,
    String target,
    String location,
    String reward,
  }) {
    this.icon = icon;
    this.name = name;
    this.questDescription = questDescription;
    this.character = character;
    this.background = background;
    this.personality = personality;
    this.characterDescription = characterDescription;
    this.objective = objective;
    this.target = target;
    this.location = location;
    this.reward = reward;
  }
}
