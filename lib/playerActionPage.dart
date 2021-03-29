import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:dsixv02app/models/game/dice.dart';

import 'package:flutter_svg/flutter_svg.dart';

import 'models/player/playerAction.dart';
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

  // String displayText;
  // String displayTitle;
  String displaySum = '';
  Widget button;
  List<Dice> diceList = [];
  Dice die = Dice('Roll', 1);
  int bonus;
  Color resultColor;
  String focusText1 = '';
  String focusText2 = '';
  double textSize;

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
    if (displayedAction.focus == true) {
      focusText1 = ' You need to';
      focusText2 = ' focus.';
    } else {
      focusText1 = '';
      focusText2 = '';
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

    if (option.name == 'DAMAGE' || option.name == 'PROTECT') {
      bonus = option.value;
      result += bonus;
      displaySum = '${result - bonus} + $bonus = $result';
      option.resultText = '${option.success} $result damage.';
      textSize = 1.25;
      return;
    }

    bonus = displayedAction.value;

    result += bonus;
    displaySum = '${result - bonus} + $bonus = $result';

    widget.dsix.getCurrentPlayer().action(displayedAction.focus, option);

    option.useOption(result);

    if (option.name == 'FAIL') {
      resultColor = Colors.red;
      textSize = 1.25;
    } else if (option.name == 'SUCCESS') {
      if (option.result != '') {
        resultColor = Colors.green;
        rollButton(2, option);
      } else {
        resultColor = Colors.green;
        textSize = 1.25;
      }
    } else if (option.name == 'HALF SUCCESS') {
      if (option.result != '') {
        resultColor = Colors.green;
        rollButton(1, option);
      } else {
        resultColor = Colors.green;
        textSize = 1.25;
      }
    }
  }

  Option newOption;
  List<String> itemList = [];

  void roll(int diceNumber, Option option) {
    // SEE IF ITS FIRST ROLL
    if (option.resultText == '') {
      try {
        if (option.name == 'WEAPON') {
          widget.dsix.getCurrentPlayer().checkWeapon();
        }
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
    }

    //SEE if its LOOT

    if (option.name == 'LOOT') {
      itemList = widget.dsix.getCurrentPlayer().lootResources(diceNumber * 100);
      showAlertDialogLoot(context);
      return;
    }

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

          option.name = option.result;
          roll(diceNumber, option);
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
                                  '${option.name}',
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
                                        option.resultText,
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

//THIS SHOWS THE LOOT
  showAlertDialogLoot(
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
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
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
                          'LOOT',
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
                  padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                  child: Text(
                    '$itemList',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      height: 1.25,
                      fontSize: 19,
                      fontFamily: 'Calibri',
                      color: Colors.white,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(35, 0, 35, 10),
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        Navigator.pop(context);
                      });
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
                                  'assets/ui/check.svg',
                                  color: widget.dsix
                                      .getCurrentPlayer()
                                      .playerColor
                                      .primaryColor,
                                  width:
                                      MediaQuery.of(context).size.width * 0.04,
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

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alerta;
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
                      fontSize: 19,
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
                  child: RichText(
                    textAlign: TextAlign.justify,
                    text: new TextSpan(
                      style: TextStyle(
                        height: 1.3,
                        fontSize: 19,
                        fontFamily: 'Calibri',
                        color: Colors.white,
                      ),
                      children: <TextSpan>[
                        TextSpan(text: displayedAction.description),
                        TextSpan(text: focusText1),
                        TextSpan(
                            text: focusText2,
                            style: new TextStyle(
                                fontWeight: FontWeight.bold,
                                color: widget.dsix
                                    .getCurrentPlayer()
                                    .playerColor
                                    .primaryColor)),
                      ],
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
                            newOption =
                                displayedAction.option[index].copyOption();
                            roll(2, newOption);
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
