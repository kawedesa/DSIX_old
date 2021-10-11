import 'package:dsixv02app/models/dsix/dsix.dart';
import 'package:dsixv02app/models/player/action/actionOption.dart';
import 'package:dsixv02app/models/player/player.dart';
import 'package:dsixv02app/models/player/action/playerAction.dart';
import 'package:dsixv02app/models/player/action/playerBasicActions.dart';
import 'package:dsixv02app/pages/player/actionPoint/actionPointPage.dart';
import 'package:dsixv02app/widgets/selector.dart';
import 'package:flutter/material.dart';
import 'playerSkillList.dart';

class SkillPageVM {
//Choose Skill
  PlayerSkillList availableSkills = PlayerSkillList();
  PlayerBasicActions basicActions = PlayerBasicActions();
  Selector selector = Selector();

  PlayerAction selectedSkill = PlayerAction(
    icon: 'skill',
    name: 'SKILL',
    description:
        'This is your special move and what you are known for. Choose your skill by clicking on the icons above.',
    option: [
      ActionOption(
          name: 'OPTIONS',
          description: 'Each skill has different options to choose from.',
          value: 0)
    ],
    value: 0,
    bonus: 0,
  );

  void chooseSkill(int index) {
    selector.select(index);

    PlayerAction newSkill = availableSkills.skills[index].copyAction();
    this.selectedSkill = newSkill;
  }

  //Go to next Page

  void createActions(Player player) {
    player.actions = [];
    basicActions.basicActions.forEach((element) {
      player.actions.add(element);
    });
    player.actions.add(this.selectedSkill);

    for (int i = 0; i < player.actions.length; i++) {
      player.actions[i].value = player.race.actionPoints[i];
    }
    player.actionPoints = player.race.availableActionPoints;
  }

  goToActionPointPage(context, Dsix dsix) {
    createActions(dsix.getCurrentPlayer());

    Route newRoute = PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => ActionPointPage(
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
