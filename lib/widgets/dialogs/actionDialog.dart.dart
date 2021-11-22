import 'dart:math';
import 'package:dsixv02app/core/app_colors.dart';
import 'package:dsixv02app/core/app_text_styles.dart';
import 'package:dsixv02app/models/dsix/dice.dart';
import 'package:dsixv02app/models/dsix/item.dart';
import 'package:dsixv02app/models/dsix/shop.dart';
import 'package:dsixv02app/models/gm/gm.dart';
import 'package:dsixv02app/models/player/action/actionOutcome.dart';
import 'package:dsixv02app/models/player/action/actionResult.dart';
import 'package:dsixv02app/models/player/action/actionOption.dart';
import 'package:dsixv02app/models/player/effectSystem.dart';
import 'package:dsixv02app/models/player/player.dart';
import 'package:dsixv02app/widgets/buttons/dialogButton.dart';
import 'package:dsixv02app/widgets/dialogs/actionOptionDialog.dart';
import 'package:dsixv02app/widgets/dialogs/secondRollDialog.dart';
import 'package:dsixv02app/widgets/diceAnimation.dart';
import 'package:flutter/material.dart';

class ActionDialog extends StatefulWidget {
  const ActionDialog({
    @required this.action,
    @required this.player,
    @required this.shop,
    @required this.gm,
  });

  final ActionOption action;
  final Player player;
  final Shop shop;
  final Gm gm;

  @override
  State<ActionDialog> createState() => _ActionDialogState();
}

class _ActionDialogState extends State<ActionDialog> {
  ActionResult result = ActionResult();
  Widget outcomeWidget = Container();

  List<Item> foundResources = [];
  List<Dice> diceList;

  void prepareDice(int numberOfDice) {
    this.diceList = [];
    while (this.diceList.length < numberOfDice) {
      this.diceList.add(Dice(0, 1));
    }
  }

  void tapDie(int index) {
    if (diceList[index].die != 0) {
      return;
    }

    int randomNumber = Random().nextInt(6) + 1;

    diceList[index].die = randomNumber;
    diceList[index].animationLines = 0;

    int _checkDice = 0;

    diceList.forEach((element) {
      if (element.die == 0) {
        return;
      } else {
        _checkDice++;
      }
    });

    if (_checkDice == diceList.length) {
      takeAction();
    }
  }

  void actionResult() {
    outcomeWidget = Container();

    switch (this.result.outcomeType) {
      case 'secondRoll':
        {
          outcomeWidget = DialogButton(
            buttonText: this.result.outcomeAction,
            buttonColor: this.result.color,
            buttonTextColor: AppColors.white01,
            buttonIcon: 'action',
            onTapAction: () async {
              Navigator.pop(context);
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return SecondRollDialog(
                    result: this.result,
                  );
                },
              );
            },
          );
        }
        break;

      case 'text':
        {
          outcomeWidget = Text(
            this.result.outcomeText,
            textAlign: TextAlign.justify,
            style: TextStyle(
              fontSize: 19,
              fontFamily: 'Calibri',
              color: Colors.white,
            ),
          );
        }
        break;

      case 'options':
        {
          outcomeWidget = DialogButton(
            buttonText: this.result.outcomeAction,
            buttonColor: this.result.color,
            buttonTextColor: AppColors.white01,
            buttonIcon: 'action',
            onTapAction: () async {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return ActionOptionDialog(
                    result: this.result,
                    target: widget.player,
                  );
                },
              );
            },
          );
        }
        break;
    }
  }

  void takeAction() {
    // widget.gm.takeTurn(widget.player);

    this.result.diceResult = [];
    diceList.forEach((element) {
      this.result.diceResult.add(element.die);
    });

    this.result.total =
        this.result.diceResult.fold(0, (p, element) => p + element) +
            widget.action.value;
    this.result.sum =
        '${this.result.diceResult[0]} + ${this.result.diceResult[1]} + ${widget.action.value} = ${this.result.total}';

    this.result.color = Colors.green;

//Take Action

    switch (widget.action.name) {

//MORPH ACTIONS
      case 'fly':
        {
          if (this.result.total >= 10) {
            //10+
            this.result.outcomeTitle = 'success';
            this.result.outcomeType = 'text';
            this.result.outcomeText = 'You reach your goal.';
          } else if (this.result.total >= 7 && this.result.total <= 9) {
            //7-9
            List<ActionOutcome> possibleOutcomes = [
              ActionOutcome(description: 'You  fly half of the way.'),
              ActionOutcome(description: 'You face an obstacle.'),
              ActionOutcome(description: 'You leave something behind.'),
            ];
            this.result.outcomeTitle = 'half success';
            this.result.outcomeType = 'text';

            this.result.outcomeText =
                '${possibleOutcomes[Random().nextInt(possibleOutcomes.length)].description}';
          } else {
            //6-
            List<ActionOutcome> possibleOutcomes = [
              ActionOutcome(
                  description: 'You freeze and the enemy takes an action.'),
              ActionOutcome(description: 'You fall'),
              ActionOutcome(description: 'You hit something.'),
            ];
            this.result.color = Colors.red;
            this.result.outcomeTitle = 'fail';
            this.result.outcomeType = 'text';

            this.result.outcomeText =
                '${possibleOutcomes[Random().nextInt(possibleOutcomes.length)].description}';
          }
        }
        break;

      case 'trample':
        {
          if (this.result.total >= 10) {
            //10+
            this.result.outcomeTitle = 'success';
            this.result.outcomeType = 'secondRoll';
            this.result.outcomeAction = 'damage';
            this.result.outcomeText = 'You crush everyone in your path.';

            this.result.outcomeValue = 2; //Number of Dice
            this.result.outcomeBonus =
                5 + widget.player.pDamageEffect; // + DAMAGE TAMPLE

          } else if (this.result.total >= 7 && this.result.total <= 9) {
            //7-9
            this.result.outcomeTitle = 'half success';
            this.result.outcomeType = 'secondRoll';
            this.result.outcomeAction = 'damage';
            this.result.outcomeText = 'You crush everyone in your path.';

            this.result.outcomeValue = 1; //Number of Dice
            this.result.outcomeBonus =
                3 + widget.player.pDamageEffect; // + DAMAGE TAMPLE
          } else {
            //6-
            List<ActionOutcome> possibleOutcomes = [
              ActionOutcome(
                  description: 'The enemy dodges and take and action.'),
              ActionOutcome(
                  description: 'The enemy dodges and you trample an ally.'),
              ActionOutcome(description: 'The enemy dodges and attack you.'),
            ];

            this.result.color = Colors.red;
            this.result.outcomeTitle = 'fail';
            this.result.outcomeType = 'text';

            this.result.outcomeText =
                '${possibleOutcomes[Random().nextInt(possibleOutcomes.length)].description}';
          }
        }
        break;
      case 'throw':
        {
          if (this.result.total >= 10) {
            //10+
            this.result.outcomeTitle = 'success';
            this.result.outcomeType = 'secondRoll';
            this.result.outcomeAction = 'damage';
            this.result.outcomeText = 'You hit the target';

            this.result.outcomeValue = 2; //Number of Dice
            this.result.outcomeBonus =
                3 + widget.player.pDamageEffect; //+ Damage

          } else if (this.result.total >= 7 && this.result.total <= 9) {
            //7-9
            this.result.outcomeTitle = 'half success';
            this.result.outcomeType = 'secondRoll';
            this.result.outcomeAction = 'damage';
            this.result.outcomeText = 'You hit the target.';

            this.result.outcomeValue = 1; //Number of Dice
            this.result.outcomeBonus =
                1 + widget.player.pDamageEffect; // + Damage
          } else {
            //6-
            List<ActionOutcome> possibleOutcomes = [
              ActionOutcome(
                  description: 'You miss and the enemy takes an action.'),
              ActionOutcome(description: 'You miss and hit an ally.'),
            ];

            this.result.color = Colors.red;
            this.result.outcomeTitle = 'fail';
            this.result.outcomeType = 'text';

            this.result.outcomeText =
                '${possibleOutcomes[Random().nextInt(possibleOutcomes.length)].description}';
          }
        }
        break;
      case 'grab':
        {
          if (this.result.total >= 10) {
            //10+
            this.result.outcomeTitle = 'success';
            this.result.outcomeType = 'text';

            this.result.outcomeText =
                'You grab them and they are unable to move.';
          } else if (this.result.total >= 7 && this.result.total <= 9) {
            //7-9
            this.result.outcomeTitle = 'half success';
            this.result.outcomeType = 'text';

            this.result.outcomeText = 'You grab one of their arms or legs.';
          } else {
            //6-
            List<ActionOutcome> possibleOutcomes = [
              ActionOutcome(description: 'They escape and take an action.'),
              ActionOutcome(description: 'They attack you.'),
            ];
            this.result.color = Colors.red;
            this.result.outcomeTitle = 'fail';
            this.result.outcomeType = 'text';

            this.result.outcomeText =
                '${possibleOutcomes[Random().nextInt(possibleOutcomes.length)].description}';
          }
        }
        break;
      case 'slash':
        {
          if (this.result.total >= 10) {
            //10+
            this.result.outcomeTitle = 'success';
            this.result.outcomeType = 'secondRoll';
            this.result.outcomeAction = 'damage';
            this.result.outcomeText =
                'You slash the target and make them bleed.';

            this.result.outcomeBonus =
                3 + widget.player.pDamageEffect; // Raw damage +3
            this.result.outcomeValue = 2; //Number of Dice
          } else if (this.result.total >= 7 && this.result.total <= 9) {
            //7-9
            this.result.outcomeTitle = 'half success';
            this.result.outcomeType = 'secondRoll';
            this.result.outcomeAction = 'damage';
            this.result.outcomeText =
                'You slash the target and make them bleed.';
            this.result.outcomeValue = 1; //Number of Dice

            this.result.outcomeBonus =
                1 + widget.player.pDamageEffect; // Raw damage +1
          } else {
            //6-
            List<ActionOutcome> possibleOutcomes = [
              ActionOutcome(
                  description: 'You miss and the enemy takes an action.'),
              ActionOutcome(description: 'You miss and the enemy and hold.'),
              ActionOutcome(description: 'You miss and the enemy attacks you.'),
            ];
            this.result.color = Colors.red;
            this.result.outcomeTitle = 'fail';
            this.result.outcomeType = 'text';

            this.result.outcomeText =
                '${possibleOutcomes[Random().nextInt(possibleOutcomes.length)].description}';
          }
        }
        break;
      case 'charge':
        {
          if (this.result.total >= 10) {
            //10+
            this.result.outcomeTitle = 'success';
            this.result.outcomeType = 'secondRoll';
            this.result.outcomeAction = 'damage';
            this.result.outcomeText = 'You crush everyone in your path.';

            this.result.outcomeBonus =
                4 + widget.player.pDamageEffect; // Raw damage +4
            this.result.outcomeValue = 2; //Number of Dice
          } else if (this.result.total >= 7 && this.result.total <= 9) {
            //7-9
            this.result.outcomeTitle = 'half success';
            this.result.outcomeType = 'secondRoll';
            this.result.outcomeAction = 'damage';
            this.result.outcomeText = 'You crush everyone in your path.';
            this.result.outcomeValue = 1; //Number of Dice

            this.result.outcomeBonus =
                2 + widget.player.pDamageEffect; // Raw damage +2
          } else {
            //6-
            List<ActionOutcome> possibleOutcomes = [
              ActionOutcome(
                  description: 'The enemy dodges and take and action.'),
              ActionOutcome(
                  description: 'The enemy dodges and you trample an ally.'),
              ActionOutcome(description: 'The enemy dodges and attack you.'),
            ];
            this.result.color = Colors.red;
            this.result.outcomeTitle = 'fail';
            this.result.outcomeType = 'text';

            this.result.outcomeText =
                '${possibleOutcomes[Random().nextInt(possibleOutcomes.length)].description}';
          }
        }
        break;
      case 'constrict':
        {
          if (this.result.total >= 10) {
            //10+
            this.result.outcomeTitle = 'success';
            this.result.outcomeType = 'secondRoll';
            this.result.outcomeAction = 'damage';
            this.result.outcomeText = 'You crush the target.';

            this.result.outcomeBonus =
                4 + widget.player.pDamageEffect; // Raw damage +4
            this.result.outcomeValue = 2; //Number of Dice
          } else if (this.result.total >= 7 && this.result.total <= 9) {
            //7-9
            this.result.outcomeTitle = 'half success';
            this.result.outcomeType = 'secondRoll';
            this.result.outcomeAction = 'damage';
            this.result.outcomeText = 'You crush the target.';
            this.result.outcomeValue = 1; //Number of Dice

            this.result.outcomeBonus =
                2 + widget.player.pDamageEffect; // Raw damage +2
          } else {
            //6-
            List<ActionOutcome> possibleOutcomes = [
              ActionOutcome(description: 'They escape and take an action.'),
              ActionOutcome(description: 'They escape and hold you down.'),
              ActionOutcome(description: 'They attack you.'),
            ];
            this.result.color = Colors.red;
            this.result.outcomeTitle = 'fail';
            this.result.outcomeType = 'text';

            this.result.outcomeText =
                '${possibleOutcomes[Random().nextInt(possibleOutcomes.length)].description}';
          }
        }
        break;
      case 'twist':
        {
          if (this.result.total >= 10) {
            //10+
            this.result.outcomeTitle = 'success';
            this.result.outcomeType = 'secondRoll';
            this.result.outcomeAction = 'damage';
            this.result.outcomeText = 'You twist and rip the targe apart.';

            this.result.outcomeBonus =
                5 + widget.player.pDamageEffect; // Raw damage +4
            this.result.outcomeValue = 2; //Number of Dice
          } else if (this.result.total >= 7 && this.result.total <= 9) {
            //7-9
            this.result.outcomeTitle = 'half success';
            this.result.outcomeType = 'secondRoll';
            this.result.outcomeAction = 'damage';
            this.result.outcomeText = 'You twist and rip the targe apart.';
            this.result.outcomeValue = 1; //Number of Dice

            this.result.outcomeBonus =
                3 + widget.player.pDamageEffect; // Raw damage +2
          } else {
            //6-
            List<ActionOutcome> possibleOutcomes = [
              ActionOutcome(description: 'They escape and take an action.'),
              ActionOutcome(description: 'They escape and hold you.'),
              ActionOutcome(description: 'They attack you.'),
            ];
            this.result.color = Colors.red;
            this.result.outcomeTitle = 'fail';
            this.result.outcomeType = 'text';

            this.result.outcomeText =
                '${possibleOutcomes[Random().nextInt(possibleOutcomes.length)].description}';
          }
        }
        break;
      case 'peck':
        {
          if (this.result.total >= 10) {
            //10+
            this.result.outcomeTitle = 'success';
            this.result.outcomeType = 'secondRoll';
            this.result.outcomeAction = 'damage';
            this.result.outcomeText = 'You peck the target.';
            this.result.outcomeValue = 2; //Number of Dice
            this.result.outcomeBonus = widget.player.pDamageEffect;
          } else if (this.result.total >= 7 && this.result.total <= 9) {
            //7-9
            this.result.outcomeTitle = 'half success';
            this.result.outcomeType = 'secondRoll';
            this.result.outcomeAction = 'damage';
            this.result.outcomeText = 'You peck the target.';
            this.result.outcomeValue = 1; //Number of Dice
            this.result.outcomeBonus = widget.player.pDamageEffect;
          } else {
            //6-
            List<ActionOutcome> possibleOutcomes = [
              ActionOutcome(
                  description: 'You miss and the enemy takes an action.'),
              ActionOutcome(description: 'You miss and the enemy and hold.'),
              ActionOutcome(description: 'You miss and the enemy attacks you.'),
            ];
            this.result.color = Colors.red;
            this.result.outcomeTitle = 'fail';
            this.result.outcomeType = 'text';

            this.result.outcomeText =
                '${possibleOutcomes[Random().nextInt(possibleOutcomes.length)].description}';
          }
        }
        break;
      case 'bite':
        {
          if (this.result.total >= 10) {
            //10+
            this.result.outcomeTitle = 'success';
            this.result.outcomeType = 'secondRoll';
            this.result.outcomeAction = 'damage';
            this.result.outcomeText = 'You bite the target.';
            this.result.outcomeValue = 2; //Number of Dice
            this.result.outcomeBonus = widget.player.pDamageEffect;
          } else if (this.result.total >= 7 && this.result.total <= 9) {
            //7-9
            this.result.outcomeTitle = 'half success';
            this.result.outcomeType = 'secondRoll';
            this.result.outcomeAction = 'damage';
            this.result.outcomeText = 'You bite the target.';
            this.result.outcomeValue = 1; //Number of Dice
            this.result.outcomeBonus = widget.player.pDamageEffect;
          } else {
            //6-
            List<ActionOutcome> possibleOutcomes = [
              ActionOutcome(
                  description: 'You miss and the enemy takes an action.'),
              ActionOutcome(description: 'You miss and the enemy and hold.'),
              ActionOutcome(description: 'You miss and the enemy attacks you.'),
            ];
            this.result.color = Colors.red;
            this.result.outcomeTitle = 'fail';
            this.result.outcomeType = 'text';

            this.result.outcomeText =
                '${possibleOutcomes[Random().nextInt(possibleOutcomes.length)].description}';
          }
        }
        break;

//BASIC ACTIONS

      case 'punch':
        {
          if (this.result.total >= 10) {
            //10+
            this.result.outcomeTitle = 'success';
            this.result.outcomeType = 'secondRoll';
            this.result.outcomeAction = 'damage';
            this.result.outcomeText = 'You hit the target.';
            this.result.outcomeBonus = widget.player.pDamageEffect;
            this.result.outcomeValue = 2;
          } else if (this.result.total >= 7 && this.result.total <= 9) {
            //7-9
            this.result.outcomeTitle = 'half success';
            this.result.outcomeType = 'secondRoll';
            this.result.outcomeAction = 'damage';
            this.result.outcomeText = 'You hit the target.';
            this.result.outcomeBonus = widget.player.pDamageEffect;
            this.result.outcomeValue = 1;
          } else {
            //6-
            List<ActionOutcome> possibleOutcomes = [
              ActionOutcome(
                  description: 'You miss and the enemy takes an action.'),
              ActionOutcome(description: 'You miss and the enemy and hold.'),
              ActionOutcome(description: 'You miss and the enemy attacks you.'),
            ];
            this.result.color = Colors.red;
            this.result.outcomeTitle = 'fail';
            this.result.outcomeType = 'text';

            this.result.outcomeText =
                '${possibleOutcomes[Random().nextInt(possibleOutcomes.length)].description}';
          }
        }
        break;

      case 'weapon':
        {
          if (this.result.total >= 10) {
            //10+
            this.result.outcomeTitle = 'success';
            this.result.outcomeType = 'secondRoll';
            this.result.outcomeAction = 'damage';
            this.result.outcomeText = 'You hit the target';

            this.result.outcomeValue = 2;
            this.result.outcomeBonus =
                widget.player.pDamageTotal + widget.player.mDamageTotal;
          } else if (this.result.total >= 7 && this.result.total <= 9) {
            //7-9
            this.result.outcomeTitle = 'half success';
            this.result.outcomeType = 'secondRoll';
            this.result.outcomeAction = 'damage';
            this.result.outcomeText = 'You hit the target.';

            this.result.outcomeValue = 1;
            this.result.outcomeBonus =
                widget.player.pDamageTotal + widget.player.mDamageTotal;
          } else {
            //6-
            List<ActionOutcome> possibleOutcomes = [
              ActionOutcome(
                  description: 'You miss and the enemy takes an action.'),
              ActionOutcome(description: 'You miss and the enemy and hold.'),
              ActionOutcome(description: 'You miss and the enemy attacks you.'),
              ActionOutcome(description: 'You miss and drop your weapon.'),
            ];

            this.result.color = Colors.red;
            this.result.outcomeTitle = 'fail';
            this.result.outcomeType = 'text';

            this.result.outcomeText =
                '${possibleOutcomes[Random().nextInt(possibleOutcomes.length)].description}';
          }
        }
        break;
      case 'grapple':
        {
          if (this.result.total >= 10) {
            //10+
            this.result.outcomeTitle = 'success';
            this.result.outcomeType = 'text';

            this.result.outcomeText =
                'You hold them in place and they are unable to move.';
          } else if (this.result.total >= 7 && this.result.total <= 9) {
            //7-9
            this.result.outcomeTitle = 'half success';
            this.result.outcomeType = 'text';

            this.result.outcomeText = 'You hold one of their arms or legs.';
          } else {
            //6-
            List<ActionOutcome> possibleOutcomes = [
              ActionOutcome(description: 'They escape and take an action.'),
              ActionOutcome(description: 'They escape and hold you down.'),
              ActionOutcome(description: 'They attack you.'),
            ];
            this.result.color = Colors.red;
            this.result.outcomeTitle = 'fail';
            this.result.outcomeType = 'text';

            this.result.outcomeText =
                '${possibleOutcomes[Random().nextInt(possibleOutcomes.length)].description}';
          }
        }
        break;
      case 'defend':
        {
          if (this.result.total >= 10) {
            //10+
            this.result.outcomeTitle = 'success';
            this.result.outcomeType = 'secondRoll';
            this.result.outcomeAction = 'defend';
            this.result.outcomeText = 'You protect some damage.';
            this.result.outcomeValue = 2;
            this.result.outcomeBonus = 0;
          } else if (this.result.total >= 7 && this.result.total <= 9) {
            //7-9
            this.result.outcomeTitle = 'half success';
            this.result.outcomeType = 'secondRoll';
            this.result.outcomeAction = 'defend';
            this.result.outcomeText = 'You protect some damage.';
            this.result.outcomeValue = 1;
            this.result.outcomeBonus = 0;
          } else {
            //6-
            List<ActionOutcome> possibleOutcomes = [
              ActionOutcome(description: 'You take damage and are stunned.'),
              ActionOutcome(
                  description: 'You take damage and drop a piece of armor.'),
            ];
            this.result.color = Colors.red;
            this.result.outcomeTitle = 'fail';
            this.result.outcomeType = 'text';

            this.result.outcomeText =
                '${possibleOutcomes[Random().nextInt(possibleOutcomes.length)].description}';
          }
        }
        break;
      case 'resist':
        {
          if (this.result.total >= 10) {
            //10+
            this.result.outcomeTitle = 'success';
            this.result.outcomeType = 'text';

            this.result.outcomeText = 'You clear all negative effects.';
          } else if (this.result.total >= 7 && this.result.total <= 9) {
            //7-9
            this.result.outcomeTitle = 'half success';
            this.result.outcomeType = 'text';

            this.result.outcomeText =
                'You don\'t receive any additional effect.';
          } else {
            //6-
            List<ActionOutcome> possibleOutcomes = [
              ActionOutcome(description: 'You don\'t resist.'),
            ];
            this.result.color = Colors.red;
            this.result.outcomeTitle = 'fail';
            this.result.outcomeType = 'text';

            this.result.outcomeText =
                '${possibleOutcomes[Random().nextInt(possibleOutcomes.length)].description}';
          }
        }
        break;
      case 'help':
        {
          if (this.result.total >= 10) {
            //10+
            this.result.outcomeTitle = 'success';
            this.result.outcomeType = 'text';

            this.result.outcomeText = 'You are super helpful.';
          } else if (this.result.total >= 7 && this.result.total <= 9) {
            //7-9
            this.result.outcomeTitle = 'half success';
            this.result.outcomeType = 'text';

            this.result.outcomeText = 'You help them.';
          } else {
            //6-
            List<ActionOutcome> possibleOutcomes = [
              ActionOutcome(description: 'You get on their way.'),
            ];
            this.result.color = Colors.red;
            this.result.outcomeTitle = 'fail';
            this.result.outcomeType = 'text';

            this.result.outcomeText =
                '${possibleOutcomes[Random().nextInt(possibleOutcomes.length)].description}';
          }
        }
        break;

      case 'lift':
        {
          if (this.result.total >= 10) {
            //10+
            this.result.outcomeTitle = 'success';
            this.result.outcomeType = 'text';

            this.result.outcomeText = 'You lift with no problem.';
          } else if (this.result.total >= 7 && this.result.total <= 9) {
            //7-9
            this.result.outcomeTitle = 'half success';
            this.result.outcomeType = 'text';

            this.result.outcomeText = 'You can lift, but not for long.';
          } else {
            //6-
            List<ActionOutcome> possibleOutcomes = [
              ActionOutcome(description: 'You drop it on yourself.'),
              ActionOutcome(description: 'You drop it on someone else.'),
              ActionOutcome(
                  description:
                      'You fail to lift and the enemy takes an action.'),
            ];
            this.result.color = Colors.red;
            this.result.outcomeTitle = 'fail';
            this.result.outcomeType = 'text';

            this.result.outcomeText =
                '${possibleOutcomes[Random().nextInt(possibleOutcomes.length)].description}';
          }
        }
        break;

      case 'resources':
        {
          this.foundResources = [];
          if (this.result.total >= 10) {
            //10+
            this.result.outcomeTitle = 'success';
            this.result.outcomeType = 'options';
            this.result.outcomeAction = 'resources';
            this.result.outcomeText = 'You find something useful.';
            this.result.outcomeValue = 2;

            this.foundResources = [];
            this.result.outcomeOptions = [];
            for (int i = 0; i < 3; i++) {
              Item randomResource =
                  widget.shop.randomItemRange(100, 200, 'resources').copyItem();

              this.foundResources.add(randomResource);
              this.result.outcomeOptions.add(ActionOutcome(
                  name: randomResource.name,
                  itemList: [randomResource],
                  selected: false));
            }
          } else if (this.result.total >= 7 && this.result.total <= 9) {
            //7-9
            this.result.outcomeTitle = 'half success';
            this.result.outcomeType = 'options';
            this.result.outcomeAction = 'resources';
            this.result.outcomeText = 'You find something.';
            this.result.outcomeValue = 1;
            this.foundResources = [];
            this.result.outcomeOptions = [];
            for (int i = 0; i < 3; i++) {
              Item randomResource =
                  widget.shop.randomItemRange(100, 100, 'resources').copyItem();

              this.foundResources.add(randomResource);
              this.result.outcomeOptions.add(ActionOutcome(
                  name: randomResource.name,
                  itemList: [randomResource],
                  selected: false));
            }
          } else {
            //6-
            List<ActionOutcome> possibleOutcomes = [
              ActionOutcome(description: 'You find a new danger.'),
              ActionOutcome(description: 'You find a new obstacle.'),
            ];
            this.result.color = Colors.red;
            this.result.outcomeTitle = 'fail';
            this.result.outcomeType = 'text';

            this.result.outcomeText =
                '${possibleOutcomes[Random().nextInt(possibleOutcomes.length)].description}';
          }
        }
        break;
      case 'information':
        {
          if (this.result.total >= 10) {
            //10+
            this.result.outcomeTitle = 'success';
            this.result.outcomeType = 'options';
            this.result.outcomeAction = 'information';
            this.result.outcomeText = 'You discover something important.';
            this.result.outcomeValue = 2;

            List<ActionOutcome> possibleOutcomes = [
              ActionOutcome(
                  name: 'story',
                  description: 'You learn something about the story.',
                  selected: false),
              ActionOutcome(
                  name: 'danger',
                  description: 'You learn about a danger.',
                  selected: false),
              ActionOutcome(
                  name: 'secrete',
                  description: 'You learn about a secrete.',
                  selected: false),
              ActionOutcome(
                  name: 'obstacle',
                  description: 'You learn about an obstacle.',
                  selected: false),
              ActionOutcome(
                  name: 'character',
                  description: 'You learn about a character.',
                  selected: false),
            ];
            this.result.outcomeOptions = possibleOutcomes;
            this.result.outcomeOptions.shuffle();
            while (this.result.outcomeOptions.length > 3) {
              this.result.outcomeOptions.removeLast();
            }
          } else if (this.result.total >= 7 && this.result.total <= 9) {
            //7-9
            this.result.outcomeTitle = 'half success';
            this.result.outcomeType = 'options';
            this.result.outcomeAction = 'information';
            this.result.outcomeText = 'You discover something.';
            this.result.outcomeValue = 1;

            List<ActionOutcome> possibleOutcomes = [
              ActionOutcome(
                  name: 'story',
                  description: 'You learn something about the story.',
                  selected: false),
              ActionOutcome(
                  name: 'danger',
                  description: 'You learn about a danger.',
                  selected: false),
              ActionOutcome(
                  name: 'secrete',
                  description: 'You learn about a secrete.',
                  selected: false),
              ActionOutcome(
                  name: 'obstacle',
                  description: 'You learn about an obstacle.',
                  selected: false),
              ActionOutcome(
                  name: 'character',
                  description: 'You learn about a character.',
                  selected: false),
            ];
            this.result.outcomeOptions = possibleOutcomes;
            this.result.outcomeOptions.shuffle();
            while (this.result.outcomeOptions.length > 3) {
              this.result.outcomeOptions.removeLast();
            }
          } else {
            //6-
            List<ActionOutcome> possibleOutcomes = [
              ActionOutcome(description: 'You find a new danger.'),
              ActionOutcome(description: 'You find a new obstacle.'),
            ];
            this.result.color = Colors.red;
            this.result.outcomeTitle = 'fail';
            this.result.outcomeType = 'text';

            this.result.outcomeText =
                '${possibleOutcomes[Random().nextInt(possibleOutcomes.length)].description}';
          }
        }
        break;
      case 'trade':
        {
          if (this.result.total >= 10) {
            //10+
            this.result.outcomeTitle = 'success';
            this.result.outcomeType = 'text';

            this.result.outcomeText = 'They accept your offer.';
          } else if (this.result.total >= 7 && this.result.total <= 9) {
            //7-9
            List<ActionOutcome> possibleOutcomes = [
              ActionOutcome(description: 'They raise the price.'),
              ActionOutcome(description: 'They ask for an aditional favor.'),
            ];
            this.result.outcomeTitle = 'half success';
            this.result.outcomeType = 'text';

            this.result.outcomeText =
                '${possibleOutcomes[Random().nextInt(possibleOutcomes.length)].description}';
          } else {
            //6-
            List<ActionOutcome> possibleOutcomes = [
              ActionOutcome(description: 'The deal is off.'),
              ActionOutcome(description: 'They call for backup'),
            ];
            this.result.color = Colors.red;
            this.result.outcomeTitle = 'fail';
            this.result.outcomeType = 'text';

            this.result.outcomeText =
                '${possibleOutcomes[Random().nextInt(possibleOutcomes.length)].description}';
          }
        }
        break;

      case 'convince':
        {
          if (this.result.total >= 10) {
            //10+
            this.result.outcomeTitle = 'success';
            this.result.outcomeType = 'text';

            this.result.outcomeText = 'You change their minds.';
          } else if (this.result.total >= 7 && this.result.total <= 9) {
            //7-9
            List<ActionOutcome> possibleOutcomes = [
              ActionOutcome(description: 'They ask for \$50.'),
              ActionOutcome(description: 'They ask for \$100.'),
              ActionOutcome(description: 'They ask for a favor.'),
            ];
            this.result.outcomeTitle = 'half success';
            this.result.outcomeType = 'text';

            this.result.outcomeText =
                '${possibleOutcomes[Random().nextInt(possibleOutcomes.length)].description}';
          } else {
            //6-
            List<ActionOutcome> possibleOutcomes = [
              ActionOutcome(description: 'They take an action.'),
              ActionOutcome(description: 'They call for backup.'),
            ];
            this.result.color = Colors.red;
            this.result.outcomeTitle = 'fail';
            this.result.outcomeType = 'text';

            this.result.outcomeText =
                '${possibleOutcomes[Random().nextInt(possibleOutcomes.length)].description}';
          }
        }
        break;

      case 'dodge':
        {
          if (this.result.total >= 10) {
            //10+
            this.result.outcomeTitle = 'success';
            this.result.outcomeType = 'text';

            this.result.outcomeText = 'You dodge.';
          } else if (this.result.total >= 7 && this.result.total <= 9) {
            //7-9
            List<ActionOutcome> possibleOutcomes = [
              ActionOutcome(description: 'You take half damage.'),
              ActionOutcome(description: 'You dodge, but drop something.'),
              ActionOutcome(
                  description: 'You dodge, but find another obstacle.'),
            ];
            this.result.outcomeTitle = 'half success';
            this.result.outcomeType = 'text';

            this.result.outcomeText =
                '${possibleOutcomes[Random().nextInt(possibleOutcomes.length)].description}';
          } else {
            //6-
            List<ActionOutcome> possibleOutcomes = [
              ActionOutcome(description: 'You take damage and fall.'),
              ActionOutcome(description: 'You take damage and get stuck.'),
            ];
            this.result.color = Colors.red;
            this.result.outcomeTitle = 'fail';
            this.result.outcomeType = 'text';

            this.result.outcomeText =
                '${possibleOutcomes[Random().nextInt(possibleOutcomes.length)].description}';
          }
        }
        break;
      case 'escape':
        {
          if (this.result.total >= 10) {
            //10+
            this.result.outcomeTitle = 'success';
            this.result.outcomeType = 'text';

            this.result.outcomeText = 'You escape.';
          } else if (this.result.total >= 7 && this.result.total <= 9) {
            //7-9
            List<ActionOutcome> possibleOutcomes = [
              ActionOutcome(
                  description: 'One of your arms or legs gets stuck.'),
              ActionOutcome(
                  description: 'You escape, but leave something behind.'),
              ActionOutcome(
                  description: 'You escape, but find a new obstacle.'),
            ];
            this.result.outcomeTitle = 'half success';
            this.result.outcomeType = 'text';

            this.result.outcomeText =
                '${possibleOutcomes[Random().nextInt(possibleOutcomes.length)].description}';
          } else {
            //6-
            List<ActionOutcome> possibleOutcomes = [
              ActionOutcome(description: 'You are stuck and take damage.'),
              ActionOutcome(description: 'You are stuck and loose something.'),
            ];
            this.result.color = Colors.red;
            this.result.outcomeTitle = 'fail';
            this.result.outcomeType = 'text';

            this.result.outcomeText =
                '${possibleOutcomes[Random().nextInt(possibleOutcomes.length)].description}';
          }
        }
        break;
      case 'hide':
        {
          if (this.result.total >= 10) {
            //10+
            this.result.outcomeTitle = 'success';
            this.result.outcomeType = 'text';

            this.result.outcomeText = 'You are hidden.';
          } else if (this.result.total >= 7 && this.result.total <= 9) {
            //7-9
            List<ActionOutcome> possibleOutcomes = [
              ActionOutcome(description: 'You make a sound.'),
              ActionOutcome(description: 'You drop something.'),
              ActionOutcome(description: 'You loose your cover.'),
            ];
            this.result.outcomeTitle = 'half success';
            this.result.outcomeType = 'text';

            this.result.outcomeText =
                '${possibleOutcomes[Random().nextInt(possibleOutcomes.length)].description}';
          } else {
            //6-
            List<ActionOutcome> possibleOutcomes = [
              ActionOutcome(description: 'They find you and take an action.'),
              ActionOutcome(description: 'They find you and call for backup.'),
            ];
            this.result.color = Colors.red;
            this.result.outcomeTitle = 'fail';
            this.result.outcomeType = 'text';

            this.result.outcomeText =
                '${possibleOutcomes[Random().nextInt(possibleOutcomes.length)].description}';
          }
        }
        break;
      case 'jump':
        {
          if (this.result.total >= 10) {
            //10+
            this.result.outcomeTitle = 'success';
            this.result.outcomeType = 'text';

            this.result.outcomeText = 'You land right on spot.';
          } else if (this.result.total >= 7 && this.result.total <= 9) {
            //7-9
            List<ActionOutcome> possibleOutcomes = [
              ActionOutcome(description: 'You land in a dangerous place.'),
              ActionOutcome(description: 'You fall on the landing.'),
            ];
            this.result.outcomeTitle = 'half success';
            this.result.outcomeType = 'text';

            this.result.outcomeText =
                '${possibleOutcomes[Random().nextInt(possibleOutcomes.length)].description}';
          } else {
            //6-
            List<ActionOutcome> possibleOutcomes = [
              ActionOutcome(description: 'You land in a bad place.'),
              ActionOutcome(
                  description: 'You freeze and the enemy takes an action.'),
            ];
            this.result.color = Colors.red;
            this.result.outcomeTitle = 'fail';
            this.result.outcomeType = 'text';

            this.result.outcomeText =
                '${possibleOutcomes[Random().nextInt(possibleOutcomes.length)].description}';
          }
        }
        break;
      case 'climb':
        {
          if (this.result.total >= 10) {
            //10+
            this.result.outcomeTitle = 'success';
            this.result.outcomeType = 'text';

            this.result.outcomeText = 'You reach your goal.';
          } else if (this.result.total >= 7 && this.result.total <= 9) {
            //7-9
            List<ActionOutcome> possibleOutcomes = [
              ActionOutcome(
                  description:
                      'You reach your goal, but leave something behind.'),
              ActionOutcome(
                  description:
                      'You reach your goal, but find another obstacle.'),
              ActionOutcome(description: 'You climb halfway.'),
            ];
            this.result.outcomeTitle = 'half success';
            this.result.outcomeType = 'text';

            this.result.outcomeText =
                '${possibleOutcomes[Random().nextInt(possibleOutcomes.length)].description}';
          } else {
            //6-
            List<ActionOutcome> possibleOutcomes = [
              ActionOutcome(description: 'You slide and fall.'),
              ActionOutcome(
                  description: 'You freeze and the enemy takes an action.'),
            ];
            this.result.color = Colors.red;
            this.result.outcomeTitle = 'fail';
            this.result.outcomeType = 'text';

            this.result.outcomeText =
                '${possibleOutcomes[Random().nextInt(possibleOutcomes.length)].description}';
          }
        }
        break;
      case 'swim':
        {
          if (this.result.total >= 10) {
            //10+
            this.result.outcomeTitle = 'success';
            this.result.outcomeType = 'text';

            this.result.outcomeText = 'You reach your goal.';
          } else if (this.result.total >= 7 && this.result.total <= 9) {
            //7-9
            List<ActionOutcome> possibleOutcomes = [
              ActionOutcome(description: 'You swim halfway.'),
              ActionOutcome(
                  description:
                      'You reach your goal, but find another obstacle.'),
              ActionOutcome(
                  description:
                      'You reach your goal, but leave something behind.'),
            ];
            this.result.outcomeTitle = 'half success';
            this.result.outcomeType = 'text';

            this.result.outcomeText =
                '${possibleOutcomes[Random().nextInt(possibleOutcomes.length)].description}';
          } else {
            //6-
            List<ActionOutcome> possibleOutcomes = [
              ActionOutcome(description: 'You drink water.'),
              ActionOutcome(
                  description: 'You freeze and the enemy takes an action.'),
              ActionOutcome(description: 'You sink.'),
              ActionOutcome(description: 'You get stuck.'),
            ];
            this.result.color = Colors.red;
            this.result.outcomeTitle = 'fail';
            this.result.outcomeType = 'text';

            this.result.outcomeText =
                '${possibleOutcomes[Random().nextInt(possibleOutcomes.length)].description}';
          }
        }
        break;

//ACTION SKILLS

      case 'morph':
        {
          if (this.result.total >= 10) {
            //10+
            this.result.outcomeTitle = 'success';
            this.result.outcomeType = 'options';
            this.result.outcomeAction = 'morph';

            this.result.outcomeValue = 1;

            List<ActionOutcome> possibleOutcomes = [
              ActionOutcome(name: 'puma', selected: false),
              ActionOutcome(name: 'crocodile', selected: false),
              ActionOutcome(name: 'gorilla', selected: false),
              ActionOutcome(name: 'rhino', selected: false),
              ActionOutcome(name: 'elephant', selected: false),
              ActionOutcome(name: 'bear', selected: false),
            ];
            this.result.outcomeOptions = possibleOutcomes;
            this.result.outcomeOptions.shuffle();
            while (this.result.outcomeOptions.length > 3) {
              this.result.outcomeOptions.removeLast();
            }
          } else if (this.result.total >= 7 && this.result.total <= 9) {
            //7-9
            this.result.outcomeTitle = 'half success';
            this.result.outcomeType = 'options';
            this.result.outcomeAction = 'morph';

            this.result.outcomeValue = 1;

            List<ActionOutcome> possibleOutcomes = [
              ActionOutcome(name: 'crab', selected: false),
              ActionOutcome(name: 'snake', selected: false),
              ActionOutcome(name: 'bird', selected: false),
              ActionOutcome(name: 'bull', selected: false),
              ActionOutcome(name: 'bat', selected: false),
              ActionOutcome(name: 'fox', selected: false),
            ];
            this.result.outcomeOptions = possibleOutcomes;
            this.result.outcomeOptions.shuffle();
            while (this.result.outcomeOptions.length > 3) {
              this.result.outcomeOptions.removeLast();
            }
          } else {
            //6-
            this.result.color = Colors.red;
            this.result.outcomeTitle = 'fail';
            this.result.outcomeType = 'options';
            this.result.outcomeAction = 'morph';

            this.result.outcomeValue = 1;

            List<ActionOutcome> possibleOutcomes = [
              ActionOutcome(name: 'bug', selected: false),
              ActionOutcome(name: 'turtle', selected: false),
              ActionOutcome(name: 'monkey', selected: false),
              ActionOutcome(name: 'fish', selected: false),
              ActionOutcome(name: 'chameleon', selected: false),
              ActionOutcome(name: 'frog', selected: false),
            ];
            this.result.outcomeOptions = possibleOutcomes;
            this.result.outcomeOptions.shuffle();
            while (this.result.outcomeOptions.length > 3) {
              this.result.outcomeOptions.removeLast();
            }
          }
        }
        break;
      case 'illusion':
        {
          if (this.result.total >= 10) {
            //10+
            this.result.outcomeTitle = 'success';
            this.result.outcomeType = 'options';
            this.result.outcomeAction = 'illusion';

            this.result.outcomeValue = 1;

            List<ActionOutcome> possibleOutcomes = [
              ActionOutcome(name: 'large creature', selected: false),
              ActionOutcome(name: 'group of people', selected: false),
              ActionOutcome(name: 'structure', selected: false),
              ActionOutcome(name: 'objects', selected: false),
              ActionOutcome(name: 'obstacle', selected: false),
              ActionOutcome(name: 'animals', selected: false),
            ];
            this.result.outcomeOptions = possibleOutcomes;
            this.result.outcomeOptions.shuffle();
            while (this.result.outcomeOptions.length > 3) {
              this.result.outcomeOptions.removeLast();
            }
          } else if (this.result.total >= 7 && this.result.total <= 9) {
            //7-9
            this.result.outcomeTitle = 'half success';
            this.result.outcomeType = 'options';
            this.result.outcomeAction = ' illusion';

            this.result.outcomeValue = 1;

            List<ActionOutcome> possibleOutcomes = [
              ActionOutcome(name: 'person', selected: false),
              ActionOutcome(name: 'animals', selected: false),
              ActionOutcome(name: 'objects', selected: false),
              ActionOutcome(name: 'light', selected: false),
              ActionOutcome(name: 'sound', selected: false),
              ActionOutcome(name: 'small creature', selected: false),
            ];
            this.result.outcomeOptions = possibleOutcomes;
            this.result.outcomeOptions.shuffle();
            while (this.result.outcomeOptions.length > 3) {
              this.result.outcomeOptions.removeLast();
            }
          } else {
            //6-
            List<ActionOutcome> possibleOutcomes = [
              ActionOutcome(description: 'People see through your  illusions.'),
              ActionOutcome(
                  description:
                      'Someone touchs your  illusion and gets confused.'),
              ActionOutcome(description: 'You loose control.'),
              ActionOutcome(description: 'You release a loud noise.'),
              ActionOutcome(description: 'You release a blinding light.'),
            ];
            this.result.color = Colors.red;
            this.result.outcomeTitle = 'fail';
            this.result.outcomeType = 'text';

            this.result.outcomeText =
                '${possibleOutcomes[Random().nextInt(possibleOutcomes.length)].description}';
          }
        }
        break;
      case 'fire bomb':
        {
          if (this.result.total >= 10) {
            //10+
            this.result.outcomeTitle = 'success';
            this.result.outcomeType = 'secondRoll';
            this.result.outcomeAction = 'damage';
            this.result.outcomeText = 'You hit the target';

            this.result.outcomeValue = 2;
            this.result.outcomeBonus = this.widget.player.mDamageTotal;
          } else if (this.result.total >= 7 && this.result.total <= 9) {
            //7-9
            this.result.outcomeTitle = 'half success';
            this.result.outcomeType = 'secondRoll';
            this.result.outcomeAction = 'damage';
            this.result.outcomeText = 'You hit the target.';

            this.result.outcomeValue = 1;
            this.result.outcomeBonus = this.widget.player.mDamageTotal;
          } else {
            //6-
            List<ActionOutcome> possibleOutcomes = [
              ActionOutcome(
                  description: 'You miss and the enemy takes an action.'),
              ActionOutcome(
                  description:
                      'You miss and the explosion creates a new obstacle'),
            ];

            this.result.color = Colors.red;
            this.result.outcomeTitle = 'fail';
            this.result.outcomeType = 'text';

            this.result.outcomeText =
                '${possibleOutcomes[Random().nextInt(possibleOutcomes.length)].description}';
          }
        }
        break;
      case 'smoke bomb':
        {
          if (this.result.total >= 10) {
            //10+
            this.result.outcomeTitle = 'success';
            this.result.outcomeType = 'text';

            this.result.outcomeText =
                'You hit the target and create a cloud of smoke.';
          } else if (this.result.total >= 7 && this.result.total <= 9) {
            //7-9
            List<ActionOutcome> possibleOutcomes = [
              ActionOutcome(
                  description:
                      'It lands near the target and creates a cloud of smoke.'),
              ActionOutcome(
                  description:
                      'You hit the target, but the effect is a litte weaker.'),
            ];
            this.result.outcomeTitle = 'half success';
            this.result.outcomeType = 'text';

            this.result.outcomeText =
                '${possibleOutcomes[Random().nextInt(possibleOutcomes.length)].description}';
          } else {
            //6-
            List<ActionOutcome> possibleOutcomes = [
              ActionOutcome(
                  description: 'You miss and the enemy takes an action.'),
              ActionOutcome(
                  description:
                      'You miss and the explosion creates a new obstacle'),
              ActionOutcome(
                  description:
                      'It falls from your hand and lands on your feet.'),
            ];
            this.result.color = Colors.red;
            this.result.outcomeTitle = 'fail';
            this.result.outcomeType = 'text';

            this.result.outcomeText =
                '${possibleOutcomes[Random().nextInt(possibleOutcomes.length)].description}';
          }
        }
        break;
      case 'ice bomb':
        {
          if (this.result.total >= 10) {
            //10+
            this.result.outcomeTitle = 'success';
            this.result.outcomeType = 'text';

            this.result.outcomeText =
                'You hit the target and freeze everything around it.';
          } else if (this.result.total >= 7 && this.result.total <= 9) {
            //7-9
            List<ActionOutcome> possibleOutcomes = [
              ActionOutcome(
                  description:
                      'It lands near the target and freeze everything around it.'),
              ActionOutcome(
                  description:
                      'You hit the target, but the effect is a litte weaker.'),
            ];
            this.result.outcomeTitle = 'half success';
            this.result.outcomeType = 'text';

            this.result.outcomeText =
                '${possibleOutcomes[Random().nextInt(possibleOutcomes.length)].description}';
          } else {
            //6-
            List<ActionOutcome> possibleOutcomes = [
              ActionOutcome(
                  description: 'You miss and the enemy takes an action.'),
              ActionOutcome(
                  description:
                      'You miss and the explosion creates a new obstacle'),
              ActionOutcome(
                  description:
                      'It falls from your hand and lands on your feet.'),
            ];
            this.result.color = Colors.red;
            this.result.outcomeTitle = 'fail';
            this.result.outcomeType = 'text';

            this.result.outcomeText =
                '${possibleOutcomes[Random().nextInt(possibleOutcomes.length)].description}';
          }
        }
        break;

      case 'dig':
        {
          if (this.result.total >= 10) {
            //10+
            this.result.outcomeTitle = 'success';
            this.result.outcomeType = 'text';

            this.result.outcomeText = 'You dig a hole.';
          } else if (this.result.total >= 7 && this.result.total <= 9) {
            //7-9
            List<ActionOutcome> possibleOutcomes = [
              ActionOutcome(description: 'You dig a small hole.'),
              ActionOutcome(description: 'You dig a hole near you.'),
            ];
            this.result.outcomeTitle = 'half success';
            this.result.outcomeType = 'text';

            this.result.outcomeText =
                '${possibleOutcomes[Random().nextInt(possibleOutcomes.length)].description}';
          } else {
            //6-
            List<ActionOutcome> possibleOutcomes = [
              ActionOutcome(
                  description: 'You loose control and destroy something.'),
              ActionOutcome(
                  description:
                      'You loose control and the enemy takes an action.'),
              ActionOutcome(
                  description: 'You loose control and put a friend in a hole.'),
              ActionOutcome(
                  description: 'You loose control and get stuck in a hole.'),
            ];
            this.result.color = Colors.red;
            this.result.outcomeTitle = 'fail';
            this.result.outcomeType = 'text';

            this.result.outcomeText =
                '${possibleOutcomes[Random().nextInt(possibleOutcomes.length)].description}';
          }
        }
        break;
      case 'hold':
        {
          if (this.result.total >= 10) {
            //10+
            this.result.outcomeTitle = 'success';
            this.result.outcomeType = 'text';

            this.result.outcomeText = 'You hold them.';
          } else if (this.result.total >= 7 && this.result.total <= 9) {
            //7-9

            this.result.outcomeTitle = 'half success';
            this.result.outcomeType = 'text';

            this.result.outcomeText = 'You hold one of their arms or legs.';
          } else {
            //6-
            List<ActionOutcome> possibleOutcomes = [
              ActionOutcome(description: 'They escape and take an action.'),
              ActionOutcome(description: 'You loose control and it backfires.'),
              ActionOutcome(
                  description: 'You loose control and hold a friend.'),
              ActionOutcome(
                  description: 'You loose control and  create new obstacle.'),
            ];
            this.result.color = Colors.red;
            this.result.outcomeTitle = 'fail';
            this.result.outcomeType = 'text';

            this.result.outcomeText =
                '${possibleOutcomes[Random().nextInt(possibleOutcomes.length)].description}';
          }
        }
        break;
      case 'build':
        {
          if (this.result.total >= 10) {
            //10+
            this.result.outcomeTitle = 'success';
            this.result.outcomeType = 'options';
            this.result.outcomeAction = 'build';

            this.result.outcomeValue = 1;

            List<ActionOutcome> possibleOutcomes = [
              ActionOutcome(name: 'full cover', selected: false),
              ActionOutcome(name: 'large structure', selected: false),
              ActionOutcome(name: 'furniture', selected: false),
              ActionOutcome(name: 'large obstacle', selected: false),
              ActionOutcome(name: 'path', selected: false),
              ActionOutcome(name: 'trap', selected: false),
            ];
            this.result.outcomeOptions = possibleOutcomes;
            this.result.outcomeOptions.shuffle();
            while (this.result.outcomeOptions.length > 3) {
              this.result.outcomeOptions.removeLast();
            }
          } else if (this.result.total >= 7 && this.result.total <= 9) {
            //7-9
            this.result.outcomeTitle = 'half success';
            this.result.outcomeType = 'options';
            this.result.outcomeAction = 'build';

            this.result.outcomeValue = 1;

            List<ActionOutcome> possibleOutcomes = [
              ActionOutcome(name: 'half cover', selected: false),
              ActionOutcome(name: 'structure', selected: false),
              ActionOutcome(name: 'furniture', selected: false),
              ActionOutcome(name: 'obstacle', selected: false),
              ActionOutcome(name: 'opening', selected: false),
              ActionOutcome(name: 'small trap', selected: false),
            ];
            this.result.outcomeOptions = possibleOutcomes;
            this.result.outcomeOptions.shuffle();
            while (this.result.outcomeOptions.length > 3) {
              this.result.outcomeOptions.removeLast();
            }
          } else {
            //6-
            List<ActionOutcome> possibleOutcomes = [
              ActionOutcome(
                  description: 'You loose control and destroy something.'),
              ActionOutcome(
                  description:
                      'You have to concentrate and the enemy takes an action.'),
              ActionOutcome(
                  description: 'You loose control and lock a friend.'),
              ActionOutcome(description: 'You loose control and it backfires'),
            ];
            this.result.color = Colors.red;
            this.result.outcomeTitle = 'fail';
            this.result.outcomeType = 'text';

            this.result.outcomeText =
                '${possibleOutcomes[Random().nextInt(possibleOutcomes.length)].description}';
          }
        }
        break;
      case 'destroy':
        {
          if (this.result.total >= 10) {
            //10+
            this.result.outcomeTitle = 'success';
            this.result.outcomeType = 'text';

            this.result.outcomeText = 'You destroy a structure.';
          } else if (this.result.total >= 7 && this.result.total <= 9) {
            //7-9

            this.result.outcomeTitle = 'half success';
            this.result.outcomeType = 'text';

            this.result.outcomeText = 'You destroy half of it.';
          } else {
            //6-
            List<ActionOutcome> possibleOutcomes = [
              ActionOutcome(
                  description:
                      'You create an explosion around you that sends everyone flying.'),
              ActionOutcome(
                  description:
                      'You destroy the wrong thing and create an obstacle.'),
            ];
            this.result.color = Colors.red;
            this.result.outcomeTitle = 'fail';
            this.result.outcomeType = 'text';

            this.result.outcomeText =
                '${possibleOutcomes[Random().nextInt(possibleOutcomes.length)].description}';
          }
        }
        break;
      case 'transform':
        {
          if (this.result.total >= 10) {
            //10+
            this.result.outcomeTitle = 'success';
            this.result.outcomeType = 'text';

            this.result.outcomeText = 'You transform into someone else.';
          } else if (this.result.total >= 7 && this.result.total <= 9) {
            //7-9
            List<ActionOutcome> possibleOutcomes = [
              ActionOutcome(
                  description: 'Your voice become like someone\'s elses.'),
              ActionOutcome(
                  description: 'Your appearance become like someone\'s elses.'),
            ];
            this.result.outcomeTitle = 'half success';
            this.result.outcomeType = 'text';

            this.result.outcomeText =
                '${possibleOutcomes[Random().nextInt(possibleOutcomes.length)].description}';
          } else {
            //6-
            List<ActionOutcome> possibleOutcomes = [
              ActionOutcome(description: 'You become a little kid.'),
              ActionOutcome(description: 'You become an old lady.'),
              ActionOutcome(description: 'You become blind.'),
              ActionOutcome(description: 'You make a loud noise.'),
            ];
            this.result.color = Colors.red;
            this.result.outcomeTitle = 'fail';
            this.result.outcomeType = 'text';

            this.result.outcomeText =
                '${possibleOutcomes[Random().nextInt(possibleOutcomes.length)].description}';
          }
        }
        break;
      case 'bless':
        {
          if (this.result.total >= 10) {
            //10+
            this.result.outcomeTitle = 'success';
            this.result.outcomeType = 'options';
            this.result.outcomeAction = 'enhance';

            this.result.outcomeValue = 2;

            List<ActionOutcome> possibleOutcomes = [
              ActionOutcome(name: 'night vision', selected: false),
              ActionOutcome(name: 'charisma', selected: false),
              ActionOutcome(name: 'x-ray vision', selected: false),
              ActionOutcome(name: 'ultrasonic hearing', selected: false),
              ActionOutcome(name: 'speed', selected: false),
              ActionOutcome(name: 'power', selected: false),
              ActionOutcome(name: 'climb', selected: false),
              ActionOutcome(name: 'fly', selected: false),
              ActionOutcome(name: 'breath underwater', selected: false),
              ActionOutcome(name: 'thick skin', selected: false),
              ActionOutcome(name: 'super strenght', selected: false),
              ActionOutcome(name: 'super jump', selected: false),
            ];
            this.result.outcomeOptions = possibleOutcomes;
            this.result.outcomeOptions.shuffle();
            while (this.result.outcomeOptions.length > 5) {
              this.result.outcomeOptions.removeLast();
            }
          } else if (this.result.total >= 7 && this.result.total <= 9) {
            //7-9
            this.result.outcomeTitle = 'half success';
            this.result.outcomeType = 'options';
            this.result.outcomeAction = 'enhance';

            this.result.outcomeValue = 1;

            List<ActionOutcome> possibleOutcomes = [
              ActionOutcome(name: 'night vision', selected: false),
              ActionOutcome(name: 'charisma', selected: false),
              ActionOutcome(name: 'x-ray vision', selected: false),
              ActionOutcome(name: 'ultrasonic hearing', selected: false),
              ActionOutcome(name: 'speed', selected: false),
              ActionOutcome(name: 'power', selected: false),
              ActionOutcome(name: 'climb', selected: false),
              ActionOutcome(name: 'fly', selected: false),
              ActionOutcome(name: 'breath underwater', selected: false),
              ActionOutcome(name: 'thick skin', selected: false),
              ActionOutcome(name: 'super strenght', selected: false),
              ActionOutcome(name: 'super jump', selected: false),
            ];
            this.result.outcomeOptions = possibleOutcomes;
            this.result.outcomeOptions.shuffle();
            while (this.result.outcomeOptions.length > 3) {
              this.result.outcomeOptions.removeLast();
            }
          } else {
            //6-
            List<ActionOutcome> possibleOutcomes = [
              ActionOutcome(description: 'You become blind.'),
              ActionOutcome(description: 'You make them blind.'),
              ActionOutcome(description: 'You make them numb.'),
              ActionOutcome(
                  description: 'You fail and the enemy takes an action.'),
            ];
            this.result.color = Colors.red;
            this.result.outcomeTitle = 'fail';
            this.result.outcomeType = 'text';

            this.result.outcomeText =
                '${possibleOutcomes[Random().nextInt(possibleOutcomes.length)].description}';
          }
        }
        break;
      case 'curse':
        {
          if (this.result.total >= 10) {
            //10+
            this.result.outcomeTitle = 'success';
            this.result.outcomeType = 'options';
            this.result.outcomeAction = 'curse';

            this.result.outcomeValue = 2;

            List<ActionOutcome> possibleOutcomes = [
              ActionOutcome(name: 'weak', selected: false),
              ActionOutcome(name: 'vulnerable', selected: false),
              ActionOutcome(name: 'blind', selected: false),
              ActionOutcome(name: 'mute', selected: false),
              ActionOutcome(name: 'numb', selected: false),
              ActionOutcome(name: 'deaf', selected: false),
              ActionOutcome(name: 'paralized', selected: false),
              ActionOutcome(name: 'charm', selected: false),
              ActionOutcome(name: 'forget', selected: false),
              ActionOutcome(name: 'scared', selected: false),
              ActionOutcome(name: 'slow', selected: false),
              ActionOutcome(name: 'ugly', selected: false),
            ];
            this.result.outcomeOptions = possibleOutcomes;
            this.result.outcomeOptions.shuffle();
            while (this.result.outcomeOptions.length > 5) {
              this.result.outcomeOptions.removeLast();
            }
          } else if (this.result.total >= 7 && this.result.total <= 9) {
            //7-9
            this.result.outcomeTitle = 'half success';
            this.result.outcomeType = 'options';
            this.result.outcomeAction = 'curse';

            this.result.outcomeValue = 1;

            List<ActionOutcome> possibleOutcomes = [
              ActionOutcome(name: 'weak', selected: false),
              ActionOutcome(name: 'vulnerable', selected: false),
              ActionOutcome(name: 'blind', selected: false),
              ActionOutcome(name: 'mute', selected: false),
              ActionOutcome(name: 'numb', selected: false),
              ActionOutcome(name: 'deaf', selected: false),
              ActionOutcome(name: 'paralized', selected: false),
              ActionOutcome(name: 'charm', selected: false),
              ActionOutcome(name: 'forget', selected: false),
              ActionOutcome(name: 'scared', selected: false),
              ActionOutcome(name: 'slow', selected: false),
              ActionOutcome(name: 'ugly', selected: false),
            ];
            this.result.outcomeOptions = possibleOutcomes;
            this.result.outcomeOptions.shuffle();
            while (this.result.outcomeOptions.length > 3) {
              this.result.outcomeOptions.removeLast();
            }
          } else {
            //6-
            List<ActionOutcome> possibleOutcomes = [
              ActionOutcome(description: 'You become blind.'),
              ActionOutcome(description: 'You make them stronger.'),
              ActionOutcome(description: 'You make them faster.'),
              ActionOutcome(
                  description: 'You fail and the enemy takes an action.'),
            ];
            this.result.color = Colors.red;
            this.result.outcomeTitle = 'fail';
            this.result.outcomeType = 'text';

            this.result.outcomeText =
                '${possibleOutcomes[Random().nextInt(possibleOutcomes.length)].description}';
          }
        }
        break;
    }

    actionResult();
  }

  @override
  Widget build(BuildContext context) {
    if (diceList == null) {
      prepareDice(2);
    }
    if (this.result.outcomeTitle == null) {
      this.result.outcomeTitle = widget.action.name;
    }
    if (this.result.color == null) {
      this.result.color = widget.player.primaryColor;
    }

    return AlertDialog(
        contentPadding: EdgeInsets.fromLTRB(0, 0, 0, 0),
        content: Container(
          color: AppColors.black01,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: this.result.color,
                    width: 1.5, //                   <--- border width here
                  ),
                ),
                width: MediaQuery.of(context).size.width * 0.7,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      color: this.result.color,
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(30, 5, 30, 7),
                        child: Center(
                          child: Text(this.result.outcomeTitle.toUpperCase(),
                              style: AppTextStyles.dialogTitleStyle),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 5, 0, 5),
                      child: Stack(
                        children: <Widget>[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                width: 125 * (this.diceList.length).toDouble(),
                                height: 180,
                                child: ListView.builder(
                                    shrinkWrap: true,
                                    padding:
                                        const EdgeInsets.fromLTRB(0, 0, 0, 0),
                                    scrollDirection: Axis.horizontal,
                                    itemCount: this.diceList.length,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      return GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            tapDie(index);
                                          });
                                        },
                                        child: DiceAnimation(
                                          color: this.result.color,
                                          die: this.diceList[index].die,
                                          lines: this
                                              .diceList[index]
                                              .animationLines,
                                        ),
                                      );
                                    }),
                              ),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(30, 7, 30, 0),
                            child: Center(
                              child: (this.result.sum == null)
                                  ? Container()
                                  : Text(
                                      this.result.sum,
                                      textAlign: TextAlign.justify,
                                      style: TextStyle(
                                        fontFamily: 'Santana',
                                        fontSize: 25.0,
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        letterSpacing: 4,
                                      ),
                                    ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(25, 150, 25, 10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Center(child: outcomeWidget),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ));
  }
}
