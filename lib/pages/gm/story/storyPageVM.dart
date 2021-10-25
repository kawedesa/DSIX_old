import 'dart:math';

import 'package:dsixv02app/core/app_colors.dart';
import 'package:dsixv02app/models/dsix/dsix.dart';
import 'package:dsixv02app/models/gm/gm.dart';
import 'package:dsixv02app/models/gm/quest/quest.dart';
import 'package:dsixv02app/models/gm/storySettings.dart';
import 'package:flutter/material.dart';

class StoryPageVM {
  StorySettings storySettings = StorySettings().defaultSettings();

  int layout;

  void newGame(Dsix dsix) {
    dsix.gm.round = 0;
    newRound(dsix);
  }

  Quest selectedQuest;

  List<Quest> availableQuests = [];

  void cancelQuest(Gm gm) {
    this.availableQuests = [];
    gm.quest = gm.quest.emptyQuest();
  }

  void startQuest(Dsix dsix) {
    dsix.gm.quest.questStart = true;
    dsix.gm.gameCreationStep = 0;

    double x = ((Random().nextDouble() * 1200) / 5).roundToDouble() * 5;
    double y = ((Random().nextDouble() * 1200) / 5).roundToDouble() * 5;

    dsix.gm.startLocation = Offset(x, y);

    dsix.gm.buildCanvas();
  }

  void finishQuest(Dsix dsix) {
    this.availableQuests = [];
    dsix.gm.quest = dsix.gm.quest.emptyQuest();
  }

  void newRound(Dsix dsix) {
    dsix.gm.newRound();
    setRoundXpAndGold(dsix);
    createNewQuest();
  }

  void setRoundXpAndGold(Dsix dsix) {
    dsix.gm.roundXp =
        dsix.gm.round * dsix.checkPlayers() * storySettings.questXp;
    dsix.gm.roundGold = dsix.gm.round * storySettings.questGold;
    dsix.gm.currentXp = dsix.gm.roundXp;
  }

  void createNewQuest() {
    this.availableQuests = [];
    Quest newQuest = Quest();

    while (this.availableQuests.length < 3) {
      newQuest = newQuest.newQuest();
      availableQuests.add(newQuest);
    }
  }
}
