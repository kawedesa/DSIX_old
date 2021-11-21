import 'dart:math';

import 'package:dsixv02app/core/app_colors.dart';
import 'package:dsixv02app/models/dsix/dsix.dart';
import 'package:dsixv02app/models/gm/gm.dart';
import 'package:dsixv02app/models/gm/map/availableMaps.dart';
import 'package:dsixv02app/models/gm/quest/quest.dart';
import 'package:dsixv02app/models/gm/storySettings.dart';
import 'package:flutter/material.dart';

class GameModePageVM {
  // StorySettings storySettings = StorySettings().defaultSettings();

  int layout;

  // void newGame(Dsix dsix) {
  //   dsix.gm.round = 0;
  //   newRound(dsix);
  // }

  // Quest selectedQuest;

  // List<Quest> availableQuests = [];

  // void cancelQuest(Gm gm) {
  //   this.availableQuests = [];
  //   gm.quest = gm.quest.emptyQuest();
  // }

  void newBattleRoyaleGame(Dsix dsix) {
    dsix.gm.map = AvailableMaps.crossroads;

    double x = (Random().nextDouble() * 200);
    double y = 0;

    dsix.gm.navigation = TransformationController(
        Matrix4(1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 1, 0, -x, -y, 0, 1));

    dsix.gm.gameSelected = true;

    dsix.gm.buildCanvas();
  }

  // void startQuest(Dsix dsix) {
  //   dsix.gm.quest.questStart = true;

  //   double x = (Random().nextDouble() * 200);
  //   double y = 0;

  //   dsix.gm.navigation = TransformationController(
  //       Matrix4(1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 1, 0, -x, -y, 0, 1));

  //   dsix.gm.buildCanvas();
  // }

  // void finishQuest(Dsix dsix) {
  //   this.availableQuests = [];
  //   dsix.gm.quest = dsix.gm.quest.emptyQuest();
  // }

  // void newRound(Dsix dsix) {
  //   dsix.gm.newRound();
  //   setRoundXpAndGold(dsix);
  //   createNewQuest();
  // }

  // void setRoundXpAndGold(Dsix dsix) {
  //   dsix.gm.roundXp =
  //       dsix.gm.round * dsix.checkPlayers() * storySettings.questXp;
  //   dsix.gm.roundGold = dsix.gm.round * storySettings.questGold;
  //   dsix.gm.currentXp = dsix.gm.roundXp;
  // }

  // void createNewQuest() {
  //   this.availableQuests = [];
  //   Quest newQuest = Quest();

  //   while (this.availableQuests.length < 3) {
  //     newQuest = newQuest.newQuest();
  //     availableQuests.add(newQuest);
  //   }
  // }
}
