import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:dsixv02app/models/shared/dice.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../models/player/playerAction.dart';
import '../models/player/option.dart';
import 'package:dsixv02app/models/dsix/dsix.dart';
import '../models/shared/exceptions.dart';

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
  PlayerAction displayedAction = PlayerAction();

  Widget button;

  Dice die = Dice('Roll', 1);
  List<Dice> diceList;

  List<bool> actionSelection;
  String displaySum = '';
  String title;

  Color resultColor = Colors.black;
  Widget outcomeWidget = Container();
  Widget actionButton = Container();
  int selectedAction = 1;

  void takeAction(Option option) {
    try {
      widget.dsix.gm.getCurrentPlayer().action(option);
    } on NoAmmoException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(widget.alert(e.message));
      return;
    } on NoWeaponException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(widget.alert(e.message));
      return;
    }

    outcomeWidget = Container();
    actionButton = Container();
    displaySum = '';
    title = option.name;
    resultColor = widget.dsix.gm.getCurrentPlayer().playerColor.primaryColor;

    diceList = [];
    for (int i = 0; i < 2; i++) {
      diceList.add(die.newDie());
    }

    switch (widget.dsix.gm.getCurrentPlayer().result.outcomeType) {
      case '2D6':
        {
          outcomeWidget = GestureDetector(
            onTap: () {
              setState(() {
                Navigator.pop(context);
                secondRoll(2);
                widget.refresh();
              });
            },
            child: Container(
              height: MediaQuery.of(context).size.height * 0.08,
              width: double.infinity,
              decoration: BoxDecoration(
                border: Border.all(
                  color: resultColor,
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
                        padding: const EdgeInsets.fromLTRB(0, 0, 15, 0),
                        child: SvgPicture.asset(
                          'assets/ui/action.svg',
                          color: resultColor,
                          width: MediaQuery.of(context).size.width * 0.04,
                        ),
                      ),
                    ],
                  ),
                  Center(
                    child: Text(
                      widget.dsix.gm.getCurrentPlayer().result.outcomeAction,
                      style: TextStyle(
                        fontSize: 16,
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
        break;

      case '1D6':
        {
          outcomeWidget = GestureDetector(
            onTap: () {
              setState(() {
                Navigator.pop(context);
                secondRoll(1);
                widget.refresh();
              });
            },
            child: Container(
              height: MediaQuery.of(context).size.height * 0.08,
              width: double.infinity,
              decoration: BoxDecoration(
                border: Border.all(
                  color: resultColor,
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
                        padding: const EdgeInsets.fromLTRB(0, 0, 15, 0),
                        child: SvgPicture.asset(
                          'assets/ui/action.svg',
                          color: resultColor,
                          width: MediaQuery.of(context).size.width * 0.04,
                        ),
                      ),
                    ],
                  ),
                  Center(
                    child: Text(
                      widget.dsix.gm.getCurrentPlayer().result.outcomeAction,
                      style: TextStyle(
                        fontSize: 16,
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
        break;

      case 'TEXT':
        {
          outcomeWidget = Text(
            widget.dsix.gm.getCurrentPlayer().result.outcomeText,
            textAlign: TextAlign.justify,
            style: TextStyle(
              fontSize: 19,
              fontFamily: 'Calibri',
              color: Colors.white,
            ),
          );
        }
        break;

      case 'OPTIONS':
        {
          outcomeWidget = GestureDetector(
            onTap: () {
              setState(() {
                Navigator.pop(context);
                showAlertDialogOptions(context);
                widget.refresh();
              });
            },
            child: Container(
              height: MediaQuery.of(context).size.height * 0.08,
              width: double.infinity,
              decoration: BoxDecoration(
                border: Border.all(
                  color: resultColor,
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
                        padding: const EdgeInsets.fromLTRB(0, 0, 15, 0),
                        child: SvgPicture.asset(
                          'assets/ui/action.svg',
                          color: resultColor,
                          width: MediaQuery.of(context).size.width * 0.04,
                        ),
                      ),
                    ],
                  ),
                  Center(
                    child: Text(
                      widget.dsix.gm.getCurrentPlayer().result.outcomeAction,
                      style: TextStyle(
                        fontSize: 16,
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
        break;
    }

    showAlertDialogAction(context);
  }

  void rollDice(int diceIndex) {
    diceList[diceIndex].dice =
        '${widget.dsix.gm.getCurrentPlayer().result.diceResult[diceIndex]}';
    diceList[diceIndex].animationLines = 0;

    int diceChecker = 0;

    diceList.forEach((element) {
      if (element.dice == 'Roll') {
        diceChecker++;
      }
    });

    if (diceChecker == 0) {
      showResult();
    }
  }

  void showResult() {
    title = widget.dsix.gm.getCurrentPlayer().result.outcomeTitle;
    displaySum = widget.dsix.gm.getCurrentPlayer().result.sum;
    resultColor = widget.dsix.gm.getCurrentPlayer().result.color;
    actionButton = outcomeWidget;
  }

  void secondRoll(int numberDice) {
    widget.dsix.gm.getCurrentPlayer().secondRoll(numberDice);
    outcomeWidget = Text(
      widget.dsix.gm.getCurrentPlayer().result.outcomeText,
      textAlign: TextAlign.justify,
      style: TextStyle(
        fontSize: 19,
        fontFamily: 'Calibri',
        color: Colors.white,
      ),
    );
    actionButton = Container();
    displaySum = '';
    title = widget.dsix.gm.getCurrentPlayer().result.outcomeAction;
    resultColor = widget.dsix.gm.getCurrentPlayer().playerColor.primaryColor;

    diceList = [];
    for (int i = 0; i < numberDice; i++) {
      diceList.add(die.newDie());
    }

    showAlertDialogAction(context);
  }

  void selectOutcome(int index) {
    if (widget.dsix.gm
        .getCurrentPlayer()
        .result
        .outcomeOptions[index]
        .selected) {
      widget.dsix.gm.getCurrentPlayer().result.outcomeOptions[index].selected =
          false;
      widget.dsix.gm.getCurrentPlayer().result.outcomeValue++;
    } else {
      widget.dsix.gm.getCurrentPlayer().result.outcomeOptions[index].selected =
          true;
      widget.dsix.gm.getCurrentPlayer().result.outcomeValue--;
    }

    if (widget.dsix.gm.getCurrentPlayer().result.outcomeValue < 1) {
      widget.dsix.gm.getCurrentPlayer().chooseOutcome();
      setState(() {});
      Navigator.pop(context);
    }
  }

// NEW DICE ROLL MENU
  showAlertDialogAction(BuildContext context) {
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
                    width: MediaQuery.of(context).size.width * 0.7,
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
                                    fontFamily: 'Santana',
                                    height: 1,
                                    fontSize: 25,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    letterSpacing: 3,
                                  ),
                                ),
                              ),
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
                                                rollDice(index);
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
                                    const EdgeInsets.fromLTRB(30, 7, 30, 0),
                                child: Center(
                                  child: Text(
                                    displaySum,
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
                                padding:
                                    const EdgeInsets.fromLTRB(25, 150, 25, 10),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Center(child: actionButton),
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

//THIS SHOWS THE OPTIONS

  showAlertDialogOptions(BuildContext context) {
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
                    width: MediaQuery.of(context).size.width * 0.7,
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
                                  '${widget.dsix.gm.getCurrentPlayer().result.outcomeAction}',
                                  style: TextStyle(
                                    fontFamily: 'Santana',
                                    height: 1,
                                    fontSize: 30,
                                    color: Colors.white,
                                    letterSpacing: 1.2,
                                  ),
                                ),
                              ],
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
                            height: (widget.dsix.gm
                                        .getCurrentPlayer()
                                        .result
                                        .outcomeOptions
                                        .length <
                                    6)
                                ? MediaQuery.of(context).size.height *
                                    0.08 *
                                    widget.dsix.gm
                                        .getCurrentPlayer()
                                        .result
                                        .outcomeOptions
                                        .length
                                : MediaQuery.of(context).size.height * 0.08 * 6,
                            child: ListView.builder(
                                shrinkWrap: true,
                                itemCount: widget.dsix.gm
                                    .getCurrentPlayer()
                                    .result
                                    .outcomeOptions
                                    .length,
                                itemBuilder: (BuildContext context, int index) {
                                  return Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            selectOutcome(index);
                                          });
                                        },
                                        child: Container(
                                          width: double.infinity,
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.08,
                                          color: (widget.dsix.gm
                                                  .getCurrentPlayer()
                                                  .result
                                                  .outcomeOptions[index]
                                                  .selected)
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
                                                '${widget.dsix.gm.getCurrentPlayer().result.outcomeOptions[index].name}',
                                                style: TextStyle(
                                                  fontSize: 16,
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
    displayedAction =
        widget.dsix.gm.getCurrentPlayer().playerAction[selectedAction];

    actionSelection = [];
    widget.dsix.gm.getCurrentPlayer().playerAction.forEach((element) {
      if (element == displayedAction) {
        actionSelection.add(true);
      } else {
        actionSelection.add(false);
      }
    });

    return Column(
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
                        onDoubleTap: () {
                          setState(() {
                            selectedAction = index + 1;
                            if (widget.dsix.gm
                                    .getCurrentPlayer()
                                    .playerAction[index + 1]
                                    .value <
                                3) {
                              widget.dsix.gm
                                  .getCurrentPlayer()
                                  .quickPositiveEffect(widget.dsix.gm
                                      .getCurrentPlayer()
                                      .playerAction[index + 1]
                                      .name);
                            }
                          });
                        },
                        onLongPress: () {
                          setState(() {
                            selectedAction = index + 1;
                            if (widget.dsix.gm
                                    .getCurrentPlayer()
                                    .playerAction[index + 1]
                                    .value >
                                -2) {
                              widget.dsix.gm
                                  .getCurrentPlayer()
                                  .quickNegativeEffect(widget.dsix.gm
                                      .getCurrentPlayer()
                                      .playerAction[index + 1]
                                      .name);
                            }
                          });
                        },
                        onTap: () {
                          setState(() {
                            selectedAction = index + 1;
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
        Container(
          width: MediaQuery.of(context).size.width * 0.65,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(0, 15, 0, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
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
                ListView.builder(
                    shrinkWrap: true,
                    padding: const EdgeInsets.fromLTRB(0, 15, 0, 0),
                    itemCount: displayedAction.option.length,
                    itemBuilder: (BuildContext context, int index) {
                      return GestureDetector(
                        onTap: () {
                          takeAction(
                              displayedAction.option[index].copyOption());
                          // checkAction(
                          //     displayedAction.option[index].copyOption(), 2);
                        },
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(0, 0, 0, 5),
                          child: Container(
                            height: MediaQuery.of(context).size.height * 0.08,
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
                                          0, 0, 15, 0),
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
                                      fontSize: 16,
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
