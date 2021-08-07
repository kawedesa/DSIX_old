import 'package:dsixv02app/models/gm/quest.dart';
import 'package:dsixv02app/models/shared/exceptions.dart';
import 'situation.dart';
import 'situationList.dart';
import 'storySettings.dart';
import 'storySettingsList.dart';

class Story {
//SETTING

  StorySettings settings = StorySettings().defaultSettings();

  List<StorySettings> storySettingsList = settingsList;

  // int currentSetting = 2;
  // void chooseDifficulty(int value) {
  //   if (currentSetting + value == storySettingsList.length ||
  //       currentSetting + value < 0) {
  //     return;
  //   }
  //   this.currentSetting += value;
  //   this.settings = this.storySettingsList[currentSetting];
  // }

//SITUATION

  Situation situation = Situation();

  SituationList possibleSituations = SituationList();

  List<Situation> situationList = [];

  void newSituation() {
    this.situation = this.possibleSituations.newRandomSituation();
    this.situationList.add(this.situation.copySituation());
  }

//QUEST

  List<Quest> finishedQuests = [];

  List<Quest> questList = [];
  Quest quest = new Quest(
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

  void deleteStory() {
    this.round = 0;
    this.settings = this.settings.defaultSettings();
    this.quest = this.quest.newQuest();
    this.questList = [];
    this.finishedQuests = [];
    this.situationList = [];
  }

  //NEW STORY

  int round = 0;
  void newStory(int players) {
    this.round = 1;
    newQuest(players);
  }

  void newQuest(int players) {
    questList = [];

    for (int i = 0; i < this.settings.numberOfQuests; i++) {
      this.questList.add(quest.newRandomQuest(this.settings.questXp * players));
    }
    this.quest = this.questList.last;
  }

  void chooseQuest(int index) {
    this.quest = questList[index];
  }

  void finishQuest() {
    this.finishedQuests.add(this.quest);
    this.questList.clear();
  }

  void newRound(int players) {
    this.round++;

    this.settings.questGold = this.settings.addGold * round;
    this.settings.questXp = this.settings.addXp * round;

    //ADD QUEST
    newQuest(players);
  }

  Story();
}
