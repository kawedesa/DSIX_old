import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:dsixv02app/models/game/dsix.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../models/gm/npcSkill.dart';

class NpcPage extends StatefulWidget {
  final Function() refresh;
  final Dsix dsix;

  NpcPage({
    Key key,
    this.dsix,
    this.refresh,
  }) : super(key: key);

  static const String routeName = "/npcPage";

  @override
  _NpcPageState createState() => new _NpcPageState();
}

class _NpcPageState extends State<NpcPage> {
  NpcSkill displaySkill = NpcSkill(
    icon: 'skill',
    name: 'SKILL',
    skillType: 'null',
    description: 'Skill',
    value: 0,
  );

  String actionResult = 'Roll';

  List<bool> npcSelection;

  void selectNpc(int index) {
    widget.dsix.gm.npcLayout = 1;
    widget.dsix.gm.selectedNpc = widget.dsix.gm.npcList[index];
    actionResult = 'Roll';
  }

  void deleteNpc() {
    widget.dsix.gm.npcList.remove(widget.dsix.gm.selectedNpc);

    widget.dsix.gm.npcLayout = 0;
  }

  void npcAction() {
    if (actionResult != 'Roll') {
      actionResult = 'Roll';
      return;
    }

    actionResult = widget.dsix.gm.selectedNpc.npcAction();
  }

  void openSkill(NpcSkill skill) {
    widget.dsix.gm.selectedNpc.skillList =
        widget.dsix.gm.selectedNpc.openSkill(skill);

    if (widget.dsix.gm.selectedNpc.skillList.isEmpty) {
      return;
    }

    widget.refresh();

    Scaffold.of(context).openEndDrawer();
  }

  Widget _healthToLoot;

  void rollLoot() {
    widget.dsix.gm.createLoot(widget.dsix.gm.selectedNpc.totalLoot);
    widget.dsix.gm.lootList.last.name = '${widget.dsix.gm.selectedNpc.name}';
    deleteNpc();
  }

  @override
  Widget build(BuildContext context) {
//HEALTH TO LOOT

    if (widget.dsix.gm.selectedNpc.currentHealth < 1 &&
        widget.dsix.gm.selectedNpc.totalLoot > 0) {
      _healthToLoot = GestureDetector(
        onTap: () {
          setState(() {
            rollLoot();
          });
        },
        child: Padding(
          padding: const EdgeInsets.fromLTRB(7, 0, 7, 5),
          child: SvgPicture.asset(
            'assets/gm/npc/loot.svg',
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
              'assets/gm/npc/health.svg',
              color: Colors.grey[700],
            ),
          ),
          Center(
            child: Text(
              '${widget.dsix.gm.selectedNpc.currentHealth}',
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
    npcSelection = [];
    widget.dsix.gm.npcList.forEach((element) {
      if (element == widget.dsix.gm.selectedNpc) {
        npcSelection.add(true);
      } else {
        npcSelection.add(false);
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
                      widget.dsix.gm.npcLayout = 0;
                      // Scaffold.of(context).openDrawer();
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
                            'assets/gm/npc/race/icon/${widget.dsix.gm.npcList[index].icon}.svg',
                            color: npcSelection[index]
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
          index: widget.dsix.gm.npcLayout,
          children: [
            Container(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(65, 15, 65, 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'NPC',
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
                        'An NPC is a character that you control. So pretty much eveyone besides the players. Click on the the buttons below to create a new NPC.',
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
                        Scaffold.of(context).openDrawer();
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
                                      '${widget.dsix.gm.selectedNpc.name}',
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
                                              'assets/gm/npc/loot.svg',
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
                                                '${widget.dsix.gm.selectedNpc.totalLoot}',
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
                                                'assets/gm/npc/xp.svg',
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
                                                  '${widget.dsix.gm.selectedNpc.totalXp}',
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
                                    '${widget.dsix.gm.selectedNpc.description}',
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
                                        'assets/gm/npc/race/image/${widget.dsix.gm.selectedNpc.image}.svg',
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
                                          deleteNpc();
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
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            SvgPicture.asset(
                              'assets/gm/npc/race/icon/${widget.dsix.gm.selectedNpc.icon}.svg',
                              color: Colors.grey[700],
                              width: MediaQuery.of(context).size.width * 0.06,
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(5, 0, 0, 0),
                              child: Text(
                                '${widget.dsix.gm.selectedNpc.amount}',
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
                                '${widget.dsix.gm.selectedNpc.pDamage}',
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
                                '${widget.dsix.gm.selectedNpc.pArmor}',
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
                                '${widget.dsix.gm.selectedNpc.mDamage}',
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
                                '${widget.dsix.gm.selectedNpc.mArmor}',
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
                                widget.dsix.gm.selectedNpc.changeHealth(10);
                              });
                            },
                            onTap: () {
                              setState(() {
                                widget.dsix.gm.selectedNpc.changeHealth(1);
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
                                widget.dsix.gm.selectedNpc.changeHealth(-10);
                              });
                            },
                            onTap: () {
                              setState(() {
                                widget.dsix.gm.selectedNpc.changeHealth(-1);
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
                                'Npc Skills',
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
                                  widget.dsix.gm.selectedNpc.selectedSkills
                                      .length, (index) {
                                return GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      openSkill(widget.dsix.gm.selectedNpc
                                          .selectedSkills[index]);
                                    });
                                  },
                                  child: Center(
                                    child: SvgPicture.asset(
                                      'assets/gm/npc/skill/${widget.dsix.gm.selectedNpc.selectedSkills[index].skillType}/${widget.dsix.gm.selectedNpc.selectedSkills[index].icon}.svg',
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
                              npcAction();
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
