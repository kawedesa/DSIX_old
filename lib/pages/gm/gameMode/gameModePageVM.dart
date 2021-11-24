import 'dart:math';

import 'package:dsixv02app/core/app_colors.dart';
import 'package:dsixv02app/models/dsix/dsix.dart';
import 'package:dsixv02app/models/gm/gm.dart';
import 'package:dsixv02app/models/gm/map/availableMaps.dart';
import 'package:dsixv02app/models/gm/quest/quest.dart';
import 'package:dsixv02app/models/gm/storySettings.dart';
import 'package:dsixv02app/models/player/player.dart';
import 'package:dsixv02app/pages/gm/map/gmMapPageVM.dart';
import 'package:dsixv02app/pages/player/actionPoint/actionPointPageVM.dart';
import 'package:dsixv02app/pages/player/background/backgroundPageVM.dart';
import 'package:dsixv02app/pages/player/race/racePageVM.dart';
import 'package:dsixv02app/pages/player/skill/skillPageVM.dart';
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

  GmMapPageVM _gmMapPageVM = GmMapPageVM();

  void newBattleRoyaleGame(Dsix dsix) {
    dsix.gm.map = AvailableMaps.crossroads;

    double x = (Random().nextDouble() * 200);
    double y = 0;

    dsix.gm.navigation = TransformationController(
        Matrix4(1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 1, 0, -x, -y, 0, 1));

    dsix.gm.gameSelected = true;

    dsix.gm.buildCanvas();
  }

  void quickBattleRoyale(
    context,
    int numberOfPlayers,
    Dsix dsix,
    Gm gm,
  ) {
    dsix.gm.map = AvailableMaps.crossroads.copy();
    dsix.gm.gameSelected = true;

//Reset Players

    dsix.players.forEach((element) {
      if (element.playerCreated) {
        dsix.resetPlayer(element.index);
      }
    });

//Create Players

    int i = 0;
    while (i < numberOfPlayers) {
      int playerIndex = Random().nextInt(dsix.players.length);

      if (dsix.players[playerIndex].playerCreated) {
      } else {
        createRandomPlayer(dsix.players[playerIndex], playerIndex);
        i++;
      }
    }

//Spawn Loot

    int numberOfChests = numberOfPlayers * 15;

    gm.loot = [];

    _gmMapPageVM.createRandomLoot(context, gm, numberOfChests);

//Spawn Players

    _gmMapPageVM.spawnPlayersInRandomLocation(dsix.players, gm);

//Create turn order

    _gmMapPageVM.startGame(gm);

//Go to first Player

    // _gmMapPageVM.goToPlayer(context, dsix, gm.turnOrder.first.index);
  }

  createRandomPlayer(Player player, int playerIndex) {
    RacePageVM _racePageVM = RacePageVM();
    BackgroundPageVM _backgroundPageVM = BackgroundPageVM();
    SkillPageVM _skillPageVM = SkillPageVM();
    ActionPointPageVM _actionPointPageVM = ActionPointPageVM();

    player.index = playerIndex;

    int randomNumber =
        Random().nextInt(_racePageVM.availableRaces.races.length);

    _racePageVM.chooseRace(player, randomNumber);

    randomNumber = Random()
        .nextInt(_backgroundPageVM.availableBackgrounds.backgrounds.length);

    _backgroundPageVM.chooseBackground(player, randomNumber);

    randomNumber = Random().nextInt(_skillPageVM.availableSkills.skills.length);

    _skillPageVM.chooseSkill(randomNumber);

    _skillPageVM.createActions(player);

    while (player.actionPoints > 0) {
      int randomNumber = Random().nextInt(6);

      //Filters for attack, defense, look, walk

      if (randomNumber == 0 ||
          randomNumber == 1 ||
          randomNumber == 2 ||
          randomNumber == 4) {
        _actionPointPageVM.addPoints(player, randomNumber);
      }
    }

    _actionPointPageVM.createPlayer(player);
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
