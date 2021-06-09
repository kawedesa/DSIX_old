import 'package:dsixv02app/models/gm/quest.dart';

import 'storySettings.dart';
import 'storySettingsList.dart';

class Story {
//SETTING

  StorySettings settings = StorySettings(
    icon: 'normal',
    name: 'NORMAL',
    description: 'Normal.',
    fame: 1,
    numberOfQuests: 2,
    questXp: 50,
    questGold: 100,
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

//QUEST

  List<Quest> questList = [];
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

  int round = 0;
  void newStory() {
    this.round = 1;
    newRandomQuest();
    this.newQuest = questList.first;
  }

  void newRandomQuest() {
    for (int i = 0; i < this.settings.numberOfQuests; i++) {
      this.questList.add(newQuest.newRandomQuest());
    }
  }

  void selectQuest(int index) {
    this.newQuest = questList[index];
  }

  void acceptQuest() {
    this.questList.removeWhere((element) => element != this.newQuest);
    this.newQuest.onGoing = true;
  }

  void cancelQuest() {
    questList.remove(this.newQuest);
  }

  void finishQuest() {
    questList.clear();
    newRound();
  }

  void newRound() {
    this.round++;
    this.settings.questGold *= round;
    this.settings.questXp *= round;
    newRandomQuest();
    this.newQuest = questList.first;
  }

  Story();
}
