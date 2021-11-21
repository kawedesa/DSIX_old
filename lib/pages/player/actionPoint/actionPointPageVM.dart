import 'package:dsixv02app/models/dsix/dsix.dart';
import 'package:dsixv02app/models/player/action/actionOption.dart';
import 'package:dsixv02app/models/player/player.dart';
import 'package:dsixv02app/models/player/action/playerAction.dart';
import 'package:dsixv02app/pages/player/playerUI/playerUI.dart';
import 'package:dsixv02app/widgets/selector.dart';
import 'package:flutter/material.dart';

class ActionPointPageVM {
// //Choose Skill
//   PlayerSkillList availableSkills = PlayerSkillList();
  Selector selector = Selector();

  PlayerAction selectedAction = PlayerAction(
    name: 'actions',
    description:
        'These represents the strenghts and weaknesses of your character. Click on the action to assign points to it. The more points you have, the better you are in that action.',
    option: [
      ActionOption(
        name: 'OPTIONS',
        description: 'Each action has different options to choose from.',
      )
    ],
  );

  void selectAction(Player player, int index) {
    this.selectedAction = player.actions[index];
    selector.select(index);
  }

  void addPoints(Player player, int index) {
    if (player.actionPoints == 0) {
      return;
    }

    if (player.actions[index].value < 3) {
      player.actions[index].value++;
      player.actionPoints--;
    }
  }

  void removePoints(Player player, int index) {
    if (player.actions[index].value != player.race.actionPoints[index]) {
      player.actions[index].value--;
      player.actionPoints++;
    }
  }

  final textController = TextEditingController();

  createPlayer(Player player) {
    if (textController.text == '') {
      player.name = '${player.race.name} ${player.background.name}';
    } else {
      player.name = this.textController.text;
    }

    for (int i = 0; i < player.actions.length; i++) {
      player.actions[i].option.forEach((option) {
        option.value = player.actions[i].value;
      });

      //set player vision

      player.visionRange = 150 + (15.0 * player.actions[2].value);
      player.walkRange = 100 + (10.0 * player.actions[4].value);
    }

    player.playerCreated = true;
  }

  //Go to next Page

  goToPlayerUI(context, Dsix dsix) {
    createPlayer(dsix.getCurrentPlayer());

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
}
