import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:dsixv02app/models/dsix/dsix.dart';
import 'package:dsixv02app/models/shared/exceptions.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SettingsPage extends StatefulWidget {
  final Function(String) alert;
  final Function(int index) pageChanged;
  final Function() refresh;
  final Dsix dsix;

  SettingsPage({Key key, this.dsix, this.refresh, this.pageChanged, this.alert})
      : super(key: key);

  static const String routeName = "/settingsPage";

  @override
  _SettingsPageState createState() => new _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  List<String> difficultySetting = [
    'VERY EASY',
    'EASY',
    'NORMAL',
    'HARD',
    'VERY HARD',
  ];
  int _layout = 0;

  void newStory() {
    try {
      widget.dsix.gm.newStory();
    } on NewStoryException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(widget.alert(e.message));

      widget.refresh();
      return;
    }
  }

  void newRound() {
    try {
      widget.dsix.gm.newRound();
    } on NewRoundException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(widget.alert(e.message));

      widget.refresh();
      return;
    } on OnGoingQuestException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(widget.alert(e.message));

      widget.refresh();
      return;
    }
  }

  @override
  Widget build(BuildContext context) {
    if (widget.dsix.gm.story.round > 0) {
      _layout = 1;
    } else {
      _layout = 0;
    }

    return Column(
      children: <Widget>[
        Container(
          height: MediaQuery.of(context).size.height * 0.1,
          width: double.infinity,
          child: Row(
            children: [
              Expanded(
                child: Container(
                  child: Center(
                      child: Text(
                    'ROUNDS:',
                    style: TextStyle(
                      height: 1.3,
                      fontSize: 18,
                      fontFamily: 'Calibri',
                      color: Colors.white,
                    ),
                  )),
                ),
              ),
              Expanded(
                child: Container(
                  child: Center(
                      child: Text(
                    'QUESTS: ${widget.dsix.gm.story.settings.numberOfQuests}',
                    style: TextStyle(
                      height: 1.3,
                      fontSize: 18,
                      fontFamily: 'Calibri',
                      color: Colors.white,
                    ),
                  )),
                ),
              ),
              Expanded(
                child: Container(
                  child: Center(
                      child: Text(
                    'GOLD: ${widget.dsix.gm.story.settings.totalGold}',
                    style: TextStyle(
                      height: 1.3,
                      fontSize: 18,
                      fontFamily: 'Calibri',
                      color: Colors.white,
                    ),
                  )),
                ),
              ),
              Expanded(
                child: Container(
                  child: Center(
                      child: Text(
                    'XP: ${widget.dsix.gm.story.settings.totalXp}',
                    style: TextStyle(
                      height: 1.3,
                      fontSize: 18,
                      fontFamily: 'Calibri',
                      color: Colors.white,
                    ),
                  )),
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
        IndexedStack(
          index: _layout,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: MediaQuery.of(context).size.width * 0.2,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(10, 15, 10, 0),
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          widget.dsix.gm.story.chooseDifficulty(-1);
                        });
                      },
                      child: Container(
                        height: 100,
                        child: SvgPicture.asset(
                          'assets/ui/arrowLeft.svg',
                          color: Colors.grey[700],
                          width: MediaQuery.of(context).size.width * 0.05,
                        ),
                      ),
                    ),
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 0.6,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(0, 35, 0, 0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          '${widget.dsix.gm.story.settings.name}',
                          style: TextStyle(
                            fontFamily: 'Headline',
                            height: 1.3,
                            fontSize: 45,
                            color: Colors.grey[700],
                            letterSpacing: 2,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                          child: Text(
                            '${widget.dsix.gm.story.settings.description}',
                            textAlign: TextAlign.justify,
                            style: TextStyle(
                              height: 1.3,
                              fontSize: 18,
                              fontFamily: 'Calibri',
                              color: Colors.white,
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            newStory();
                          },
                          child: Container(
                            height: MediaQuery.of(context).size.height * 0.058,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Colors.grey[700],
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
                                      child: Icon(
                                        Icons.check,
                                        color: Colors.grey[700],
                                        size: 20,
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
                      ],
                    ),
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 0.2,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(10, 15, 10, 0),
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          widget.dsix.gm.story.chooseDifficulty(1);
                        });
                      },
                      child: Container(
                        height: 100,
                        child: SvgPicture.asset(
                          'assets/ui/arrowRight.svg',
                          color: Colors.grey[700],
                          width: MediaQuery.of(context).size.width * 0.05,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Container(
              height: MediaQuery.of(context).size.height * 0.678,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width * 0.2,
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width * 0.6,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.fromLTRB(0, 15, 0, 0),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    '${widget.dsix.gm.story.settings.name}',
                                    style: TextStyle(
                                      fontFamily: 'Headline',
                                      height: 1.3,
                                      fontSize: 45,
                                      color: Colors.grey[700],
                                      letterSpacing: 2,
                                    ),
                                  ),
                                  Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(0, 10, 0, 0),
                                    child: GestureDetector(
                                      onLongPress: () {
                                        widget.dsix.gm.deleteStory();
                                        _layout = 0;
                                        widget.refresh();
                                      },
                                      child: Icon(
                                        Icons.clear,
                                        color: Colors.red,
                                        size: 40,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                              child: Text(
                                '${widget.dsix.gm.story.settings.description}',
                                textAlign: TextAlign.justify,
                                style: TextStyle(
                                  height: 1.3,
                                  fontSize: 18,
                                  fontFamily: 'Calibri',
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(0, 0, 0, 15),
                              child: GestureDetector(
                                onTap: () {
                                  newRound();
                                },
                                child: Container(
                                  height: MediaQuery.of(context).size.height *
                                      0.058,
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: Colors.grey[700],
                                      width:
                                          2, //                   <--- border width here
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
                                                0, 0, 10, 0),
                                            child: Icon(
                                              Icons.check,
                                              color: Colors.grey[700],
                                              size: 20,
                                            ),
                                          ),
                                        ],
                                      ),
                                      Center(
                                        child: Text(
                                          'NEW TURN',
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
                            ),
                          ],
                        ),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width * 0.2,
                      ),
                    ],
                  ),
                  ListView.builder(
                      shrinkWrap: true,
                      physics: AlwaysScrollableScrollPhysics(),
                      scrollDirection: Axis.vertical,
                      itemCount: widget.dsix.gm.story.situationList.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Column(
                          children: [
                            Divider(
                              height: 0,
                              thickness: 2,
                              color: Colors.grey[700],
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                              child: ListTile(
                                onTap: () {},
                                title: Text(
                                  'SITUATION:',
                                  style: TextStyle(
                                    fontFamily: 'Headliner',
                                    height: 1.5,
                                    fontSize: 20.0,
                                    color: Colors.grey[300],
                                    letterSpacing: 2.5,
                                  ),
                                ),
                                trailing: Text(
                                  '${widget.dsix.gm.story.situationList[index].name}',
                                  style: TextStyle(
                                    height: 1.5,
                                    fontSize: 18,
                                    fontFamily: 'Calibri',
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        );
                      }),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}
