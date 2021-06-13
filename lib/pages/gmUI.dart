import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'playersPage.dart';

import 'storyPage.dart';
import 'lootPage.dart';
import 'settingsPage.dart';
import 'package:dsixv02app/models/game/dsix.dart';
import 'characterPage.dart';
import 'package:dsixv02app/models/gm/character.dart';
import 'package:dsixv02app/models/gm/characterSkill.dart';

class GmUI extends StatefulWidget {
  final Dsix dsix;

  const GmUI({
    Key key,
    this.dsix,
  }) : super(key: key);

  static const String routeName = "/gmUI";

  @override
  _GmUIState createState() => new _GmUIState();
}

class _GmUIState extends State<GmUI> {
  refreshPage() {
    setState(() {});
  }

  int bottomSelectedIndex = 0;
  String pageTitle = 'STORY';

  void pageChanged(int index) {
    setState(() {
      bottomSelectedIndex = index;
      switch (index) {
        case 0:
          {
            pageTitle = 'SETTINGS';
          }
          break;
        case 1:
          {
            pageTitle = 'STORY';
          }
          break;
        case 2:
          {
            pageTitle = 'NPC';
          }
          break;
        case 3:
          {
            pageTitle = 'LOOT';
          }
          break;
        case 4:
          {
            pageTitle = 'ACTION';
          }
          break;
        case 5:
          {
            pageTitle = 'MAP';
          }
          break;
      }
    });
  }

  void bottomTapped(int index) {
    setState(() {
      switch (index) {
        case 0:
          {
            pageTitle = 'SETTINGS';
          }
          break;
        case 1:
          {
            pageTitle = 'STORY';
          }
          break;
        case 2:
          {
            pageTitle = 'NPC';
          }
          break;
        case 3:
          {
            pageTitle = 'LOOT';
          }
          break;
        case 4:
          {
            pageTitle = 'ACTION';
          }
          break;
        case 5:
          {
            pageTitle = 'MAP';
          }
          break;
      }
      bottomSelectedIndex = index;
      pageController.animateToPage(index,
          duration: Duration(milliseconds: 500), curve: Curves.ease);
    });
  }

  List<BottomNavigationBarItem> buildBottomNavBarItems() {
    return [
      BottomNavigationBarItem(
        activeIcon: new SvgPicture.asset(
          'assets/gm/settings.svg',
          color: Colors.white,
          width: MediaQuery.of(context).size.width * 0.085,
        ),
        icon: new SvgPicture.asset(
          'assets/gm/settings.svg',
          color: Colors.grey[600],
          width: MediaQuery.of(context).size.width * 0.075,
        ),
        label: 'SETTINGS',
      ),
      BottomNavigationBarItem(
        activeIcon: new SvgPicture.asset(
          'assets/gm/story.svg',
          color: Colors.white,
          width: MediaQuery.of(context).size.width * 0.1,
        ),
        icon: new SvgPicture.asset(
          'assets/gm/story.svg',
          color: Colors.grey[600],
          width: MediaQuery.of(context).size.width * 0.1,
        ),
        label: 'STORY',
      ),
      BottomNavigationBarItem(
        activeIcon: new SvgPicture.asset(
          'assets/gm/npc.svg',
          color: Colors.white,
          width: MediaQuery.of(context).size.width * 0.085,
        ),
        icon: new SvgPicture.asset(
          'assets/gm/npc.svg',
          color: Colors.grey[600],
          width: MediaQuery.of(context).size.width * 0.085,
        ),
        label: 'NPC',
      ),
      BottomNavigationBarItem(
        activeIcon: new SvgPicture.asset(
          'assets/gm/loot.svg',
          color: Colors.white,
          width: MediaQuery.of(context).size.width * 0.085,
        ),
        icon: new SvgPicture.asset(
          'assets/gm/loot.svg',
          color: Colors.grey[600],
          width: MediaQuery.of(context).size.width * 0.085,
        ),
        label: 'LOOT',
      ),
      BottomNavigationBarItem(
        activeIcon: new SvgPicture.asset(
          'assets/player/action.svg',
          color: Colors.white,
          width: MediaQuery.of(context).size.width * 0.075,
        ),
        icon: new SvgPicture.asset(
          'assets/player/action.svg',
          color: Colors.grey[600],
          width: MediaQuery.of(context).size.width * 0.065,
        ),
        label: '',
      ),
      BottomNavigationBarItem(
        activeIcon: new SvgPicture.asset(
          'assets/player/map.svg',
          color: Colors.white,
          width: MediaQuery.of(context).size.width * 0.1,
        ),
        icon: new SvgPicture.asset(
          'assets/player/map.svg',
          color: Colors.grey[600],
          width: MediaQuery.of(context).size.width * 0.1,
        ),
        label: '',
      ),
    ];
  }

  PageController pageController = PageController(
    initialPage: 0,
    keepPage: true,
  );

  Widget buildPageView() {
    return PageView(
      controller: pageController,
      onPageChanged: (index) {
        pageChanged(index);
      },
      children: <Widget>[
        SettingsPage(
          dsix: widget.dsix,
          refresh: refreshPage,
          pageChanged: bottomTapped,
          alert: displayAlert,
        ),
        StoryPage(
          dsix: widget.dsix,
          refresh: refreshPage,
          alert: displayAlert,
        ),
        CharacterPage(
          dsix: widget.dsix,
          refresh: refreshPage,
          pageChanged: bottomTapped,
          alert: displayAlert,
        ),
        LootPage(
          dsix: widget.dsix,
          refresh: refreshPage,
          alert: displayAlert,
        ),
        CharacterPage(dsix: widget.dsix, refresh: refreshPage),
        CharacterPage(dsix: widget.dsix, refresh: refreshPage),
      ],
    );
  }

  Route _createRouteHome() {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) =>
          PlayersPage(dsix: widget.dsix),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        var begin = Offset(-1, 0);
        var end = Offset(0.0, 0.0);
        var curve = Curves.ease;
        var tween =
            Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

        return SlideTransition(
          position: animation.drive(tween),
          child: child,
        );
      },
    );
  }

  // final globalScaffoldKey = GlobalKey<ScaffoldState>();

  showAlertDialogChooseCharacter(BuildContext context, Character character) {
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
            width: 300,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Container(
                  color: Colors.grey[700],
                  width: double.infinity,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(0, 5, 0, 7),
                    child: Center(
                      child: Text(
                        '${character.name}',
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
                ), //ITEM NAME
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                  child: SizedBox(
                    height: 200,
                    width: double.infinity,
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(10, 15, 10, 10),
                      child: SvgPicture.asset(
                        'assets/gm/character/race/image/${character.image}.svg',
                        color: Colors.grey[700],
                      ),
                    ),
                  ),
                ),

                Divider(thickness: 2, color: Colors.grey[700]),

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
                              'assets/gm/character/health.svg',
                              color: Colors.grey[700],
                              width: MediaQuery.of(context).size.width * 0.045,
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(5, 0, 0, 0),
                              child: Text(
                                '${character.baseHealth}',
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
                              width: MediaQuery.of(context).size.width * 0.055,
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(5, 0, 3, 0),
                              child: Text(
                                '${character.pDamage}',
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
                                '${character.mDamage}',
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
                                '${character.pArmor}',
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
                                '${character.mArmor}',
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

                Container(
                  width: double.infinity,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(35, 10, 35, 10),
                    child: Text(
                      '${character.description}',
                      textAlign: TextAlign.justify,
                      style: TextStyle(
                        height: 1.25,
                        fontSize: 19,
                        fontFamily: 'Calibri',
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.fromLTRB(30, 5, 30, 10),
                  child: TextButton(
                    onPressed: () {
                      setState(() {
                        widget.dsix.gm.newCharacter(character);

                        Navigator.pop(context);
                        Navigator.pop(context);

                        showAlertDialogAmount(
                            context, widget.dsix.gm.selectedCharacter);
                      });
                    },
                    style: TextButton.styleFrom(
                      padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                    ),
                    child: Container(
                      height: MediaQuery.of(context).size.height * 0.058,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.grey[400],
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
                                padding: const EdgeInsets.fromLTRB(0, 0, 10, 2),
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
                              'CHOOSE',
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
        ],
      ),
    );

    showDialog(
      // context: globalScaffoldKey.currentContext,
      context: context,
      builder: (BuildContext context) {
        return alerta;
      },
    );
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
                                            character.setAmount(-5);
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
                                                    character.setAmount(1);
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
                                                    '${character.amount}',
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
                                                    character.setAmount(-1);
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
                                            character.setAmount(5);
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
                                            '${character.totalLoot}',
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
                                            '${character.totalXp}',
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
                                    widget.dsix.gm.confirmCharacter();
                                    refreshPage();
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

  showAlertDialogChooseSkill(BuildContext context, CharacterSkill skill) {
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
            width: 300,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Container(
                  color: Colors.grey[700],
                  width: double.infinity,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(0, 5, 0, 7),
                    child: Center(
                      child: Text(
                        '${skill.name}',
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
                ), //ITEM NAME
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                  child: SizedBox(
                    height: 200,
                    width: double.infinity,
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(10, 15, 10, 10),
                      child: SvgPicture.asset(
                        'assets/gm/character/skill/${skill.skillType}/${skill.icon}.svg',
                        color: Colors.grey[400],
                      ),
                    ),
                  ),
                ),

                Divider(thickness: 2, color: Colors.grey[700]),

                Container(
                  width: double.infinity,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(35, 10, 35, 10),
                    child: Text(
                      '${skill.description}',
                      textAlign: TextAlign.justify,
                      style: TextStyle(
                        height: 1.25,
                        fontSize: 19,
                        fontFamily: 'Calibri',
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.fromLTRB(30, 5, 30, 10),
                  child: TextButton(
                    onPressed: () {
                      setState(() {
                        widget.dsix.gm.selectedCharacter.chooseSkill(skill);
                        Navigator.pop(context);
                        Navigator.pop(context);
                      });
                    },
                    style: TextButton.styleFrom(
                      padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                    ),
                    child: Container(
                      height: MediaQuery.of(context).size.height * 0.058,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.grey[400],
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
                                padding: const EdgeInsets.fromLTRB(0, 0, 10, 2),
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
                              'CHOOSE',
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
        ],
      ),
    );

    showDialog(
      // context: globalScaffoldKey.currentContext,
      context: context,
      builder: (BuildContext context) {
        return alerta;
      },
    );
  }

  SnackBar displayAlert(String description) {
    SnackBar newAlert = new SnackBar(
      content: Container(
        height: MediaQuery.of(context).size.height * 0.05,
        child: Text(
          description,
          textAlign: TextAlign.center,
          style: TextStyle(
            height: 1.25,
            fontSize: 22,
            fontFamily: 'Calibri',
            color: Colors.white,
          ),
        ),
      ),
    );
    return newAlert;
  }

  Widget build(BuildContext context) {
    return new Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
          leading: Padding(
            padding: const EdgeInsets.fromLTRB(5, 2, 0, 0),
            child: IconButton(
              icon: Icon(
                Icons.exit_to_app,
                color: Colors.grey[400],
                size: 30,
              ),
              onPressed: () {
                Navigator.of(context).push(_createRouteHome());
              },
            ),
          ),
          titleSpacing: 10,
          backgroundColor: Colors.grey[900],
          title: new Text(
            '$pageTitle',
            textAlign: TextAlign.left,
            style: TextStyle(
              fontFamily: 'Headline',
              height: 1.3,
              fontSize: 24.0,
              color: Colors.grey[600],
              letterSpacing: 2,
            ),
          ),
          actions: <Widget>[
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 0, 20, 0),
              child: Container(
                width: MediaQuery.of(context).size.width * 0.5,
                child: new Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () {},
                      child: Row(
                        children: <Widget>[
                          SvgPicture.asset(
                            'assets/gm/players.svg',
                            color: Colors.white,
                            width: MediaQuery.of(context).size.width * 0.08,
                          ),
                          Text(
                            '${widget.dsix.gm.numberPlayers}',
                            textAlign: TextAlign.left,
                            style: TextStyle(
                              fontFamily: 'Headline',
                              height: 1.1,
                              fontSize: 25,
                              color: Colors.white,
                              letterSpacing: 2,
                            ),
                          ),
                        ],
                      ),
                    ),
                    GestureDetector(
                      onTap: () {},
                      child: Row(
                        children: <Widget>[
                          SvgPicture.asset(
                            'assets/gm/xp.svg',
                            color: Colors.white,
                            width: MediaQuery.of(context).size.width * 0.08,
                          ),
                          Text(
                            '${widget.dsix.gm.totalXp}',
                            textAlign: TextAlign.left,
                            style: TextStyle(
                              fontFamily: 'Headline',
                              height: 1.1,
                              fontSize: 25,
                              color: Colors.white,
                              letterSpacing: 2,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Builder(
                      builder: (BuildContext context) {
                        return GestureDetector(
                          onTap: () {
                            ScaffoldMessenger.of(context)
                                .showSnackBar(displayAlert('NEW TURN'));
                            widget.dsix.gm.newTurn();
                          },
                          child: SvgPicture.asset(
                            'assets/player/action.svg',
                            color: Colors.white,
                            width: MediaQuery.of(context).size.width * 0.05,
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            )
          ]),
      drawerEnableOpenDragGesture: false,
      endDrawerEnableOpenDragGesture: false,
      drawer: Container(
        width: MediaQuery.of(context).size.width * 0.65,
        child: Drawer(
          child: ListView.builder(
              itemCount: widget.dsix.gm.availableCharacters.length,
              itemBuilder: (BuildContext context, int index) {
                return Column(
                  children: [
                    Divider(
                      height: 0,
                      thickness: 2,
                      color: Colors.black,
                    ),
                    ListTile(
                      onTap: () {
                        setState(() {
                          // Navigator.pop(context);
                          showAlertDialogChooseCharacter(context,
                              widget.dsix.gm.availableCharacters[index]);
                        });
                      },
                      tileColor: Colors.grey[700],
                      leading: SvgPicture.asset(
                        'assets/gm/character/race/icon/${widget.dsix.gm.availableCharacters[index].icon}.svg',
                        color: Colors.black,
                        width: MediaQuery.of(context).size.width * 0.125,
                      ),
                      title: Text(
                        '${widget.dsix.gm.availableCharacters[index].name}',
                        style: TextStyle(
                          fontFamily: 'Headline',
                          height: 1,
                          fontSize: 21,
                          color: Colors.black,
                          letterSpacing: 1.5,
                        ),
                      ),
                      subtitle: Text(
                        'XP: ${widget.dsix.gm.availableCharacters[index].baseXp}',
                        style: TextStyle(
                          height: 1.3,
                          fontSize: 14,
                          fontFamily: 'Calibri',
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                );
              }),
        ),
      ),
      endDrawer: Container(
        width: MediaQuery.of(context).size.width * 0.5,
        child: Drawer(
          child: Container(
            color: Colors.grey[700],
            child: Center(
              child: ListView.builder(
                  itemCount:
                      widget.dsix.gm.selectedCharacter.availableSkills.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Column(
                      children: [
                        Divider(
                          height: 0,
                          thickness: 2,
                          color: Colors.black,
                        ),
                        ListTile(
                          onTap: () {
                            setState(() {
                              showAlertDialogChooseSkill(
                                  context,
                                  widget.dsix.gm.selectedCharacter
                                      .availableSkills[index]);
                            });
                          },
                          tileColor: Colors.grey[700],
                          leading: SvgPicture.asset(
                            'assets/gm/character/skill/${widget.dsix.gm.selectedCharacter.availableSkills[index].skillType}/${widget.dsix.gm.selectedCharacter.availableSkills[index].icon}.svg',
                            color: Colors.black,
                            width: MediaQuery.of(context).size.width * 0.1,
                          ),
                          title: Text(
                            '${widget.dsix.gm.selectedCharacter.availableSkills[index].name}',
                            style: TextStyle(
                              fontFamily: 'Headline',
                              height: 1,
                              fontSize: 21,
                              color: Colors.black,
                              letterSpacing: 1.5,
                            ),
                          ),
                        ),
                      ],
                    );
                  }),
            ),
          ),
        ),
      ),
      body: new SafeArea(
        child: buildPageView(),
      ),
      bottomNavigationBar: BottomNavigationBar(
        selectedLabelStyle: TextStyle(
          color: Colors.grey[600],
        ),
        unselectedLabelStyle: TextStyle(
          color: Colors.grey[600],
        ),
        type: BottomNavigationBarType.fixed,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        backgroundColor: Colors.grey[900],
        currentIndex: bottomSelectedIndex,
        onTap: (index) {
          bottomTapped(index);
        },
        items: buildBottomNavBarItems(),
      ),
    );
  }
}
