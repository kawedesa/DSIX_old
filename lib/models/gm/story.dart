import 'package:dsixv02app/models/gm/location.dart';
import 'package:dsixv02app/models/gm/quest.dart';
import 'situation.dart';
import 'situationList.dart';
import 'storySettings.dart';
import 'storySettingsList.dart';

class Story {
//SETTING

  StorySettings settings = StorySettings().defaultSettings();

  List<StorySettings> storySettingsList = settingsList;

//QUEST

  List<Quest> finishedQuests = [];

  List<Quest> questList = [];
  Quest quest = new Quest(
    onGoing: false,
  );

  void deleteStory() {
    this.round = 0;
    this.settings = this.settings.defaultSettings();
    this.quest = Quest(
      onGoing: false,
    );
    this.storyPageIndex = 0;
    this.questList = [];
    this.finishedQuests = [];
  }

  //NEW STORY

  int round = 0;
  void newStory(int players) {
    this.round = 1;
    this.storyPageIndex = 1;
    newQuest(players);
  }

  int storyPageIndex = 0;
  void newQuest(int players) {
    questList = [];

    for (int i = 0; i < this.settings.numberOfQuests; i++) {
      this.questList.add(quest.newRandomQuest(this.settings.questXp * players));
    }
    this.quest = this.questList.last;
  }

  void chooseQuest(int index) {
    this.quest = questList[index];
    this.quest.newSituation();
  }

  void startQuest() {
    this.quest.onGoing = true;
  }

  void finishQuest() {
    this.finishedQuests.add(this.quest);
    this.questList.clear();
    this.quest.onGoing = false;
    this.storyPageIndex = 2;
  }

  void newRound(int players) {
    this.round++;

    this.settings.questGold = this.settings.addGold * round;
    this.settings.questXp = this.settings.addXp * round;

    this.storyPageIndex = 1;
    //ADD QUEST
    newQuest(players);
  }

  Story();
}
