import 'package:dsixv02app/models/dsix/dsix.dart';
import 'package:dsixv02app/models/player/bonus.dart';
import 'package:dsixv02app/models/player/player.dart';
import 'package:dsixv02app/models/player/playerBackground.dart';
import 'package:dsixv02app/pages/player/skill/skillPage.dart';
import 'package:dsixv02app/widgets/selector.dart';
import 'package:flutter/material.dart';
import 'playerBackgroundList.dart';

class BackgroundPageVM {
  PlayerBackgroundList availableBackgrounds = PlayerBackgroundList();
  Selector selector = Selector();

  PlayerBackground selectedBackground = PlayerBackground(
    name: 'BACKGROUND',
    description:
        'This is your story. Where you were born, how you where raised and if people like you or not. Click on the icons above to choose a background.',
    bonus: [
      Bonus(
        'THINGS',
        'Every background starts with different things.',
      )
    ],
  );

  void chooseBackground(Player player, int index) {
    selector.select(index);

    player.background = availableBackgrounds.backgrounds[index];
    this.selectedBackground = player.background;

    if (player.background.name == 'noble') {
      player.gold = 600;
      player.fame = 1;
    } else {
      player.gold = 300;
      player.fame = 0;
    }

    player.bag = [];
    player.weight = 0;

    player.background.bonusItem.forEach((element) {
      player.bag.add(element);
      player.weight += element.weight;
    });
  }

//Go to next Page

  goToSkillPage(context, Dsix dsix) {
    Route newRoute = PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => SkillPage(
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
