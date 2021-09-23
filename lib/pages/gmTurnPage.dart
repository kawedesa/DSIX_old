import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:dsixv02app/models/dsix/dsix.dart';

import 'package:flutter_svg/flutter_svg.dart';
import 'dart:async';

class TurnPage extends StatefulWidget {
  final Function(String) alert;
  final Function() refresh;
  final Dsix dsix;

  TurnPage({Key key, this.dsix, this.refresh, this.alert}) : super(key: key);

  static const String routeName = "/turnPage";

  @override
  _TurnPageState createState() => new _TurnPageState();
}

class _TurnPageState extends State<TurnPage> {
  showAlertDialogChooseTurn(BuildContext context) {
    AlertDialog alerta = AlertDialog(
      backgroundColor: Colors.black,
      contentPadding: EdgeInsets.fromLTRB(0, 0, 0, 0),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.grey[700],
                width: 2.5, //                   <--- border width here
              ),
            ),
            width: MediaQuery.of(context).size.width * 0.7,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Container(
                  color: Colors.grey[700],
                  width: double.infinity,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(0, 5, 0, 5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          'NEXT TURN',
                          style: TextStyle(
                            fontFamily: 'Santana',
                            height: 1,
                            fontSize: 25,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 3,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                  child: Container(
                    height: MediaQuery.of(context).size.height *
                        0.08 *
                        widget.dsix.gm.turnOrder.length,
                    child: ListView.builder(
                        itemCount: widget.dsix.gm.turnOrder.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Padding(
                            padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                            child: TextButton(
                              onPressed: () {
                                widget.dsix.gm.chooseTurn(index);

                                widget.refresh();

                                Navigator.pop(context);
                              },
                              style: TextButton.styleFrom(
                                padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                              ),
                              child: Container(
                                height:
                                    MediaQuery.of(context).size.height * 0.08,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: widget
                                        .dsix.gm.turnOrder[index].primaryColor,
                                    width:
                                        3, //                   <--- border width here
                                  ),
                                ),
                                child: Stack(
                                  alignment: AlignmentDirectional.centerEnd,
                                  children: [
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Padding(
                                          padding: const EdgeInsets.fromLTRB(
                                              0, 0, 15, 0),
                                          child: Icon(
                                            Icons.keyboard_arrow_right,
                                            color: widget.dsix.gm
                                                .turnOrder[index].primaryColor,
                                            size: 25,
                                          ),
                                        ),
                                      ],
                                    ),
                                    Center(
                                      child: Text(
                                        '${widget.dsix.gm.turnOrder[index].name}'
                                            .toUpperCase(),
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          letterSpacing: 1.5,
                                          fontFamily: 'Calibri',
                                          color: widget.dsix.gm.turnOrder[index]
                                              .primaryColor,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
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

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alerta;
      },
    );
  }

  int _counter = 45;
  Timer _timer;

  void _resetTimer() {
    _counter = 45;
    _timerRunning = false;
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {});
    });
    _randomAction = possibleActions[Random().nextInt(possibleActions.length)];
  }

  List<String> possibleActions = ['ATTACK', 'DEFEND', 'LOOK', 'TALK', 'MOVE'];

  String _randomAction = 'ATTACK';

  bool _timerRunning = false;

  void _startAndStopTimer() {
    if (_timerRunning) {
      _timerRunning = false;
      _timer = Timer.periodic(Duration(seconds: 1), (timer) {
        setState(() {});
      });
    } else {
      _timerRunning = true;
      _timer = Timer.periodic(Duration(seconds: 1), (timer) {
        setState(() {
          if (_counter > 0) {
            _counter--;
          } else {
            _timer.cancel();
          }
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Container(
          height: MediaQuery.of(context).size.height * 0.1,
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(18, 0, 0, 0),
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      widget.dsix.gm.addGmTurn();
                    });
                  },
                  child: Container(
                    width: 23,
                    height: 23,
                    child: SvgPicture.asset(
                      'assets/gm/add.svg',
                      color: Colors.grey[400],
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                  child: ListView.separated(
                    shrinkWrap: true,
                    physics: ScrollPhysics(),
                    scrollDirection: Axis.horizontal,
                    padding: const EdgeInsets.fromLTRB(13, 0, 0, 0),
                    itemCount: widget.dsix.gm.turnOrder.length,
                    itemBuilder: (BuildContext context, int index) {
                      return GestureDetector(
                        onLongPress: () {
                          setState(() {
                            widget.dsix.gm.removeTurn(index);
                          });
                        },
                        onTap: () {
                          setState(() {
                            widget.dsix.gm.chooseTurn(index);
                          });
                        },
                        child: Container(
                          height: 35,
                          width: 35,
                          // color: Colors.amber,
                          child: SvgPicture.asset(
                            'assets/player/race/${widget.dsix.gm.turnOrder[index].icon}.svg',
                            color: widget.dsix.gm.turnOrder[index].primaryColor,
                          ),
                        ),
                      );
                    },
                    separatorBuilder: (BuildContext context, int index) {
                      return SizedBox(
                        width: 5,
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
        Divider(
          height: 0,
          thickness: 2,
          color: Colors.grey[700],
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(65, 15, 65, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'TURN ORDER',
                  style: TextStyle(
                    fontFamily: 'Headline',
                    height: 1.3,
                    fontSize: 45,
                    color: Colors.grey[700],
                    letterSpacing: 2,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                  child: GestureDetector(
                    onTap: () {
                      _startAndStopTimer();
                    },
                    child: Text(
                      '$_counter',
                      style: TextStyle(
                        fontFamily: 'Calibri',
                        height: 1,
                        fontSize: 100,
                        color: (_counter < 1)
                            ? Colors.red
                            : widget.dsix.gm.turnOrder.first.primaryColor,
                        letterSpacing: 1.2,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
                  child: Text(
                    (_counter < 1) ? '$_randomAction' : '',
                    textAlign: TextAlign.justify,
                    style: TextStyle(
                      height: 1.3,
                      fontSize: 18,
                      fontFamily: 'Calibri',
                      color: Colors.white,
                    ),
                  ),
                ),
                TextButton(
                  style: TextButton.styleFrom(
                    padding: const EdgeInsets.fromLTRB(0, 0, 0, 5),
                  ),
                  onPressed: () {
                    setState(() {
                      widget.dsix.gm.nextTurn();
                      _resetTimer();
                    });
                  },
                  child: Container(
                    height: MediaQuery.of(context).size.height * 0.08,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.grey[700],
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
                                'assets/ui/help.svg',
                                color: Colors.grey[700],
                                width: MediaQuery.of(context).size.width * 0.04,
                              ),
                            ),
                          ],
                        ),
                        Center(
                          child: Text(
                            'NEXT',
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
                TextButton(
                  style: TextButton.styleFrom(
                    padding: const EdgeInsets.fromLTRB(0, 0, 0, 5),
                  ),
                  onPressed: () {
                    setState(() {
                      widget.dsix.gm.skipTurn();
                      _resetTimer();
                    });
                  },
                  child: Container(
                    height: MediaQuery.of(context).size.height * 0.08,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.grey[700],
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
                                'assets/ui/help.svg',
                                color: Colors.grey[700],
                                width: MediaQuery.of(context).size.width * 0.04,
                              ),
                            ),
                          ],
                        ),
                        Center(
                          child: Text(
                            'SKIP',
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
                TextButton(
                  style: TextButton.styleFrom(
                    padding: const EdgeInsets.fromLTRB(0, 0, 0, 5),
                  ),
                  onPressed: () {
                    setState(() {
                      showAlertDialogChooseTurn(context);
                      _resetTimer();
                    });
                  },
                  child: Container(
                    height: MediaQuery.of(context).size.height * 0.08,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.grey[700],
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
                                'assets/ui/help.svg',
                                color: Colors.grey[700],
                                width: MediaQuery.of(context).size.width * 0.04,
                              ),
                            ),
                          ],
                        ),
                        Center(
                          child: Text(
                            'CHOOSE',
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
                TextButton(
                  style: TextButton.styleFrom(
                    padding: const EdgeInsets.fromLTRB(0, 0, 0, 5),
                  ),
                  onPressed: () {
                    setState(() {
                      widget.dsix.gm.shuffleTurn();
                    });
                  },
                  child: Container(
                    height: MediaQuery.of(context).size.height * 0.08,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.grey[700],
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
                                'assets/ui/help.svg',
                                color: Colors.grey[700],
                                width: MediaQuery.of(context).size.width * 0.04,
                              ),
                            ),
                          ],
                        ),
                        Center(
                          child: Text(
                            'SHUFFLE',
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
              ],
            ),
          ),
        ),
      ],
    );
  }
}
