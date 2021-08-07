import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:dsixv02app/models/dsix/dsix.dart';
import 'package:dsixv02app/models/shared/exceptions.dart';
import 'package:flutter_svg/flutter_svg.dart';

class StoryPage extends StatefulWidget {
  final Function(String) alert;
  final Function() refresh;
  final Dsix dsix;

  StoryPage({Key key, this.dsix, this.refresh, this.alert}) : super(key: key);

  static const String routeName = "/storyPage";

  @override
  _StoryPageState createState() => new _StoryPageState();
}

class _StoryPageState extends State<StoryPage> {
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
    } on NoPlayersException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(widget.alert(e.message));
      widget.refresh();
      return;
    }

    showAlertDialogNewQuest(context);
  }

  void chooseQuest(int index) {
    try {
      widget.dsix.gm.chooseQuest(index);
    } on NewStoryException catch (e) {
      Navigator.pop(context);
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

  showAlertDialogNewQuest(BuildContext context) {
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
                          'NEW QUEST',
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
                        widget.dsix.gm.story.questList.length,
                    child: ListView.builder(
                        itemCount: widget.dsix.gm.story.questList.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Padding(
                            padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                            child: TextButton(
                              onPressed: () {
                                chooseQuest(index);
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
                                    color: Colors.grey[700],
                                    width:
                                        1, //                   <--- border width here
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
                                            color: Colors.grey[700],
                                            size: 25,
                                          ),
                                        ),
                                      ],
                                    ),
                                    Center(
                                      child: Text(
                                        '${widget.dsix.gm.story.questList[index].objective}'
                                            .toUpperCase(),
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

  List<String> possibleRewards = [];

  showAlertDialogChooseReward(BuildContext context) {
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
                          'CHOOSE REWARD',
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
                        possibleRewards.length,
                    child: ListView.builder(
                        itemCount: possibleRewards.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Padding(
                            padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                            child: TextButton(
                              onPressed: () {
                                chooseReward(possibleRewards[index]);
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
                                    color: Colors.grey[700],
                                    width:
                                        1, //                   <--- border width here
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
                                            color: Colors.grey[700],
                                            size: 25,
                                          ),
                                        ),
                                      ],
                                    ),
                                    Center(
                                      child: Text(
                                        '${possibleRewards[index]}'
                                            .toUpperCase(),
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

  void deleteQuest() {
    widget.dsix.gm.newQuest();
    widget.refresh();
    Navigator.of(context).pop(true);
    showAlertDialogNewQuest(context);
  }

  void chooseReward(String reward) {
    widget.dsix.gm.finishQuest();
    widget.dsix.gm.chooseReward(reward);
    widget.dsix.gm.newRound();
    Navigator.pop(context);
    widget.dsix.gm.newQuest();
    widget.refresh();
    showAlertDialogNewQuest(context);
  }

  void finishQuest() {
    Navigator.pop(context);
    possibleRewards = widget.dsix.gm.randomReward();
    showAlertDialogChooseReward(context);
  }

  showAlertDialogFinishQuest(BuildContext context) {
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
                          'FINISH QUEST?',
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
                ), //ITEM NAME

                // Container(
                //   width: double.infinity,
                //   child: Padding(
                //     padding: const EdgeInsets.fromLTRB(35, 15, 35, 20),
                //     child: Text(
                //       'The item will be destroyed!',
                //       textAlign: TextAlign.justify,
                //       style: TextStyle(
                //         height: 1.25,
                //         fontSize: 19,
                //         fontFamily: 'Calibri',
                //         color: Colors.white,
                //       ),
                //     ),
                //   ),
                // ),

                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                  child: TextButton(
                    onPressed: () {
                      // Navigator.of(context).pop(true);
                      finishQuest();
                    },
                    style: TextButton.styleFrom(
                      padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                    ),
                    child: Container(
                      height: MediaQuery.of(context).size.height * 0.08,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.grey[700],
                          width: 1, //                   <--- border width here
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
                                child: Icon(
                                  Icons.check,
                                  color: Colors.grey[700],
                                  size: 25,
                                ),
                              ),
                            ],
                          ),
                          Center(
                            child: Text(
                              'CONFIRM',
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
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                  child: TextButton(
                    onPressed: () {
                      Navigator.of(context).pop(true);
                    },
                    style: TextButton.styleFrom(
                      padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                    ),
                    child: Container(
                      height: MediaQuery.of(context).size.height * 0.08,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.grey[700],
                          width: 1, //                   <--- border width here
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
                                child: Icon(
                                  Icons.clear,
                                  color: Colors.grey[700],
                                  size: 25,
                                ),
                              ),
                            ],
                          ),
                          Center(
                            child: Text(
                              'CANCEL',
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

  showAlertDialogAbandonQuest(BuildContext context) {
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
                          'ABANDON QUEST?',
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
                ), //ITEM NAME

                // Container(
                //   width: double.infinity,
                //   child: Padding(
                //     padding: const EdgeInsets.fromLTRB(35, 15, 35, 20),
                //     child: Text(
                //       'The item will be destroyed!',
                //       textAlign: TextAlign.justify,
                //       style: TextStyle(
                //         height: 1.25,
                //         fontSize: 19,
                //         fontFamily: 'Calibri',
                //         color: Colors.white,
                //       ),
                //     ),
                //   ),
                // ),

                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                  child: TextButton(
                    onPressed: () {
                      deleteQuest();
                    },
                    style: TextButton.styleFrom(
                      padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                    ),
                    child: Container(
                      height: MediaQuery.of(context).size.height * 0.08,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.grey[700],
                          width: 1, //                   <--- border width here
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
                                child: Icon(
                                  Icons.check,
                                  color: Colors.grey[700],
                                  size: 25,
                                ),
                              ),
                            ],
                          ),
                          Center(
                            child: Text(
                              'CONFIRM',
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
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                  child: TextButton(
                    onPressed: () {
                      Navigator.of(context).pop(true);
                    },
                    style: TextButton.styleFrom(
                      padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                    ),
                    child: Container(
                      height: MediaQuery.of(context).size.height * 0.08,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.grey[700],
                          width: 1, //                   <--- border width here
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
                                child: Icon(
                                  Icons.clear,
                                  color: Colors.grey[700],
                                  size: 25,
                                ),
                              ),
                            ],
                          ),
                          Center(
                            child: Text(
                              'CANCEL',
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
    if (widget.dsix.gm.story.quest.name == 'NEW QUEST') {
      _layout = 0;
    } else {
      _layout = 1;
    }

    return Column(
      children: <Widget>[
        Container(
          height: MediaQuery.of(context).size.height * 0.1,
          width: double.infinity,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(15, 0, 25, 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    SvgPicture.asset(
                      'assets/gm/story.svg',
                      color: Colors.grey[700],
                      width: MediaQuery.of(context).size.width * 0.08,
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(8, 0, 0, 0),
                      child: Text(
                        (widget.dsix.gm.story.round == 0)
                            ? '${widget.dsix.gm.story.settings.numberOfQuests}'
                            : '${widget.dsix.gm.story.round}',
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
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    SvgPicture.asset(
                      'assets/gm/xp.svg',
                      color: Colors.grey[700],
                      width: MediaQuery.of(context).size.width * 0.08,
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(8, 0, 0, 0),
                      child: Text(
                        '${widget.dsix.gm.story.settings.questXp * widget.dsix.gm.numberPlayers}',
                        textAlign: TextAlign.left,
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
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    SvgPicture.asset(
                      'assets/gm/xp.svg',
                      color: Colors.grey[700],
                      width: MediaQuery.of(context).size.width * 0.08,
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(8, 0, 0, 0),
                      child: Text(
                        '${widget.dsix.gm.story.settings.questGold}',
                        textAlign: TextAlign.left,
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
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Icon(
                      Icons.schedule,
                      color: Colors.grey[700],
                      size: 25,
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(8, 0, 0, 0),
                      child: Text(
                        '30\'\'',
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
                  ],
                ),
              ],
            ),
          ),
        ),
        Divider(
          height: 0,
          thickness: 2,
          color: Colors.grey[700],
        ),
        Container(
          width: double.infinity,
          height: MediaQuery.of(context).size.height * 0.678,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(0, 25, 0, 0),
            child: IndexedStack(
              alignment: Alignment.topCenter,
              index: _layout,
              children: [
                Container(
                  width: MediaQuery.of(context).size.width * 0.65,
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                            child: GestureDetector(
                              onTap: () {
                                // setState(() {
                                //   widget.dsix.gm.story.chooseDifficulty(-1);
                                // });
                              },
                              child: SvgPicture.asset(
                                'assets/ui/arrowLeft.svg',
                                color: Colors.white,
                                width: MediaQuery.of(context).size.width * 0.08,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                            child: Text(
                              '${widget.dsix.gm.story.settings.name}',
                              style: TextStyle(
                                fontFamily: 'Headline',
                                height: 1.1,
                                fontSize: 45,
                                color: Colors.grey[700],
                                letterSpacing: 2,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                            child: GestureDetector(
                              // onTap: () {
                              //   setState(() {
                              //     widget.dsix.gm.story.chooseDifficulty(1);
                              //   });
                              // },
                              child: SvgPicture.asset(
                                'assets/ui/arrowRight.svg',
                                color: Colors.white,
                                width: MediaQuery.of(context).size.width * 0.08,
                              ),
                            ),
                          ),
                        ],
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
                          height: MediaQuery.of(context).size.height * 0.08,
                          width: MediaQuery.of(context).size.width * 0.65,
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
                                    padding:
                                        const EdgeInsets.fromLTRB(0, 0, 15, 0),
                                    child: Icon(
                                      Icons.check,
                                      color: Colors.grey[700],
                                      size: 25,
                                    ),
                                  ),
                                ],
                              ),
                              Center(
                                child: Text(
                                  'START',
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
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Stack(
                      alignment: Alignment.topCenter,
                      children: [
                        Container(
                          width: double.infinity,
                          height: 120,
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    showAlertDialogFinishQuest(context);
                                  },
                                  child: Container(
                                    width: 50,
                                    height: 50,
                                    child: Icon(
                                      Icons.check,
                                      color: Colors.green,
                                      size: 50,
                                    ),
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    showAlertDialogAbandonQuest(context);
                                  },
                                  child: Container(
                                    width: 50,
                                    height: 50,
                                    child: Icon(
                                      Icons.close,
                                      color: Colors.red,
                                      size: 50,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width * 0.65,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '${widget.dsix.gm.story.quest.name}',
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
                                    const EdgeInsets.fromLTRB(0, 10, 0, 10),
                                child: Text(
                                  '${widget.dsix.gm.story.quest.questDescription}',
                                  textAlign: TextAlign.justify,
                                  style: TextStyle(
                                    height: 1.3,
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
                    Container(
                      height: MediaQuery.of(context).size.height * 0.081 * 4,
                      child: ListView(
                        shrinkWrap: true,
                        physics: AlwaysScrollableScrollPhysics(),
                        scrollDirection: Axis.vertical,
                        children: [
                          Divider(
                            height: 2,
                            thickness: 2,
                            color: Colors.grey[700],
                          ),
                          Container(
                            height: MediaQuery.of(context).size.height * 0.08,
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                              child: ListTile(
                                onTap: () {
                                  // setState(() {
                                  //   widget.dsix.gm.story.quest
                                  //       .chooseQuest('character');
                                  //   widget.refresh();
                                  // });
                                },
                                title: Text(
                                  'CHARACTER:',
                                  style: TextStyle(
                                    fontFamily: 'Calibri',
                                    height: 1,
                                    fontSize: 18,
                                    color: Colors.grey[600],
                                    letterSpacing: 1.5,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                trailing: Text(
                                  widget.dsix.gm.story.quest.character,
                                  style: TextStyle(
                                    height: 1.5,
                                    fontSize: 18,
                                    fontFamily: 'Calibri',
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Divider(
                            height: 0,
                            thickness: 2,
                            color: Colors.grey[700],
                          ),
                          Container(
                            height: MediaQuery.of(context).size.height * 0.08,
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                              child: ListTile(
                                onTap: () {
                                  setState(() {
                                    // widget.dsix.gm.selectedQuest
                                    //     .chooseQuest('objective');
                                    // widget.refresh();
                                  });
                                },
                                title: Text(
                                  'OBJECTIVE:',
                                  style: TextStyle(
                                    fontFamily: 'Calibri',
                                    height: 1,
                                    fontSize: 18,
                                    color: Colors.grey[600],
                                    letterSpacing: 1.5,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                trailing: Text(
                                  widget.dsix.gm.story.quest.objective,
                                  style: TextStyle(
                                    height: 1.5,
                                    fontSize: 18,
                                    fontFamily: 'Calibri',
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Divider(
                            height: 0,
                            thickness: 2,
                            color: Colors.grey[700],
                          ),
                          Container(
                            height: MediaQuery.of(context).size.height * 0.08,
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                              child: ListTile(
                                onTap: () {
                                  setState(() {
                                    // widget.dsix.gm.story.quest
                                    //     .chooseQuest('target');
                                    // widget.refresh();
                                  });
                                },
                                title: Text(
                                  'TARGET:',
                                  style: TextStyle(
                                    fontFamily: 'Calibri',
                                    height: 1,
                                    fontSize: 18,
                                    color: Colors.grey[600],
                                    letterSpacing: 1.5,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                trailing: Text(
                                  widget.dsix.gm.story.quest.target,
                                  style: TextStyle(
                                    height: 1.5,
                                    fontSize: 18,
                                    fontFamily: 'Calibri',
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Divider(
                            height: 0,
                            thickness: 2,
                            color: Colors.grey[700],
                          ),
                          Container(
                            height: MediaQuery.of(context).size.height * 0.08,
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                              child: ListTile(
                                onTap: () {
                                  setState(() {
                                    // widget.dsix.gm.story.quest
                                    //     .chooseQuest('location');
                                    // widget.refresh();
                                  });
                                },
                                title: Text(
                                  'LOCATION:',
                                  style: TextStyle(
                                    fontFamily: 'Calibri',
                                    height: 1,
                                    fontSize: 18,
                                    color: Colors.grey[600],
                                    letterSpacing: 1.5,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                trailing: Text(
                                  widget.dsix.gm.story.quest.location,
                                  style: TextStyle(
                                    height: 1.5,
                                    fontSize: 18,
                                    fontFamily: 'Calibri',
                                    color: Colors.white,
                                  ),
                                ),
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
          ),
        ),
      ],
    );
  }
}
