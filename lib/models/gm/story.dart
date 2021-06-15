import 'package:dsixv02app/models/gm/quest.dart';
import 'package:dsixv02app/models/shared/exceptions.dart';
import 'situation.dart';
import 'situationList.dart';
import 'storySettings.dart';
import 'storySettingsList.dart';

class Story {
//SETTING

  StorySettings settings = StorySettings(
    icon: 'normal',
    name: 'NORMAL',
    description: 'Normal.',
    numberOfQuests: 3,
    questXp: 50,
    totalXp: 50,
    questGold: 100,
    totalGold: 100,
  );
  List<StorySettings> storySettingsList = settingsList;

  int currentSetting = 2;
  void chooseDifficulty(int value) {
    if (currentSetting + value == storySettingsList.length ||
        currentSetting + value < 0) {
      return;
    }
    this.currentSetting += value;
    this.settings = this.storySettingsList[currentSetting];
  }

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
    reward: '-',
    onGoing: false,
  );

  void deleteStory() {
    this.round = 0;
    this.settings = this.storySettingsList[2];
    this.questList = [];
    this.finishedQuests = [];
    this.situationList = [];
  }

  int round = 0;
  void newStory() {
    this.round = 1;
//NUMBER OF SITUATIONS
    for (int i = 0; i < 2; i++) {
      newSituation();
    }

//NUMBER OF QUESTS
    for (int i = 0; i < this.settings.numberOfQuests; i++) {
      newRandomQuest();
    }
    this.quest = questList.first;
    throw new NewStoryException();
  }

  void newRandomQuest() {
    this.questList.add(quest.newRandomQuest());
    this.quest = this.questList.last;
  }

  void selectQuest(int index) {
    this.quest = questList[index];
  }

  void acceptQuest() {
    this.questList.removeWhere((element) => element != this.quest);
    this.quest.onGoing = true;
  }

  void deleteQuest() {
    questList.remove(this.quest);
    if (questList.isNotEmpty) {
      this.quest = this.questList.last;
    }
    this.quest = this.quest.newQuest();
  }

  void finishQuest() {
    this.finishedQuests.add(questList[0]);
    this.questList.clear();
    this.quest = this.quest.newQuest();
  }

  void newRound() {
    if (this.quest.onGoing) {
      throw new OnGoingQuestException();
    }
    if (this.questList.isNotEmpty) {
      throw new OnGoingQuestException();
    }
    this.round++;

    int incGold = 0;
    int incXp = 0;

    incGold = this.settings.questGold * this.round;
    incXp = this.settings.questXp * this.round;

    this.settings.totalGold = incGold;
    this.settings.totalXp = incXp;

    //ADD SITUATION

    newSituation();

    //ADD QUEST

    for (int i = 0; i < this.settings.numberOfQuests; i++) {
      newRandomQuest();
    }
    this.quest = questList.first;
  }

  Story();
}
