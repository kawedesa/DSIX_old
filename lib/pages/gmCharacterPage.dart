import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:dsixv02app/models/dsix/dsix.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:dsixv02app/models/gm/character.dart';

import 'package:dsixv02app/models/gm/characterSkill.dart';

class CharacterPage extends StatefulWidget {
  final Function(String) alert;
  final Function(int index) pageChanged;
  final Function() refresh;
  final Dsix dsix;

  CharacterPage(
      {Key key, this.dsix, this.refresh, this.pageChanged, this.alert})
      : super(key: key);

  static const String routeName = "/characterPage";

  @override
  _CharacterPageState createState() => new _CharacterPageState();
}

class _CharacterPageState extends State<CharacterPage> {
  String actionResult = 'Roll';
  int _layout = 0;
  List<bool> characterSelection;

  void newCharacter(String environment) {
    widget.dsix.gm.availableCharacter(environment);
    widget.refresh();
    Scaffold.of(context).openDrawer();
  }

  void characterAction() {
    if (actionResult != 'Roll') {
      actionResult = 'Roll';
      return;
    }

    actionResult = widget.dsix.gm.selectedCharacter.characterAction();
  }

  void openSkill(CharacterSkill skill) {
    if (skill.name == 'ABILITY' || skill.name == 'SPELL') {
      widget.dsix.gm.selectedCharacter.openSkill(skill);
    } else {
      return;
    }

    widget.refresh();

    Scaffold.of(context).openEndDrawer();
  }

  Widget _healthToLoot;

  int displayAmount;
  int displayXp;
  int displayLoot;

  void changeAmount(int value) {
    if (displayAmount + value < 1) {
      displayAmount = 0;
      return;
    }

    displayAmount += value;

    displayXp = widget.dsix.gm.selectedCharacter.baseXp * displayAmount;
    displayLoot =
        (widget.dsix.gm.selectedCharacter.baseLoot * displayAmount).toInt();
  }

  showAlertDialogAmount(BuildContext context, Character character) {
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
                                            changeAmount(-5);
                                          });
                                        },
                                        child: Align(
                                          alignment: Alignment.centerRight,
                                          child: Text(
                                            '- 5',
                                            style: TextStyle(
                                              fontFamily: 'Headline',
                                              fontSize: 20.0,
                                              color: Colors.white,
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
                                                    changeAmount(1);
                                                  });
                                                },
                                                child: Icon(
                                                  Icons.keyboard_arrow_up,
                                                  color: Colors.white,
                                                  size: 35,
                                                ),
                                              ),
                                              Container(
                                                // width: 100,
                                                // height: 100,
                                                // color: Colors.white,
                                                child: Center(
                                                  child: Text(
                                                    '$displayAmount',
                                                    style: TextStyle(
                                                      fontFamily: 'Headline',
                                                      height: 1.3,
                                                      fontSize: 35.0,
                                                      color: Colors.grey[700],
                                                      letterSpacing: 2,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              GestureDetector(
                                                onTap: () {
                                                  setState(() {
                                                    changeAmount(-1);
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
                                          // color: Colors.red,
                                        )),
                                      ),
                                    ),
                                    Expanded(
                                      flex: 1,
                                      child: GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            changeAmount(5);
                                          });
                                        },
                                        child: Align(
                                          alignment: Alignment.centerLeft,
                                          child: Text(
                                            '+ 5',
                                            style: TextStyle(
                                              fontFamily: 'Headline',
                                              fontSize: 20.0,
                                              color: Colors.white,
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
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: <Widget>[
                                        SvgPicture.asset(
                                          'assets/gm/character/loot.svg',
                                          color: Colors.grey[700],
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.065,
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.fromLTRB(
                                              10, 0, 3, 0),
                                          child: Text(
                                            '$displayLoot',
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
                                          'assets/gm/character/xp.svg',
                                          color: Colors.grey[700],
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.065,
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.fromLTRB(
                                              10, 0, 3, 0),
                                          child: Text(
                                            '$displayXp',
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
                                    character.changeAmount(
                                        displayAmount - character.amount);

                                    widget.refresh();
                                    Navigator.pop(context);
                                  });
                                },
                                child: Container(
                                  height: MediaQuery.of(context).size.height *
                                      0.058,
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: Colors.grey[400],
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
                                              color: Colors.grey[400],
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

  @override
  Widget build(BuildContext context) {
    //LAYOUT

    // if (widget.dsix.gm.characters.isEmpty) {
    //   _layout = 0;
    // } else {
    //   _layout = 1;
    // }

    //HEALTH TO LOOT

    if (widget.dsix.gm.selectedCharacter.currentHealth < 1 &&
        widget.dsix.gm.selectedCharacter.totalLoot > 0) {
      _healthToLoot = GestureDetector(
        onTap: () {
          setState(() {
            widget.dsix.gm.characterLoot();
            _layout = 0;
            widget.pageChanged(3);
            widget.refresh();
          });
        },
        child: Padding(
          padding: const EdgeInsets.fromLTRB(7, 0, 7, 5),
          child: SvgPicture.asset(
            'assets/gm/character/loot.svg',
            color: Colors.grey[700],
          ),
        ),
      );
    } else {
      _healthToLoot = Stack(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 0, 0, 5),
            child: SvgPicture.asset(
              'assets/gm/character/health.svg',
              color: Colors.grey[700],
            ),
          ),
          Center(
            child: Text(
              '${widget.dsix.gm.selectedCharacter.currentHealth}',
              style: TextStyle(
                fontFamily: 'Headline',
                fontSize: 35,
                color: Colors.black,
                letterSpacing: 3,
              ),
            ),
          ),
        ],
      );
    }

//NPC SELECTION
    characterSelection = [];
    widget.dsix.gm.characters.forEach((element) {
      if (element == widget.dsix.gm.selectedCharacter) {
        characterSelection.add(true);
      } else {
        characterSelection.add(false);
      }
    });

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
                      // Scaffold.of(context).openDrawer();
                      _layout = 0;
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
                    itemCount: widget.dsix.gm.characters.length,
                    itemBuilder: (BuildContext context, int index) {
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            widget.dsix.gm.selectCharacter(index);
                            _layout = 1;
                          });
                        },
                        child: Container(
                          height: 35,
                          width: 35,
                          child: SvgPicture.asset(
                            'assets/gm/character/race/icon/${widget.dsix.gm.characters[index].icon}.svg',
                            color: characterSelection[index]
                                ? Colors.grey[400]
                                : Colors.grey[700],
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
          index: _layout,
          children: [
            Container(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(65, 15, 65, 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'CHARACTER',
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
                        'The world is filled with unique characters. Create a new character by clicking on the buttons below.',
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
                        padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                      ),
                      onPressed: () {
                        newCharacter('MOUNTAINS');
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
                                  padding:
                                      const EdgeInsets.fromLTRB(0, 0, 10, 0),
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
                                'MOUNTAINS',
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
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                  child: Container(
                    height: MediaQuery.of(context).size.height * 0.3,

                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Container(
                              width: MediaQuery.of(context).size.width * 0.52,
                              height: MediaQuery.of(context).size.height * 0.3,
                              // color: Colors.amber,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(0, 15, 0, 0),
                                    child: Text(
                                      '${widget.dsix.gm.selectedCharacter.name}',
                                      style: TextStyle(
                                        fontFamily: 'Headline',
                                        height: 1.3,
                                        fontSize: 30,
                                        color: Colors.grey[700],
                                        letterSpacing: 2,
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(0, 5, 0, 0),
                                    child: Row(
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: <Widget>[
                                            SvgPicture.asset(
                                              'assets/gm/character/loot.svg',
                                              color: Colors.grey[700],
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.05,
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.fromLTRB(
                                                      5, 0, 0, 0),
                                              child: Text(
                                                '${widget.dsix.gm.selectedCharacter.totalLoot}',
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
                                        Padding(
                                          padding: const EdgeInsets.fromLTRB(
                                              20, 0, 0, 0),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: <Widget>[
                                              SvgPicture.asset(
                                                'assets/gm/character/xp.svg',
                                                color: Colors.grey[700],
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.05,
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.fromLTRB(
                                                        5, 0, 0, 0),
                                                child: Text(
                                                  '${widget.dsix.gm.selectedCharacter.totalXp}',
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
                                        ),
                                      ],
                                    ),
                                  ),
                                  Text(
                                    '${widget.dsix.gm.selectedCharacter.description}',
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
                            Container(
                              width: MediaQuery.of(context).size.width * 0.38,
                              // color: Colors.amberAccent,
                              child: Stack(
                                alignment: Alignment.topRight,
                                children: [
                                  Container(
                                    width: double.infinity,
                                    height: MediaQuery.of(context).size.height *
                                        0.3,
                                    // color: Colors.green,
                                    child: Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          10, 20, 10, 0),
                                      child: SvgPicture.asset(
                                        'assets/gm/character/race/image/${widget.dsix.gm.selectedCharacter.image}.svg',
                                        color: Colors.grey[700],
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(0, 10, 0, 0),
                                    child: GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          widget.dsix.gm.deleteCharacter();
                                          _layout = 0;
                                          widget.refresh();
                                        });
                                      },
                                      child: Icon(
                                        Icons.clear,
                                        color: Colors.red,
                                        size: 30,
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
                        GestureDetector(
                          onTap: () {
                            displayAmount =
                                widget.dsix.gm.selectedCharacter.amount;
                            displayXp =
                                widget.dsix.gm.selectedCharacter.totalXp;
                            displayLoot =
                                widget.dsix.gm.selectedCharacter.totalLoot;
                            showAlertDialogAmount(
                                context, widget.dsix.gm.selectedCharacter);
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              SvgPicture.asset(
                                'assets/gm/character/race/icon/${widget.dsix.gm.selectedCharacter.icon}.svg',
                                color: Colors.grey[700],
                                width: MediaQuery.of(context).size.width * 0.06,
                              ),
                              Padding(
                                padding: const EdgeInsets.fromLTRB(5, 0, 0, 0),
                                child: Text(
                                  '${widget.dsix.gm.selectedCharacter.amount}',
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
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            SvgPicture.asset(
                              'assets/item/pDamage.svg',
                              color: Colors.grey[700],
                              width: MediaQuery.of(context).size.width * 0.055,
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(5, 0, 3, 0),
                              child: Text(
                                '${widget.dsix.gm.selectedCharacter.pDamage}',
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
                              width: MediaQuery.of(context).size.width * 0.065,
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(5, 0, 3, 0),
                              child: Text(
                                '${widget.dsix.gm.selectedCharacter.mDamage}',
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
                              width: MediaQuery.of(context).size.width * 0.055,
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(5, 0, 3, 0),
                              child: Text(
                                '${widget.dsix.gm.selectedCharacter.pArmor}',
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
                              width: MediaQuery.of(context).size.width * 0.055,
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(5, 0, 3, 0),
                              child: Text(
                                '${widget.dsix.gm.selectedCharacter.mArmor}',
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width * 0.33,
                      // height: MediaQuery.of(context).size.height * 0.25,
                      // color: Colors.amberAccent,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          GestureDetector(
                            onLongPress: () {
                              setState(() {
                                widget.dsix.gm.selectedCharacter
                                    .changeHealth(10);
                              });
                            },
                            onTap: () {
                              setState(() {
                                widget.dsix.gm.selectedCharacter
                                    .changeHealth(1);
                              });
                            },
                            child: Container(
                              child: Icon(
                                Icons.keyboard_arrow_up,
                                color: Colors.white,
                                size: 45,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                            child: Container(
                              // color: Colors.amber,
                              width: 100,
                              height: 85,
                              child: AnimatedSwitcher(
                                duration: const Duration(milliseconds: 100),
                                transitionBuilder: (Widget child,
                                        Animation<double> animation) =>
                                    ScaleTransition(
                                        child: child, scale: animation),
                                child: _healthToLoot,
                              ),
                            ),
                          ),
                          GestureDetector(
                            onLongPress: () {
                              setState(() {
                                widget.dsix.gm.selectedCharacter
                                    .changeHealth(-10);
                              });
                            },
                            onTap: () {
                              setState(() {
                                widget.dsix.gm.selectedCharacter
                                    .changeHealth(-1);
                              });
                            },
                            child: Container(
                              child: Icon(
                                Icons.keyboard_arrow_down,
                                color: Colors.white,
                                size: 45,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.33,
                      height: MediaQuery.of(context).size.height * 0.25,

                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.fromLTRB(15, 10, 15, 10),
                            child: Center(
                              child: Text(
                                'Skills',
                                style: TextStyle(
                                  fontFamily: 'Headline',
                                  height: 1,
                                  fontSize: 16,
                                  color: Colors.grey[700],
                                  letterSpacing: 3,
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
                            child: GridView.count(
                              shrinkWrap: true,
                              physics: ScrollPhysics(),
                              crossAxisCount: 2,
                              children: List.generate(
                                  widget.dsix.gm.selectedCharacter
                                      .selectedSkills.length, (index) {
                                return GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      openSkill(widget.dsix.gm.selectedCharacter
                                          .selectedSkills[index]);
                                    });
                                  },
                                  child: Center(
                                    child: SvgPicture.asset(
                                      'assets/gm/character/skill/${widget.dsix.gm.selectedCharacter.selectedSkills[index].skillType}/${widget.dsix.gm.selectedCharacter.selectedSkills[index].icon}.svg',
                                      color: Colors.grey[400],
                                      width: MediaQuery.of(context).size.width *
                                          0.1,
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
                    Container(
                      height: MediaQuery.of(context).size.height * 0.25,
                      width: MediaQuery.of(context).size.width * 0.33,
                      child: Center(
                        child: GestureDetector(
                          onTap: () {
                            setState(() {
                              characterAction();
                            });
                          },
                          child: Container(
                            width: 80,
                            height: 80,
                            color: Colors.grey[700],
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
                  ],
                )
              ],
            ),
          ],
        ),
      ],
    );
  }
}
