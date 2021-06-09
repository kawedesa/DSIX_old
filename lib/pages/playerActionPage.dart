import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:dsixv02app/models/game/dice.dart';

import 'package:flutter_svg/flutter_svg.dart';

import '../models/player/playerAction.dart';
import '../models/player/option.dart';

import 'package:dsixv02app/models/game/dsix.dart';
import '../models/player/exceptions.dart';

class ActionPage extends StatefulWidget {
  final Function() refresh;
  final Function(String) alert;
  final Dsix dsix;

  const ActionPage({Key key, this.dsix, this.refresh, this.alert})
      : super(key: key);

  @override
  _ActionPageState createState() => _ActionPageState();
}

class _ActionPageState extends State<ActionPage> {
  PlayerAction displayedAction = PlayerAction(
    'action',
    'ACTION',
    'These are the actions your character can make in the game. Each one will have a different outcome depending on your luck.',
    [],
    0,
  );

  Widget button;

  Dice die = Dice('Roll', 1);
  List<Dice> diceList;

  Color resultColor;

  double textSize;
  Function(Option option, int numberDice) outcome;
  List<bool> actionSelection;
  int bonus = 0;
  String displaySum = '';
  String title;
  String resultText;
  List<String> itemList = [];

  void checkAction(Option option, int numberDice) {
    widget.dsix.gm.checkTurn();
    widget.refresh();
    if (widget.dsix.gm.getCurrentPlayer().checkTurn()) {
      ScaffoldMessenger.of(context)
          .showSnackBar(widget.alert('Wait for the next turn'));
      return;
    }

    try {
      if (option.name == 'WEAPON') {
        widget.dsix.gm.getCurrentPlayer().checkWeapon();
      }
    } on NoAmmoException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(widget.alert(e.message));
      return;
    } on NoWeaponException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(widget.alert(e.message));
      return;
    }

    diceList = [];
    for (int i = 0; i < numberDice; i++) {
      diceList.add(die.newDie());
    }

    title = option.name;
    textSize = 0;
    displaySum = '';
    resultText = '';
    button = Container();
    bonus = displayedAction.value;
    resultColor = widget.dsix.gm.getCurrentPlayer().playerColor.primaryColor;
    showAlertDialogAction(context, option);
  }

  void decideOutcome(Option option, int numberDice) {
    bonus = 0;
    button = GestureDetector(
      onTap: () {
        setState(() {
          Navigator.pop(context);
          switch (option.name) {
            case 'PUNCH':
              {
                newRoll(option, numberDice);
              }
              break;

            case 'WEAPON':
              {
                bonus = widget.dsix.gm.getCurrentPlayer().pDamage;
                bonus += widget.dsix.gm.getCurrentPlayer().mDamage;
                newRoll(option, numberDice);
              }
              break;

            case 'DEFEND':
              {
                bonus = widget.dsix.gm.getCurrentPlayer().pArmor;
                newRoll(option, numberDice);
              }
              break;

            case 'RESIST':
              {
                bonus = widget.dsix.gm.getCurrentPlayer().mArmor;
                newRoll(option, numberDice);
              }
              break;

            case 'RESOURCES':
              {
                itemList =
                    widget.dsix.gm.getCurrentPlayer().resources(numberDice);
                showOutcome(option, numberDice);
              }
              break;

            case 'MORPH':
              {
                itemList = [
                  'SWIM\n',
                  'FLY\n',
                  'DIG\n',
                  'SPEED\n',
                  'PERCEPTION\n',
                  'STRENGH\n',
                  'THORNS\n',
                  'RANGE\n',
                  'SWALLOW\n',
                  'CLIMB\n',
                  'RESISTANCE\n',
                  'PROTECTION\n',
                  'POISON\n',
                  'JUMP\n',
                ];
                showOutcome(option, numberDice);
              }
              break;

            case 'ILLUSION':
              {
                itemList = [
                  'SIGHT\n',
                  'HEARING\n',
                  'TOUCH\n',
                  'SMELL\n',
                  'TASTE\n'
                ];
                showOutcome(option, numberDice);
              }
              break;

            case 'FIRE BOMB':
              {
                bonus = widget.dsix.gm.getCurrentPlayer().mDamage;
                newRoll(option, numberDice);
              }
              break;

            case 'STRIKE':
              {
                bonus = widget.dsix.gm.getCurrentPlayer().mDamage;
                newRoll(option, numberDice);
              }
              break;
            case 'BARRIER':
              {
                bonus = widget.dsix.gm.getCurrentPlayer().mArmor;
                newRoll(option, numberDice);
              }
              break;
            case 'ENHANCE':
              {
                itemList = [
                  'SIGHT\n',
                  'HEARING\n',
                  'TOUCH\n',
                  'SMELL\n',
                  'TASTE\n'
                ];
                showOutcome(option, numberDice);
              }
              break;
            case 'REMOVE':
              {
                itemList = [
                  'SIGHT\n',
                  'HEARING\n',
                  'TOUCH\n',
                  'SMELL\n',
                  'TASTE\n'
                ];

                showOutcome(option, numberDice);
              }
              break;
          }
          widget.refresh();
        });
      },
      child: Container(
        height: MediaQuery.of(context).size.height * 0.058,
        width: double.infinity,
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.green,
            width: 2, //                   <--- border width here
          ),
        ),
        child: Stack(
          alignment: AlignmentDirectional.centerEnd,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 0, 10, 0),
                  child: SvgPicture.asset(
                    'assets/ui/action.svg',
                    color: Colors.green,
                    width: MediaQuery.of(context).size.width * 0.04,
                  ),
                ),
              ],
            ),
            Center(
              child: Text(
                option.outcome,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.5,
                  fontFamily: 'Calibri',
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<bool> outcomeList;
  void showOutcome(Option option, int numberDice) {
    outcomeList = [];
    itemList.forEach((element) {
      outcomeList.add(false);
    });
    textSize = 1.25;
    if (numberDice > 1) {
      resultText = option.success;
      outcomeNumberOptions = 2;
    } else {
      resultText = option.halfSuccess;
      outcomeNumberOptions = 1;
    }
    showAlertDialogOutcome(context, option);
  }

  int outcomeNumberOptions;
  void chooseOutcome(Option option, int numberDice, int index) {
    if (outcomeNumberOptions > 0) {
      if (outcomeList[index]) {
        outcomeNumberOptions++;
        outcomeList[index] = false;
      } else {
        outcomeNumberOptions--;
        outcomeList[index] = true;
      }
    } else {
      if (outcomeList[index]) {
        outcomeNumberOptions++;
        outcomeList[index] = false;
      }
    }
  }

  void newRoll(Option option, int numberDice) {
    diceList = [];
    for (int i = 0; i < numberDice; i++) {
      diceList.add(die.newDie());
    }
    displaySum = '';
    title = option.outcome;
    button = Container();
    resultColor = widget.dsix.gm.getCurrentPlayer().playerColor.primaryColor;
    showAlertDialogAction(context, option);
  }

  void checkResult(List<Dice> dice, Option option) {
    for (int check = 0; check < diceList.length; check++) {
      if (diceList[check].dice == 'Roll') {
        return;
      }
    }

    int partialResult = 0;
    int totalResult = 0;

    diceList.forEach((element) {
      partialResult += int.parse(element.dice);
    });

    totalResult = partialResult + bonus;
    displaySum = '$partialResult + $bonus = $totalResult';

    if (option.firstRoll) {
      widget.dsix.gm.getCurrentPlayer().action(option);

      if (totalResult < 7) {
        resultColor = Colors.red;
        title = 'FAIL';
        textSize = 1.25;
        resultText = option.fail;
        option.newRoll = false;
      } else if (totalResult > 9) {
        resultColor = Colors.green;
        title = 'SUCCESS';

        if (option.newRoll) {
          option.newRoll = false;
          decideOutcome(option, 2);
          return;
        }
        textSize = 1.25;
        resultText = option.success;
      } else {
        resultColor = Colors.green;
        title = 'HALF SUCCESS';
        if (option.newRoll) {
          option.newRoll = false;
          decideOutcome(option, 1);
          return;
        }
      }
    } else {
      textSize = 1.25;
      if (totalResult > 9) {
        resultText = option.success;
      } else {
        resultText = option.halfSuccess;
      }
    }
  }

// NEW DICE ROLL MENU
  showAlertDialogAction(BuildContext context, Option option) {
    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              backgroundColor: Colors.black,
              contentPadding: EdgeInsets.fromLTRB(0, 0, 0, 0),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: resultColor,
                        width: 2.5, //                   <--- border width here
                      ),
                    ),
                    width: 200 + 50 * (diceList.length).toDouble(),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          color: resultColor,
                          child: Container(
                            child: Center(
                              child: Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(30, 5, 30, 7),
                                child: Text(
                                  '$title',
                                  style: TextStyle(
                                    fontFamily: 'Headline',
                                    height: 1.3,
                                    fontSize: 25.0,
                                    color: Colors.white,
                                    letterSpacing: 2,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                          child: Stack(
                            children: <Widget>[
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    width: 125 * (diceList.length).toDouble(),
                                    height: 180,
                                    child: ListView.builder(
                                        shrinkWrap: true,
                                        padding: const EdgeInsets.fromLTRB(
                                            0, 0, 0, 0),
                                        scrollDirection: Axis.horizontal,
                                        itemCount: diceList.length,
                                        itemBuilder:
                                            (BuildContext context, int index) {
                                          return TextButton(
                                            style: TextButton.styleFrom(
                                              padding:
                                                  const EdgeInsets.fromLTRB(
                                                      0, 0, 0, 0),
                                            ),
                                            onPressed: () {
                                              setState(() {
                                                diceList[index].rollDice();
                                                checkResult(diceList, option);
                                              });
                                              widget.refresh();
                                            },
                                            child: SizedBox(
                                              width: 125,
                                              child: Stack(
                                                children: <Widget>[
                                                  AnimatedOpacity(
                                                    curve: Curves.easeInOutExpo,
                                                    opacity: diceList[index]
                                                        .animationLines,
                                                    duration: Duration(
                                                        milliseconds: 300),
                                                    child: FlareActor(
                                                      'assets/animation/line.flr',
                                                      fit: BoxFit.fitHeight,
                                                      animation: 'Lines',
                                                      color: widget.dsix.gm
                                                          .getCurrentPlayer()
                                                          .playerColor
                                                          .primaryColor,
                                                    ),
                                                  ),
                                                  FlareActor(
                                                    'assets/animation/dice.flr',
                                                    fit: BoxFit.fitHeight,
                                                    animation:
                                                        diceList[index].dice,
                                                    color: Colors.white,
                                                  ),
                                                ],
                                              ),
                                            ),
                                          );
                                        }),
                                  ),
                                ],
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(30, 5, 30, 0),
                                child: Center(
                                  child: Text(
                                    displaySum,
                                    textAlign: TextAlign.justify,
                                    style: TextStyle(
                                      fontFamily: 'Headline',
                                      fontSize: 25.0,
                                      color: Colors.white,
                                      letterSpacing: 4,
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(35, 150, 35, 10),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Center(
                                      child: Text(
                                        resultText,
                                        textAlign: TextAlign.justify,
                                        style: TextStyle(
                                          height: textSize,
                                          fontSize: 19,
                                          fontFamily: 'Calibri',
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding:
                                          const EdgeInsets.fromLTRB(5, 0, 5, 0),
                                      child: button,
                                    ),
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
            );
          },
        );
      },
    );
  }

//THIS SHOWS THE SECONDROLL

  showAlertDialogOutcome(BuildContext context, Option option) {
    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              backgroundColor: Colors.black,
              contentPadding: EdgeInsets.fromLTRB(0, 0, 0, 0),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: widget.dsix.gm
                            .getCurrentPlayer()
                            .playerColor
                            .primaryColor,
                        width: 1.5, //                   <--- border width here
                      ),
                    ),
                    width: 300,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Container(
                          color: widget.dsix.gm
                              .getCurrentPlayer()
                              .playerColor
                              .primaryColor,
                          width: double.infinity,
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(30, 5, 30, 7),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Text(
                                  '${option.outcome}',
                                  style: TextStyle(
                                    fontFamily: 'Headline',
                                    height: 1.3,
                                    fontSize: 25.0,
                                    color: Colors.white,
                                    letterSpacing: 2,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(35, 15, 35, 15),
                          child: Text(
                            resultText,
                            textAlign: TextAlign.justify,
                            style: TextStyle(
                              height: textSize,
                              fontSize: 19,
                              fontFamily: 'Calibri',
                              color: Colors.white,
                            ),
                          ),
                        ),
                        Divider(
                          height: 0,
                          thickness: 2,
                          color: widget.dsix.gm
                              .getCurrentPlayer()
                              .playerColor
                              .primaryColor,
                        ),
                        Padding(
                          padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                          child: Container(
                            height: (itemList.length < 6)
                                ? MediaQuery.of(context).size.height *
                                    0.058 *
                                    itemList.length
                                : MediaQuery.of(context).size.height *
                                    0.058 *
                                    6,
                            child: ListView.builder(
                                shrinkWrap: true,
                                itemCount: itemList.length,
                                itemBuilder: (BuildContext context, int index) {
                                  return Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            chooseOutcome(option,
                                                outcomeNumberOptions, index);
                                          });
                                        },
                                        child: Container(
                                          width: double.infinity,
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.058,
                                          color: outcomeList[index]
                                              ? widget.dsix.gm
                                                  .getCurrentPlayer()
                                                  .playerColor
                                                  .primaryColor
                                              : Colors.black,
                                          child: Padding(
                                            padding: const EdgeInsets.fromLTRB(
                                                0, 7.5, 0, 0),
                                            child: Center(
                                              child: Text(
                                                '${itemList[index]}',
                                                style: TextStyle(
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.bold,
                                                  letterSpacing: 1.5,
                                                  fontFamily: 'Calibri',
                                                  color: Colors.white,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      Divider(
                                        height: 0,
                                        thickness: 2,
                                        color: widget.dsix.gm
                                            .getCurrentPlayer()
                                            .playerColor
                                            .primaryColor,
                                      ),
                                    ],
                                  );
                                }),
                          ),
                        ),
                        Divider(
                          height: 0,
                          thickness: 2,
                          color: widget.dsix.gm
                              .getCurrentPlayer()
                              .playerColor
                              .primaryColor,
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(35, 15, 35, 15),
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                Navigator.pop(context);
                              });
                            },
                            child: Container(
                              height:
                                  MediaQuery.of(context).size.height * 0.058,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: widget.dsix.gm
                                      .getCurrentPlayer()
                                      .playerColor
                                      .primaryColor,
                                  width:
                                      2, //                   <--- border width here
                                ),
                              ),
                              child: Stack(
                                alignment: AlignmentDirectional.centerEnd,
                                children: [
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                            0, 0, 10, 0),
                                        child: SvgPicture.asset(
                                          'assets/ui/check.svg',
                                          color: widget.dsix.gm
                                              .getCurrentPlayer()
                                              .playerColor
                                              .primaryColor,
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.04,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Center(
                                    child: Text(
                                      'CONFIRM',
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                        letterSpacing: 1.5,
                                        fontFamily: 'Calibri',
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    //ACTION SELECTION
    actionSelection = [];
    widget.dsix.gm.getCurrentPlayer().playerAction.forEach((element) {
      if (element == displayedAction) {
        actionSelection.add(true);
      } else {
        actionSelection.add(false);
      }
    });

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Container(
          height: MediaQuery.of(context).size.height * 0.1,
          width: double.infinity,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(5, 2.5, 10, 0),
            child: Stack(
              children: <Widget>[
                //ACTION VALUE

                GridView.count(
                  crossAxisCount: 6,
                  children: List.generate(6, (index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 5),
                      child: SvgPicture.asset(
                        'assets/player/action/${widget.dsix.gm.getCurrentPlayer().playerAction[index + 1].value}.svg',
                        color: Colors.white,
                      ),
                    );
                  }),
                ),
                //ACTION ICON

                GridView.count(
                  crossAxisCount: 6,
                  children: List.generate(6, (index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 17),
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            displayedAction = widget.dsix.gm
                                .getCurrentPlayer()
                                .playerAction[index + 1];
                          });
                        },
                        child: SvgPicture.asset(
                          'assets/player/action/${widget.dsix.gm.getCurrentPlayer().playerAction[index + 1].icon}.svg',
                          color: actionSelection[index + 1]
                              ? widget.dsix.gm
                                  .getCurrentPlayer()
                                  .playerColor
                                  .primaryColor
                              : Colors.white,
                        ),
                      ),
                    );
                  }),
                ),
              ],
            ),
          ),
        ),
        Divider(
          height: 0,
          thickness: 2,
          color: widget.dsix.gm.getCurrentPlayer().playerColor.primaryColor,
        ),
        Expanded(
          flex: 13,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(65, 15, 65, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                  child: Text(
                    displayedAction.name,
                    style: TextStyle(
                      fontFamily: 'Headline',
                      height: 1.3,
                      fontSize: 45,
                      color: widget.dsix.gm
                          .getCurrentPlayer()
                          .playerColor
                          .primaryColor,
                      letterSpacing: 2,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 10, 0, 5),
                  child: RichText(
                    textAlign: TextAlign.justify,
                    text: new TextSpan(
                      style: TextStyle(
                        height: 1.3,
                        fontSize: 18,
                        fontFamily: 'Calibri',
                        color: Colors.white,
                      ),
                      children: <TextSpan>[
                        TextSpan(text: displayedAction.description),
                      ],
                    ),
                  ),
                ),
                ListView.builder(
                    shrinkWrap: true,
                    padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                    itemCount: displayedAction.option.length,
                    itemBuilder: (BuildContext context, int index) {
                      return GestureDetector(
                        onTap: () {
                          checkAction(
                              displayedAction.option[index].copyOption(), 2);
                        },
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(0, 5, 0, 0),
                          child: Container(
                            height: MediaQuery.of(context).size.height * 0.058,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: widget.dsix.gm
                                    .getCurrentPlayer()
                                    .playerColor
                                    .primaryColor,
                                width:
                                    2, //                   <--- border width here
                              ),
                            ),
                            child: Stack(
                              alignment: AlignmentDirectional.centerEnd,
                              children: [
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          0, 0, 10, 0),
                                      child: SvgPicture.asset(
                                        'assets/ui/action.svg',
                                        color: widget.dsix.gm
                                            .getCurrentPlayer()
                                            .playerColor
                                            .primaryColor,
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.04,
                                      ),
                                    ),
                                  ],
                                ),
                                Center(
                                  child: Text(
                                    displayedAction.option[index].name,
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      letterSpacing: 1.5,
                                      fontFamily: 'Calibri',
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    }),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
