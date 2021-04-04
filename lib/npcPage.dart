import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:dsixv02app/models/game/dsix.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:dsixv02app/models/gm/npc.dart';
import 'package:dsixv02app/models/gm/npcSkill.dart';

class NpcPage extends StatefulWidget {
  final Function() refresh;
  final Dsix dsix;

  NpcPage({Key key, this.dsix, this.refresh}) : super(key: key);

  static const String routeName = "/npcPage";

  @override
  _NpcPageState createState() => new _NpcPageState();
}

class _NpcPageState extends State<NpcPage> {
  Npc displayNpc = new Npc('npc', 'NPC',
      'An NPC is a character that you control. So pretty much eveyone besides the players. Click on the the buttons below to create a new NPC.');

  NpcSkill displaySkill = NpcSkill(
    icon: 'skill',
    name: 'SKILL',
    skillType: 'null',
    description: 'Skill',
    value: 0,
  );

  String actionResult = 'Roll';

  List<String> npcHighlightSelection;

  void deleteNpc() {
    if (displayNpc.name == 'NPC') {
      return;
    }

    widget.dsix.gm.npcList.remove(displayNpc);
    displayNpc = Npc('newNpc', 'NPC',
        'An NPC is a character that you control. So pretty much eveyone besides the players. Click on the the buttons below to create a new NPC.');
    _layoutIndex = 0;
  }

  int _layoutIndex = 0;

  void selectNpc(int index) {
    if (index == 0) {
      displayNpc = Npc('newNpc', 'NPC',
          'An NPC is a character that you control. So pretty much eveyone besides the players. Click on the the buttons below to create a new NPC.');
      checkLayout();
      return;
    }

    displayNpc = widget.dsix.gm.npcList[index];
    actionResult = 'Roll';
    checkLayout();
  }

  void checkLayout() {
    if (displayNpc.name == 'NPC') {
      _layoutIndex = 0;
    } else {
      _layoutIndex = 1;
    }
    widget.refresh();
  }

  List<NpcSkill> possibleSkillList;

  void npcAction() {
    if (actionResult != 'Roll') {
      actionResult = 'Roll';
      return;
    }

    actionResult = displayNpc.npcAction();
  }

  void startNewNpc() {
    widget.dsix.gm.createNpc();
    showAlertDialogRace(context);
    widget.refresh();
  }

  void finishNewNpc() {
    widget.dsix.gm.npcList.last.createNpc();
    actionResult = 'Roll';
    checkLayout();
    Navigator.pop(context);
    widget.refresh();
  }

  void openSkill(NpcSkill skill) {
    possibleSkillList = displayNpc.openSkill(skill);

    if (possibleSkillList.isEmpty) {
      return;
    }

    showAlertDialogSkills(context);
  }

  showAlertDialogRace(BuildContext context) {
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
                    color: Colors.grey[900],
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
                        color: Colors.grey[900],
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(30, 5, 30, 7),
                          child: Center(
                            child: Text(
                              '${widget.dsix.gm.npcList.last.selectedRace.name}',
                              style: TextStyle(
                                fontFamily: 'Headline',
                                height: 1.3,
                                fontSize: 25.0,
                                color: Colors.grey[700],
                                letterSpacing: 2,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Container(
                        height: MediaQuery.of(context).size.height * 0.175,
                        // color: Colors.purple,
                        child: GridView.count(
                          shrinkWrap: true,
                          crossAxisCount: 5,
                          children: List.generate(
                              widget.dsix.gm.npcList.last.races.length,
                              (index) {
                            return TextButton(
                              onPressed: () {},
                              style: TextButton.styleFrom(
                                padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                              ),
                              child: Container(
                                width: 40,
                                height: 40,
                                // color: Colors.amberAccent,
                                child: GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      widget.dsix.gm.npcList.last
                                          .chooseRace(index);

                                      displayNpc = widget.dsix.gm.npcList.last;

                                      widget.refresh();
                                    });
                                  },
                                  child: SvgPicture.asset(
                                    'assets/gm/npc/race/${widget.dsix.gm.npcList.last.races[index].icon}.svg',
                                    color: Colors.grey[400],
                                  ),
                                ),
                              ),
                            );
                          }),
                        ),
                      ),
                      Divider(
                        height: 0,
                        thickness: 2,
                        color: Colors.grey[700],
                      ),
                      Container(
                        // color: Colors.pink,
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(25, 15, 25, 0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '${widget.dsix.gm.npcList.last.selectedRace.description}',
                                textAlign: TextAlign.justify,
                                style: TextStyle(
                                  height: 1.3,
                                  fontSize: 18,
                                  fontFamily: 'Calibri',
                                  color: Colors.white,
                                ),
                              ),
                              ListView.builder(
                                  shrinkWrap: true,
                                  padding:
                                      const EdgeInsets.fromLTRB(0, 10, 0, 0),
                                  itemCount: widget.dsix.gm.npcList.last
                                      .selectedRace.npcType.length,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return TextButton(
                                      style: TextButton.styleFrom(
                                        padding: const EdgeInsets.fromLTRB(
                                            0, 0, 0, 10),
                                      ),
                                      onPressed: () {
                                        widget.dsix.gm.npcList.last
                                            .chooseType(index);

                                        displayNpc =
                                            widget.dsix.gm.npcList.last;

                                        widget.refresh();
                                        Navigator.pop(context);
                                        showAlertDialogAmount(context);
                                      },
                                      child: Container(
                                        height:
                                            MediaQuery.of(context).size.height *
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
                                          alignment:
                                              AlignmentDirectional.centerEnd,
                                          children: [
                                            Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: <Widget>[
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.fromLTRB(
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
                                                '${widget.dsix.gm.npcList.last.selectedRace.npcType[index].type}',
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
                            ],
                          ),
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

  showAlertDialogSkills(
    BuildContext context,
  ) {
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
                    color: Colors.grey[900],
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
                        color: Colors.grey[900],
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(30, 5, 30, 7),
                          child: Center(
                            child: Text(
                              '${displaySkill.name}',
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
                      Container(
                        height: MediaQuery.of(context).size.height * 0.17,
                        // color: Colors.purple,
                        child: GridView.count(
                          shrinkWrap: true,
                          crossAxisCount: 5,
                          children:
                              List.generate(possibleSkillList.length, (index) {
                            return TextButton(
                              onPressed: () {},
                              style: TextButton.styleFrom(
                                padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                              ),
                              child: Container(
                                width: 50,
                                height: 50,
                                // color: Colors.amberAccent,
                                child: GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      displaySkill = possibleSkillList[index];

                                      widget.refresh();
                                    });
                                  },
                                  child: Center(
                                    child: SvgPicture.asset(
                                      'assets/gm/npc/skill/${possibleSkillList[index].skillType}/${possibleSkillList[index].icon}.svg',
                                      color: Colors.grey[400],
                                    ),
                                  ),
                                ),
                              ),
                            );
                          }),
                        ),
                      ),
                      Divider(
                        height: 0,
                        thickness: 2,
                        color: Colors.grey[700],
                      ),
                      Container(
                        // color: Colors.pink,
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(25, 15, 25, 0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '${displaySkill.description}',
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
                                  padding:
                                      const EdgeInsets.fromLTRB(0, 0, 0, 10),
                                ),
                                onPressed: () {
                                  displayNpc.chooseSkill(displaySkill);
                                  print(displayNpc.selectedSkills);

                                  widget.refresh();
                                  Navigator.pop(context);
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

  showAlertDialogAmount(BuildContext context) {
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
                    color: Colors.grey[900],
                    width: 2.5, //                   <--- border width here
                  ),
                ),
                width: 300,
                child: Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Container(
                        color: Colors.grey[900],
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(30, 5, 30, 7),
                          child: Center(
                            child: Text(
                              'HOW MANY?',
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
                      Container(
                        // color: Colors.pink,
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(25, 15, 25, 0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Padding(
                                padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Expanded(
                                      flex: 1,
                                      child: GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            widget.dsix.gm.npcList.last
                                                .chooseAmount(-5);
                                          });
                                        },
                                        child: Align(
                                          alignment: Alignment.centerRight,
                                          child: Text(
                                            '- 5',
                                            style: TextStyle(
                                              fontFamily: 'Headline',
                                              fontSize: 20.0,
                                              color: Colors.grey[700],
                                              letterSpacing: 2,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      flex: 3,
                                      child: Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                            10, 0, 10, 0),
                                        child: Center(
                                            child: Container(
                                          height: 125,
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              GestureDetector(
                                                onTap: () {
                                                  setState(() {
                                                    widget.dsix.gm.npcList.last
                                                        .chooseAmount(1);
                                                  });
                                                },
                                                child: Icon(
                                                  Icons.keyboard_arrow_up,
                                                  color: Colors.grey[700],
                                                  size: 35,
                                                ),
                                              ),
                                              Container(
                                                // width: 100,
                                                // height: 100,
                                                // color: Colors.white,
                                                child: Center(
                                                  child: Text(
                                                    '${widget.dsix.gm.npcList.last.amount}',
                                                    style: TextStyle(
                                                      fontFamily: 'Headline',
                                                      height: 1.3,
                                                      fontSize: 35.0,
                                                      color: Colors.white,
                                                      letterSpacing: 2,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              GestureDetector(
                                                onTap: () {
                                                  setState(() {
                                                    widget.dsix.gm.npcList.last
                                                        .chooseAmount(-1);
                                                  });
                                                },
                                                child: Icon(
                                                  Icons.keyboard_arrow_down,
                                                  color: Colors.grey[700],
                                                  size: 35,
                                                ),
                                              ),
                                            ],
                                          ),
                                          // color: Colors.red,
                                        )),
                                      ),
                                    ),
                                    Expanded(
                                      flex: 1,
                                      child: GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            widget.dsix.gm.npcList.last
                                                .chooseAmount(5);
                                          });
                                        },
                                        child: Align(
                                          alignment: Alignment.centerLeft,
                                          child: Text(
                                            '+ 5',
                                            style: TextStyle(
                                              fontFamily: 'Headline',
                                              fontSize: 20.0,
                                              color: Colors.grey[700],
                                              letterSpacing: 2,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(30, 0, 30, 0),
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    // Row(
                                    //   crossAxisAlignment:
                                    //       CrossAxisAlignment.center,
                                    //   children: <Widget>[
                                    //     SvgPicture.asset(
                                    //       'assets/gm/npc/${displayNpc.selectedRace.icon}.svg',
                                    //       color: Colors.grey[700],
                                    //       width: MediaQuery.of(context)
                                    //               .size
                                    //               .width *
                                    //           0.07,
                                    //     ),
                                    //     Padding(
                                    //       padding: const EdgeInsets.fromLTRB(
                                    //           5, 0, 3, 0),
                                    //       child: Text(
                                    //         '${displayNpc.amount}',
                                    //         style: TextStyle(
                                    //           fontFamily: 'Headline',
                                    //           height: 1,
                                    //           fontSize: 15,
                                    //           color: Colors.white,
                                    //           letterSpacing: 3,
                                    //         ),
                                    //       ),
                                    //     ),
                                    //   ],
                                    // ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: <Widget>[
                                        SvgPicture.asset(
                                          'assets/item/pArmor.svg',
                                          color: Colors.grey[700],
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.055,
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.fromLTRB(
                                              5, 0, 3, 0),
                                          child: Text(
                                            '${displayNpc.totalLoot}',
                                            style: TextStyle(
                                              fontFamily: 'Headline',
                                              height: 1,
                                              fontSize: 15,
                                              color: Colors.white,
                                              letterSpacing: 3,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: <Widget>[
                                        SvgPicture.asset(
                                          'assets/item/mDamage.svg',
                                          color: Colors.grey[700],
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.065,
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.fromLTRB(
                                              5, 0, 3, 0),
                                          child: Text(
                                            '${displayNpc.totalXp}',
                                            style: TextStyle(
                                              fontFamily: 'Headline',
                                              height: 1,
                                              fontSize: 15,
                                              color: Colors.white,
                                              letterSpacing: 3,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              TextButton(
                                style: TextButton.styleFrom(
                                  padding:
                                      const EdgeInsets.fromLTRB(0, 10, 0, 10),
                                ),
                                onPressed: () {
                                  setState(() {
                                    finishNewNpc();
                                  });
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

//LAYOUT ADAPTATION

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Expanded(
          flex: 2,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  height: double.infinity,
                  // color: Colors.green,
                  child: ListView.separated(
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    padding: const EdgeInsets.fromLTRB(13, 0, 0, 0),
                    itemCount: widget.dsix.gm.npcList.length,
                    itemBuilder: (BuildContext context, int index) {
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            selectNpc(index);
                          });
                        },
                        child: Container(
                          height: 35,
                          width: 35,
                          child: SvgPicture.asset(
                            'assets/gm/npc/race/${widget.dsix.gm.npcList[index].icon}.svg',
                            color: Colors.grey[400],
                          ),
                        ),
                      );
                    },
                    separatorBuilder: (BuildContext context, int index) {
                      return SizedBox(
                        height: 10,
                        width: 10,
                      );
                    },
                  ),
                )
              ],
            ),
          ),
        ),
        Divider(
          height: 0,
          thickness: 2,
          color: Colors.grey[700],
        ),
        Expanded(
          flex: 13,
          child: IndexedStack(
            index: _layoutIndex,
            children: [
              Expanded(
                child: Container(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(65, 15, 65, 0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${displayNpc.name}',
                          style: TextStyle(
                            fontFamily: 'Headline',
                            height: 1.3,
                            fontSize: 30,
                            color: Colors.grey[700],
                            letterSpacing: 2,
                          ),
                        ),
                        Text(
                          '${displayNpc.description}',
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
                            padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                          ),
                          onPressed: () {
                            startNewNpc();
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
                                    'NEW NPC',
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
              ),
              Expanded(
                child: Column(
                  children: [
                    Expanded(
                      flex: 6,
                      child: Container(
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(65, 15, 65, 0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    '${displayNpc.name}',
                                    style: TextStyle(
                                      fontFamily: 'Headline',
                                      height: 1.3,
                                      fontSize: 30,
                                      color: Colors.grey[700],
                                      letterSpacing: 2,
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        deleteNpc();
                                      });
                                    },
                                    child: Icon(
                                      Icons.clear,
                                      color: Colors.red,
                                      size: 20,
                                    ),
                                  )
                                ],
                              ),
                              Text(
                                '${displayNpc.selectedRace.description}',
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
                        // color: Colors.green,
                      ),
                    ),
                    Divider(
                      thickness: 2,
                      color: Colors.grey[700],
                    ),
                    SizedBox(
                      height: 30,
                      width: double.infinity,
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(20, 3, 20, 3),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                SvgPicture.asset(
                                  'assets/gm/npc/race/${displayNpc.selectedRace.icon}.svg',
                                  color: Colors.grey[700],
                                  width:
                                      MediaQuery.of(context).size.width * 0.06,
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(5, 0, 0, 0),
                                  child: Text(
                                    '${displayNpc.amount}',
                                    style: TextStyle(
                                      fontFamily: 'Headline',
                                      height: 1,
                                      fontSize: 15,
                                      color: Colors.white,
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
                                  'assets/item/pDamage.svg',
                                  color: Colors.grey[700],
                                  width:
                                      MediaQuery.of(context).size.width * 0.055,
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(5, 0, 3, 0),
                                  child: Text(
                                    '${displayNpc.selectedType.pDamage}',
                                    style: TextStyle(
                                      fontFamily: 'Headline',
                                      height: 1,
                                      fontSize: 15,
                                      color: Colors.white,
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
                                  'assets/item/pArmor.svg',
                                  color: Colors.grey[700],
                                  width:
                                      MediaQuery.of(context).size.width * 0.055,
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(5, 0, 3, 0),
                                  child: Text(
                                    '${displayNpc.selectedType.pArmor}',
                                    style: TextStyle(
                                      fontFamily: 'Headline',
                                      height: 1,
                                      fontSize: 15,
                                      color: Colors.white,
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
                                  'assets/item/mDamage.svg',
                                  color: Colors.grey[700],
                                  width:
                                      MediaQuery.of(context).size.width * 0.065,
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(5, 0, 3, 0),
                                  child: Text(
                                    '${displayNpc.selectedType.mDamage}',
                                    style: TextStyle(
                                      fontFamily: 'Headline',
                                      height: 1,
                                      fontSize: 15,
                                      color: Colors.white,
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
                                  'assets/item/mArmor.svg',
                                  color: Colors.grey[700],
                                  width:
                                      MediaQuery.of(context).size.width * 0.055,
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(5, 0, 3, 0),
                                  child: Text(
                                    '${displayNpc.selectedType.mArmor}',
                                    style: TextStyle(
                                      fontFamily: 'Headline',
                                      height: 1,
                                      fontSize: 15,
                                      color: Colors.white,
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
                      thickness: 2,
                      color: Colors.grey[700],
                    ),
                    Expanded(
                      flex: 7,
                      child: Row(
                        children: [
                          Expanded(
                            flex: 1,
                            child: Container(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        displayNpc.changeHealth(1);
                                      });
                                    },
                                    child: Icon(
                                      Icons.keyboard_arrow_up,
                                      color: Colors.white,
                                      size: 35,
                                    ),
                                  ),
                                  Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(0, 0, 0, 0),
                                    child: Container(
                                      width: 115,
                                      height: 115,
                                      child: Stack(
                                        children: [
                                          Center(
                                            child: SvgPicture.asset(
                                              'assets/gm/npc/health.svg',
                                              color: Colors.grey[400],
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.4,
                                            ),
                                          ),
                                          Center(
                                            child: Text(
                                              '${displayNpc.currentHealth}',
                                              style: TextStyle(
                                                fontFamily: 'Headline',
                                                fontSize: 35,
                                                color: Colors.black,
                                                letterSpacing: 3,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      // color: Colors.yellow,
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        displayNpc.changeHealth(-1);
                                      });
                                    },
                                    child: Icon(
                                      Icons.keyboard_arrow_down,
                                      color: Colors.white,
                                      size: 35,
                                    ),
                                  ),
                                ],
                              ),
                              // color: Colors.pink,
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: Container(
                              child: Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.fromLTRB(
                                        15, 20, 15, 10),
                                    child: Center(
                                      child: Text(
                                        'Npc Skills',
                                        style: TextStyle(
                                          fontFamily: 'Headline',
                                          height: 1,
                                          fontSize: 20,
                                          color: Colors.grey[700],
                                          letterSpacing: 3,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.fromLTRB(
                                        15, 10, 15, 0),
                                    child: GridView.count(
                                      shrinkWrap: true,
                                      crossAxisCount: 2,
                                      crossAxisSpacing: 10,
                                      children: List.generate(
                                          displayNpc.selectedSkills.length,
                                          (index) {
                                        return GestureDetector(
                                          onTap: () {
                                            setState(() {
                                              openSkill(displayNpc
                                                  .selectedSkills[index]);
                                              // showAlertDialogSkills(context,
                                              //     displayNpc.selectedSkills[index]);
                                            });
                                          },
                                          child: Container(
                                            width: 50,
                                            height: 50,
                                            // color: Colors.amberAccent,
                                            child: Center(
                                              child: SvgPicture.asset(
                                                'assets/gm/npc/skill/${displayNpc.selectedSkills[index].skillType}/${displayNpc.selectedSkills[index].icon}.svg',
                                                color: Colors.grey[400],
                                              ),
                                            ),
                                          ),
                                        );
                                      }),
                                    ),
                                  ),
                                ],
                              ),
                              // color: Colors.purple,
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: Container(
                              child: Center(
                                child: GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      npcAction();
                                    });
                                  },
                                  child: Container(
                                    width: 90,
                                    height: 90,
                                    color: Colors.grey[400],
                                    child: Center(
                                      child: Text(
                                        '$actionResult',
                                        style: TextStyle(
                                          fontFamily: 'Headline',
                                          fontSize: 35,
                                          color: Colors.black,
                                          letterSpacing: 3,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
