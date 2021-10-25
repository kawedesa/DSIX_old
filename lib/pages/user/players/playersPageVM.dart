import 'package:dsixv02app/models/dsix/dsix.dart';
import 'package:dsixv02app/models/player/player.dart';
import 'package:dsixv02app/pages/gm/gmUI/gmUIPage.dart';
import 'package:dsixv02app/pages/player/actionPoint/actionPointPageVM.dart';
import 'package:dsixv02app/pages/player/background/backgroundPageVM.dart';
import 'package:dsixv02app/pages/player/playerUI/playerUI.dart';
import 'package:dsixv02app/pages/player/race/racePage.dart';
import 'package:dsixv02app/pages/player/race/racePageVM.dart';
import 'package:dsixv02app/pages/player/skill/skillPageVM.dart';
import 'package:flutter/material.dart';
import 'dart:math';

class PlayersPageVM {
  checkCharacter(BuildContext context, Dsix dsix, int playerIndex) {
    if (dsix.players[playerIndex].playerCreated) {
      goToPlayerUI(context, dsix, playerIndex);
    } else {
      goToRacePage(context, dsix, playerIndex);
    }
  }

  goToGmUI(BuildContext context, Dsix dsix) {
    Route newRoute = PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => GmUIPage(
        dsix: dsix,
      ),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        var begin = Offset(1.0, 0.0);
        var end = Offset(0.0, 0.0);
        var curve = Curves.ease;
        var tween =
            Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

        return SlideTransition(
          position: animation.drive(tween),
          child: child,
        );
      },
    );

    Navigator.of(context).push(newRoute);
  }

  goToPlayerUI(BuildContext context, Dsix dsix, int playerIndex) {
    dsix.setCurrentPlayer(playerIndex);

    Route newRoute = PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => PlayerUI(
        dsix: dsix,
      ),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        var begin = Offset(1.0, 0.0);
        var end = Offset(0.0, 0.0);
        var curve = Curves.ease;
        var tween =
            Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

        return SlideTransition(
          position: animation.drive(tween),
          child: child,
        );
      },
    );

    Navigator.of(context).push(newRoute);
  }

  goToRacePage(BuildContext context, Dsix dsix, int playerIndex) {
    Route newRoute = PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => RacePage(
        dsix: dsix,
      ),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        var begin = Offset(1.0, 0.0);
        var end = Offset(0.0, 0.0);
        var curve = Curves.ease;
        var tween =
            Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

        return SlideTransition(
          position: animation.drive(tween),
          child: child,
        );
      },
    );

    Navigator.of(context).push(newRoute);
  }

  deletePlayer(Dsix dsix, int playerIndex) {
    Player newPlayer = dsix.deletePlayer(dsix.players[playerIndex]);
    dsix.players.replaceRange(playerIndex, playerIndex + 1, [newPlayer]);
  }

  RacePageVM _racePageVM = RacePageVM();
  BackgroundPageVM _backgroundPageVM = BackgroundPageVM();
  SkillPageVM _skillPageVM = SkillPageVM();
  ActionPointPageVM _actionPointPageVM = ActionPointPageVM();

  createRandomPlayer(Player player, int playerIndex) {
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
      _actionPointPageVM.addPoints(player, randomNumber);
    }

    _actionPointPageVM.createPlayer(player);
  }
}
