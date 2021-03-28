import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:dsixv02app/models/game/dice.dart';

import 'package:flutter_svg/flutter_svg.dart';

import 'playerAction.dart';
import 'option.dart';

import 'package:dsixv02app/models/game/dsix.dart';
import 'models/player/exceptions.dart';

class ActionPage extends StatefulWidget {
  final Function() refresh;
  final Dsix dsix;

  const ActionPage({Key key, this.dsix, this.refresh}) : super(key: key);

  @override
  _ActionPageState createState() => _ActionPageState();
}

class _ActionPageState extends State<ActionPage> {
  List<String> selectedAction = [
    'null',
    'null',
    'null',
    'null',
    'null',
    'null',
  ];

  PlayerAction displayedAction = PlayerAction(
      'action',
      'ACTION',
      'These are the actions your character can make in the game. Each one will have a different outcome depending on your luck.',
      [],
      0,
      false);

  void actionSelection(index) {
    selectedAction = [
      'null',
      'null',
      'null',
      'null',
      'null',
      'null',
    ];
    selectedAction.replaceRange(index - 1, index,
        [widget.dsix.getCurrentPlayer().playerAction[index].icon]);
    displayedAction = widget.dsix.getCurrentPlayer().playerAction[index];
  }

  String displayText;
  String displayTitle;
  String displaySum = '';
  Widget button;
  List<Dice> diceList = [];
  Dice die = Dice('Roll', 1);
  int bonus;
  Color resultColor;

  double textSize;

  void playerAction(bool focus, Option option) {
    widget.dsix.getCurrentPlayer().effects();
    widget.dsix.getCurrentPlayer().actionsTaken++;
    widget.dsix.getCurrentPlayer().focus(displayedAction.focus);
    if (option.name == 'WEAPON') {
      widget.dsix.getCurrentPlayer().reduceAmmo();
    }
  }

  void checkResult(List<Dice> dice, Option option) {
    for (int check = 0; check < diceList.length; check++) {
      if (diceList[check].dice == 'Roll') {
        return;
      }
    }

    int result = 0;

    for (int check = 0; check < diceList.length; check++) {
      result += int.parse(diceList[check].dice);
    }

    if (option.name == displayTitle) {
      result += displayedAction.value;

      displaySum =
          '${result - displayedAction.value} + ${displayedAction.value} = $result';

      bonus = result;

      if (result < 7) {
        textSize = 1.25;
        displayText = option.fail;
        displayTitle = 'FAIL';
        resultColor = Colors.red;
        playerAction(displayedAction.focus, option);

        return;
      } else if (result > 9) {
        displayTitle = 'SUCCESS';
        if (option.result != '') {
          rollButton(2, option);
          resultColor = Colors.green;
          playerAction(displayedAction.focus, option);
          return;
        } else {
          textSize = 1.25;
          displayText = option.success;
          resultColor = Colors.green;
          playerAction(displayedAction.focus, option);
          return;
        }
      } else {
        displayTitle = 'HALF SUCCESS';
        if (option.result != '') {
          rollButton(1, option);
          resultColor = Colors.green;
          playerAction(displayedAction.focus, option);

          return;
        } else {
          textSize = 1.25;
          displayText = option.halfSuccess;
          resultColor = Colors.green;
          playerAction(displayedAction.focus, option);

          return;
        }
      }
    } else {
      if (displayTitle == 'FAIL' ||
          displayTitle == 'HALF SUCCESS' ||
          displayTitle == 'SUCCESS') {
        return;
      }
      result += option.value;
      displaySum = '${result - option.value} + ${option.value} = $result';
      textSize = 1.25;
      displayText = '${option.success}';
    }
  }

  void roll(int diceNumber, String title, Option option) {
    try {
      bool withWeapon = false;
      switch (displayedAction.name) {
        case 'ATTACK':
          if (option.name == 'WEAPON') {
            withWeapon = true;
          }

          break;
      }

      widget.dsix.getCurrentPlayer().checkWeapon(withWeapon);
    } on NoAmmoException catch (e) {
      alertTitle = e.title;
      alertDescription = e.message;
      showAlertDialogCheckWeapon(context);
      return;
    } on NoWeaponException catch (e) {
      alertTitle = e.title;
      alertDescription = e.message;
      showAlertDialogCheckWeapon(context);
      return;
    }

    bonus = displayedAction.value;
    displayTitle = title;
    displayText = '';
    displaySum = '';
    textSize = 0;
    button = Container();
    resultColor = widget.dsix.getCurrentPlayer().playerColor.primaryColor;

    diceList = [];

    for (int check = 0; check < diceNumber; check++) {
      diceList.add(die.newDice());
    }

    showAlertDialogActionRoll(context, option);
  }

  void rollButton(int diceNumber, Option option) {
    button = GestureDetector(
      onTap: () {
        setState(() {
          Navigator.pop(context);
          roll(diceNumber, option.result, option);
          bonus = option.value;
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
                option.result,
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

  //THIS IS THE POP MENU THAT SHOWS THE DICE AND THE RESULT OF THE ACTION

  showAlertDialogActionRoll(BuildContext context, Option option) {
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
                                  '$displayTitle',
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
                                                      color: widget.dsix
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
                                        displayText,
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

  //THIS IS THE POP MENU THAT TELLS YOU ABOUT EQUIPPED WEAPONS AND AMMO

  String alertTitle;
  String alertDescription;

  showAlertDialogCheckWeapon(
    BuildContext context,
  ) {
    AlertDialog alerta = AlertDialog(
      backgroundColor: Colors.black,
      contentPadding: EdgeInsets.fromLTRB(0, 0, 0, 0),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            decoration: BoxDecoration(
              border: Border.all(
                color: widget.dsix.getCurrentPlayer().playerColor.primaryColor,
                width: 1.5, //                   <--- border width here
              ),
            ),
            width: 300,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Container(
                  color:
                      widget.dsix.getCurrentPlayer().playerColor.primaryColor,
                  width: double.infinity,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(30, 5, 30, 7),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          alertTitle,
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
                  padding: const EdgeInsets.fromLTRB(35, 15, 25, 20),
                  child: Text(
                    alertDescription,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      height: 1.25,
                      fontSize: 22,
                      fontFamily: 'Calibri',
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alerta;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Expanded(
          flex: 2,
          child: Container(
            width: double.infinity,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(5, 5, 10, 0),
              child: Stack(
                children: <Widget>[
                  //ACTION ICON

                  GridView.count(
                    crossAxisCount: 6,
                    children: List.generate(6, (index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 17),
                        child: SvgPicture.asset(
                          'assets/action/${widget.dsix.getCurrentPlayer().playerAction[index + 1].icon}.svg',
                          color: Colors.white,
                          width: MediaQuery.of(context).size.width * 0.055,
                        ),
                      );
                    }),
                  ),

                  //ACTION VALUE

                  GridView.count(
                    crossAxisCount: 6,
                    children: List.generate(6, (index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 5),
                        child: SvgPicture.asset(
                          'assets/action/${widget.dsix.getCurrentPlayer().playerAction[index + 1].value}.svg',
                          color: Colors.white,
                          width: MediaQuery.of(context).size.width * 0.055,
                        ),
                      );
                    }),
                  ),

                  GridView.count(
                    crossAxisCount: 6,
                    children: List.generate(6, (index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 17),
                        child: TextButton(
                          onPressed: () {
                            setState(() {
                              actionSelection(index + 1);
                            });
                          },
                          style: TextButton.styleFrom(
                            padding: EdgeInsets.all(0),
                          ),
                          child: SvgPicture.asset(
                            'assets/action/${selectedAction[index]}.svg',
                            color: widget.dsix
                                .getCurrentPlayer()
                                .playerColor
                                .primaryColor,
                          ),
                        ),
                      );
                    }),
                  ),
                ],
              ),
            ),
          ),
        ),
        Divider(
          height: 0,
          thickness: 2,
          color: widget.dsix.getCurrentPlayer().playerColor.primaryColor,
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
                      color: widget.dsix
                          .getCurrentPlayer()
                          .playerColor
                          .primaryColor,
                      letterSpacing: 2,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 15, 0, 15),
                  child: Text(
                    displayedAction.description,
                    textAlign: TextAlign.justify,
                    style: TextStyle(
                      height: 1.3,
                      fontSize: 19,
                      fontFamily: 'Calibri',
                      color: Colors.white,
                    ),
                  ),
                ),
                Container(
                  height: MediaQuery.of(context).size.height * 0.0 +
                      displayedAction.option.length * 56,
                  child: ListView.builder(
                      padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                      itemCount: displayedAction.option.length,
                      itemBuilder: (BuildContext context, int index) {
                        return TextButton(
                          style: TextButton.styleFrom(
                            padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
                          ),
                          onPressed: () {
                            roll(2, displayedAction.option[index].name,
                                displayedAction.option[index]);
                          },
                          child: Container(
                            height: MediaQuery.of(context).size.height * 0.058,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: widget.dsix
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
                                        color: widget.dsix
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
                        );
                      }),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
