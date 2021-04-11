import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:dsixv02app/models/game/dsix.dart';
import 'package:dsixv02app/models/gm/quest.dart';
import 'package:flutter_svg/flutter_svg.dart';

class StoryPage extends StatefulWidget {
  final Function() refresh;
  final Dsix dsix;

  StoryPage({Key key, this.dsix, this.refresh}) : super(key: key);

  static const String routeName = "/npcPage";

  @override
  _StoryPageState createState() => new _StoryPageState();
}

class _StoryPageState extends State<StoryPage> {
  int _layoutIndex = 0;

  void selectQuest(int index) {
    widget.dsix.gm.selectedQuest = widget.dsix.gm.questList[index];
    checkLayout();
  }

  void checkLayout() {
    if (widget.dsix.gm.selectedQuest.name == '') {
      _layoutIndex = 0;
    } else {
      _layoutIndex = 1;
    }
    widget.refresh();
  }

  void newQuest() {
    widget.dsix.gm.createQuest();
    widget.dsix.gm.selectedQuest = widget.dsix.gm.questList.last;
    showAlertDialogQuest(context, widget.dsix.gm.selectedQuest);
  }

  showAlertDialogQuest(BuildContext context, Quest quest) {
    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              backgroundColor: Colors.black,
              contentPadding: EdgeInsets.fromLTRB(0, 0, 0, 0),
              content: Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.grey[700],
                    width: 2.5, //                   <--- border width here
                  ),
                ),
                width: 300,
                child: Container(
                  color: Colors.black,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Container(
                        color: Colors.grey[700],
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(30, 5, 30, 7),
                          child: Center(
                            child: Text(
                              'QUEST',
                              style: TextStyle(
                                fontFamily: 'Headline',
                                height: 1.3,
                                fontSize: 25.0,
                                color: Colors.grey[300],
                                letterSpacing: 2,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(15, 0, 10, 0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              'Character:',
                              style: TextStyle(
                                fontFamily: 'Headliner',
                                height: 1.5,
                                fontSize: 20.0,
                                color: Colors.grey[300],
                                letterSpacing: 2.5,
                              ),
                            ),
                            TextButton(
                              onPressed: () {
                                setState(() {
                                  quest.chooseQuest('character');
                                  widget.refresh();
                                });
                              },
                              child: Text(
                                quest.character,
                                style: TextStyle(
                                  height: 1.5,
                                  fontSize: 18,
                                  fontFamily: 'Calibri',
                                  color: Colors.white,
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
                      Padding(
                        padding: const EdgeInsets.fromLTRB(15, 0, 10, 0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              'Background:',
                              style: TextStyle(
                                fontFamily: 'Headliner',
                                height: 1.5,
                                fontSize: 20.0,
                                color: Colors.grey[300],
                                letterSpacing: 2.5,
                              ),
                            ),
                            TextButton(
                              onPressed: () {
                                setState(() {
                                  quest.chooseQuest('background');
                                  widget.refresh();
                                });
                              },
                              child: Text(
                                quest.background,
                                style: TextStyle(
                                  height: 1.5,
                                  fontSize: 18,
                                  fontFamily: 'Calibri',
                                  color: Colors.white,
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
                      Padding(
                        padding: const EdgeInsets.fromLTRB(15, 0, 10, 0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              'Personality:',
                              style: TextStyle(
                                fontFamily: 'Headliner',
                                height: 1.5,
                                fontSize: 20.0,
                                color: Colors.grey[300],
                                letterSpacing: 2.5,
                              ),
                            ),
                            TextButton(
                              onPressed: () {
                                setState(() {
                                  quest.chooseQuest('personality');
                                  widget.refresh();
                                });
                              },
                              child: Text(
                                quest.personality,
                                style: TextStyle(
                                  height: 1.5,
                                  fontSize: 18,
                                  fontFamily: 'Calibri',
                                  color: Colors.white,
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
                      Padding(
                        padding: const EdgeInsets.fromLTRB(15, 0, 10, 0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              'Look:',
                              style: TextStyle(
                                fontFamily: 'Headliner',
                                height: 1.5,
                                fontSize: 20.0,
                                color: Colors.grey[300],
                                letterSpacing: 2.5,
                              ),
                            ),
                            TextButton(
                              onPressed: () {
                                setState(() {
                                  quest.chooseQuest('look');
                                  widget.refresh();
                                });
                              },
                              child: Text(
                                quest.look,
                                style: TextStyle(
                                  height: 1.5,
                                  fontSize: 18,
                                  fontFamily: 'Calibri',
                                  color: Colors.white,
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
                      Padding(
                        padding: const EdgeInsets.fromLTRB(15, 0, 10, 0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              'Objective:',
                              style: TextStyle(
                                fontFamily: 'Headliner',
                                height: 1.5,
                                fontSize: 20.0,
                                color: Colors.grey[300],
                                letterSpacing: 2.5,
                              ),
                            ),
                            TextButton(
                              onPressed: () {
                                setState(() {
                                  quest.chooseQuest('objective');
                                  widget.refresh();
                                });
                              },
                              child: Text(
                                quest.objective,
                                style: TextStyle(
                                  height: 1.5,
                                  fontSize: 18,
                                  fontFamily: 'Calibri',
                                  color: Colors.white,
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
                      Padding(
                        padding: const EdgeInsets.fromLTRB(15, 0, 10, 0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              'Target:',
                              style: TextStyle(
                                fontFamily: 'Headliner',
                                height: 1.5,
                                fontSize: 20.0,
                                color: Colors.grey[300],
                                letterSpacing: 2.5,
                              ),
                            ),
                            SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: TextButton(
                                onPressed: () {
                                  setState(() {
                                    quest.chooseQuest('target');
                                    widget.refresh();
                                  });
                                },
                                child: Text(
                                  quest.target,
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
                        ),
                      ),
                      Divider(
                        height: 0,
                        thickness: 2,
                        color: Colors.grey[700],
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(15, 0, 10, 0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              'Location:',
                              style: TextStyle(
                                fontFamily: 'Headliner',
                                height: 1.5,
                                fontSize: 20.0,
                                color: Colors.grey[300],
                                letterSpacing: 2.5,
                              ),
                            ),
                            TextButton(
                              onPressed: () {
                                setState(() {
                                  quest.chooseQuest('location');
                                  widget.refresh();
                                });
                              },
                              child: Text(
                                quest.location,
                                style: TextStyle(
                                  height: 1.5,
                                  fontSize: 18,
                                  fontFamily: 'Calibri',
                                  color: Colors.white,
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
                      Padding(
                        padding: const EdgeInsets.fromLTRB(15, 0, 10, 0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              'Reward:',
                              style: TextStyle(
                                fontFamily: 'Headliner',
                                height: 1.5,
                                fontSize: 20.0,
                                color: Colors.grey[300],
                                letterSpacing: 2.5,
                              ),
                            ),
                            TextButton(
                              onPressed: () {
                                setState(() {
                                  quest.chooseQuest('reward');
                                  widget.refresh();
                                });
                              },
                              child: Text(
                                quest.reward,
                                style: TextStyle(
                                  height: 1.5,
                                  fontSize: 18,
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
                ),
              ),
            );
          },
        );
      },
    );
  }

  @override
  void initState() {
    super.initState();
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
                      widget.dsix.gm.selectedQuest.name = '';
                      checkLayout();
                      newQuest();
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
                    itemCount: widget.dsix.gm.questList.length,
                    itemBuilder: (BuildContext context, int index) {
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            selectQuest(index);
                          });
                        },
                        child: Container(
                          height: 35,
                          width: 35,
                          child: SvgPicture.asset(
                            'assets/gm/story/quest/${widget.dsix.gm.questList[index].icon}.svg',
                            color: Colors.grey[400],
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
        IndexedStack(
          index: _layoutIndex,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(65, 15, 65, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'STORY',
                    style: TextStyle(
                      fontFamily: 'Headline',
                      height: 1.3,
                      fontSize: 45,
                      color: Colors.grey[700],
                      letterSpacing: 2,
                    ),
                  ),
                  Text(
                    'Every game starts with a story. It could be the tale of a fallen prince, or the rise of a evil necromancer. Its hard to come up with something on the fly, so this page is dedicated to help you with that task. Here you can create quests, scenes, or settings with a few steps.',
                    textAlign: TextAlign.justify,
                    style: TextStyle(
                      height: 1.3,
                      fontSize: 18,
                      fontFamily: 'Calibri',
                      color: Colors.white,
                    ),
                  ),
                  TextButton(
                    style: TextButton.styleFrom(
                      padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                    ),
                    onPressed: () {
                      newQuest();
                    },
                    child: Container(
                      height: MediaQuery.of(context).size.height * 0.058,
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
                                padding: const EdgeInsets.fromLTRB(0, 0, 10, 0),
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
                              'QUEST',
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
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(65, 15, 65, 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${widget.dsix.gm.selectedQuest.name}',
                        style: TextStyle(
                          fontFamily: 'Headline',
                          height: 1.3,
                          fontSize: 45,
                          color: Colors.grey[700],
                          letterSpacing: 2,
                        ),
                      ),
                      Text(
                        '${widget.dsix.gm.selectedQuest.description}',
                        textAlign: TextAlign.justify,
                        style: TextStyle(
                          height: 1.3,
                          fontSize: 18,
                          fontFamily: 'Calibri',
                          color: Colors.white,
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
                Padding(
                  padding: const EdgeInsets.fromLTRB(15, 0, 10, 0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        'Character:',
                        style: TextStyle(
                          fontFamily: 'Headliner',
                          height: 1.5,
                          fontSize: 20.0,
                          color: Colors.grey[300],
                          letterSpacing: 2.5,
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          setState(() {
                            widget.dsix.gm.selectedQuest
                                .chooseQuest('character');
                            widget.refresh();
                          });
                        },
                        child: Text(
                          widget.dsix.gm.selectedQuest.character,
                          style: TextStyle(
                            height: 1.5,
                            fontSize: 18,
                            fontFamily: 'Calibri',
                            color: Colors.white,
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
                Padding(
                  padding: const EdgeInsets.fromLTRB(15, 0, 10, 0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        'Background:',
                        style: TextStyle(
                          fontFamily: 'Headliner',
                          height: 1.5,
                          fontSize: 20.0,
                          color: Colors.grey[300],
                          letterSpacing: 2.5,
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          setState(() {
                            widget.dsix.gm.selectedQuest
                                .chooseQuest('background');
                            widget.refresh();
                          });
                        },
                        child: Text(
                          widget.dsix.gm.selectedQuest.background,
                          style: TextStyle(
                            height: 1.5,
                            fontSize: 18,
                            fontFamily: 'Calibri',
                            color: Colors.white,
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
                Padding(
                  padding: const EdgeInsets.fromLTRB(15, 0, 10, 0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        'Personality:',
                        style: TextStyle(
                          fontFamily: 'Headliner',
                          height: 1.5,
                          fontSize: 20.0,
                          color: Colors.grey[300],
                          letterSpacing: 2.5,
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          setState(() {
                            widget.dsix.gm.selectedQuest
                                .chooseQuest('personality');
                            widget.refresh();
                          });
                        },
                        child: Text(
                          widget.dsix.gm.selectedQuest.personality,
                          style: TextStyle(
                            height: 1.5,
                            fontSize: 18,
                            fontFamily: 'Calibri',
                            color: Colors.white,
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
                Padding(
                  padding: const EdgeInsets.fromLTRB(15, 0, 10, 0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        'Look:',
                        style: TextStyle(
                          fontFamily: 'Headliner',
                          height: 1.5,
                          fontSize: 20.0,
                          color: Colors.grey[300],
                          letterSpacing: 2.5,
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          setState(() {
                            widget.dsix.gm.selectedQuest.chooseQuest('look');
                            widget.refresh();
                          });
                        },
                        child: Text(
                          widget.dsix.gm.selectedQuest.look,
                          style: TextStyle(
                            height: 1.5,
                            fontSize: 18,
                            fontFamily: 'Calibri',
                            color: Colors.white,
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
                Padding(
                  padding: const EdgeInsets.fromLTRB(15, 0, 10, 0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        'Objective:',
                        style: TextStyle(
                          fontFamily: 'Headliner',
                          height: 1.5,
                          fontSize: 20.0,
                          color: Colors.grey[300],
                          letterSpacing: 2.5,
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          setState(() {
                            widget.dsix.gm.selectedQuest
                                .chooseQuest('objective');
                            widget.refresh();
                          });
                        },
                        child: Text(
                          widget.dsix.gm.selectedQuest.objective,
                          style: TextStyle(
                            height: 1.5,
                            fontSize: 18,
                            fontFamily: 'Calibri',
                            color: Colors.white,
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
                Padding(
                  padding: const EdgeInsets.fromLTRB(15, 0, 10, 0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        'Target:',
                        style: TextStyle(
                          fontFamily: 'Headliner',
                          height: 1.5,
                          fontSize: 20.0,
                          color: Colors.grey[300],
                          letterSpacing: 2.5,
                        ),
                      ),
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: TextButton(
                          onPressed: () {
                            setState(() {
                              widget.dsix.gm.selectedQuest
                                  .chooseQuest('target');
                              widget.refresh();
                            });
                          },
                          child: Text(
                            widget.dsix.gm.selectedQuest.target,
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
                  ),
                ),
                Divider(
                  height: 0,
                  thickness: 2,
                  color: Colors.grey[700],
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(15, 0, 10, 0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        'Location:',
                        style: TextStyle(
                          fontFamily: 'Headliner',
                          height: 1.5,
                          fontSize: 20.0,
                          color: Colors.grey[300],
                          letterSpacing: 2.5,
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          setState(() {
                            widget.dsix.gm.selectedQuest
                                .chooseQuest('location');
                            widget.refresh();
                          });
                        },
                        child: Text(
                          widget.dsix.gm.selectedQuest.location,
                          style: TextStyle(
                            height: 1.5,
                            fontSize: 18,
                            fontFamily: 'Calibri',
                            color: Colors.white,
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
                Padding(
                  padding: const EdgeInsets.fromLTRB(15, 0, 10, 0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        'Reward:',
                        style: TextStyle(
                          fontFamily: 'Headliner',
                          height: 1.5,
                          fontSize: 20.0,
                          color: Colors.grey[300],
                          letterSpacing: 2.5,
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          setState(() {
                            widget.dsix.gm.selectedQuest.chooseQuest('reward');
                            widget.refresh();
                          });
                        },
                        child: Text(
                          widget.dsix.gm.selectedQuest.reward,
                          style: TextStyle(
                            height: 1.5,
                            fontSize: 18,
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
          ],
        ),
      ],
    );
  }
}
