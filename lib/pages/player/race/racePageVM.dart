import 'dart:math';
import 'package:dsixv02app/core/app_images.dart';
import 'package:dsixv02app/models/dsix/dsix.dart';
import 'package:dsixv02app/models/player/player.dart';
import 'package:dsixv02app/models/player/playerRace.dart';
import 'package:dsixv02app/models/player/bonus.dart';
import 'package:dsixv02app/models/player/playerSprite.dart';
import 'package:dsixv02app/pages/player/background/backgroundPage.dart';
import 'package:dsixv02app/widgets/selector.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'playerRaceList.dart';

class RacePageVM {
//Choose Race
  PlayerRaceList availableRaces = PlayerRaceList();
  Selector selector = Selector();

  PlayerRace selectedRace = PlayerRace(
    name: 'RACES',
    description:
        'There are many races in this world. They vary in size, culture and color. Click on the icons above to choose a race.',
    bonus: [
      Bonus(
        'BONUS',
        'Each race has different strenghs and weaknesses that make them unique.',
      )
    ],
  );

  void chooseRace(Player player, int index) {
    selector.select(index);
    player.race = this.availableRaces.races[index].copyRace();
    player.health = player.race.maxHealth;
    chooseSex(player);
    this.selectedRace = player.race;
    player.race.setSprite(player.primaryColor);
  }

  void chooseSex(Player player) {
    List<String> possibleSex = ['male', 'female'];
    if (player.race.sex == null) {
      player.race.sex = possibleSex[Random().nextInt(possibleSex.length)];
    }
    if (player.race.sex == 'male') {
      player.race.sex = 'female';
    } else {
      player.race.sex = 'male';
    }
  }

//Go to next Page

  goToBackgroundPage(context, Dsix dsix) {
    Route newRoute = PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => BackgroundPage(
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
}
