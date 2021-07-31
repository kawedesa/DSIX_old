import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:dsixv02app/models/dsix/dsix.dart';
import 'package:dsixv02app/models/shared/item.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../models/shared/exceptions.dart';
import 'package:dsixv02app/models/player/player.dart';

class ScenePage extends StatefulWidget {
  final Function(String) alert;
  final Function() refresh;
  final Dsix dsix;

  ScenePage({Key key, this.dsix, this.refresh, this.alert}) : super(key: key);

  static const String routeName = "/scenePage";

  @override
  _ScenePageState createState() => new _ScenePageState();
}

class _ScenePageState extends State<ScenePage> {
  int _layoutIndex = 0;
  List<bool> lootSelection;
  int lootAmount;

  void chooseAmount(int value) {
    if (lootAmount + value < 2) {
      lootAmount = 1;
      return;
    }

    lootAmount += value;
  }

  List<String> ammoQuantity = [];

  List<Player> availablePlayers = [];
  void checkPlayers(Item item) {
    try {
      widget.dsix.gm.checkPlayers();
    } on NoPlayersException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(widget.alert(e.message));
      Navigator.pop(context);
      return;
    }

    availablePlayers = [];
    widget.dsix.gm.players.forEach((element) {
      if (element.characterFinished) {
        availablePlayers.add(element);
      }
    });
    showAlertDialogGive(context, item);
  }

  void giveLoot(Item item, Color primaryColor) {
    try {
      widget.dsix.gm.giveLoot(item, primaryColor);
    } on TooHeavyException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(widget.alert(e.message));
      Navigator.pop(context);
      return;
    }

    Navigator.pop(context);
  }

  showAlertDialogGive(BuildContext context, Item item) {
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
                              'GIVE ${item.name}',
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
                        width: double.infinity,
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(35, 15, 35, 10),
                          child: Text(
                            (availablePlayers.length < 1)
                                ? 'There are no players.'
                                : 'Select a player:',
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
                      Container(
                        height: 50.0 * availablePlayers.length,
                        child: ListView.builder(
                            itemCount: availablePlayers.length,
                            itemBuilder: (BuildContext context, int index) {
                              return Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(30, 0, 30, 0),
                                child: TextButton(
                                  onPressed: () {
                                    giveLoot(
                                        item,
                                        availablePlayers[index]
                                            .playerColor
                                            .primaryColor);

                                    widget.refresh();

                                    Navigator.pop(context);
                                  },
                                  style: TextButton.styleFrom(
                                    padding:
                                        const EdgeInsets.fromLTRB(0, 0, 0, 5),
                                  ),
                                  child: Container(
                                    height: MediaQuery.of(context).size.height *
                                        0.058,
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        color: availablePlayers[index]
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
                                                Icons.keyboard_arrow_right,
                                                color: availablePlayers[index]
                                                    .playerColor
                                                    .primaryColor,
                                                size: 20,
                                              ),
                                            ),
                                          ],
                                        ),
                                        Center(
                                          child: Text(
                                            '${availablePlayers[index].playerColor.name}',
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
                              );
                            }),
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

  void showItem(Item item) {
    ammoQuantity.clear();

    if (item.itemClass == 'thrownWeapon' || item.itemClass == 'ammo') {
      for (int check = 0; check < item.uses; check++) {
        ammoQuantity.add('ammo');
      }
    }

    showAlertDialogItemDetail(context, item);
  }

  showAlertDialogItemDetail(BuildContext context, Item item) {
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
                    padding: const EdgeInsets.fromLTRB(0, 7, 0, 7),
                    child: Center(
                      child: Text(
                        '${item.name}',
                        style: TextStyle(
                          fontFamily: 'Santana',
                          height: 1,
                          fontSize: 33,
                          color: Colors.white,
                          letterSpacing: 1.2,
                        ),
                      ),
                    ),
                  ),
                ), //ITEM NAME
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                  child: SizedBox(
                    height: MediaQuery.of(context).size.height * 0.4,
                    width: double.infinity,
                    child: Stack(children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(15),
                        child: Container(
                          width: 25,
                          child: GridView.count(
                            crossAxisCount: 1,
                            children:
                                List.generate(ammoQuantity.length, (index) {
                              return Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 0),
                                child: SvgPicture.asset(
                                  'assets/item/${ammoQuantity[index]}.svg',
                                  color: Colors.grey[700],
                                ),
                              );
                            }),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 20, 0, 15),
                        child: SvgPicture.asset(
                          'assets/item/${item.icon}.svg',
                          color: Colors.grey[400],
                        ),
                      ),
                    ]),
                  ),
                ),

                Divider(
                  thickness: 2,
                  color: Colors.grey[700],
                ),

                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.05,
                  width: double.infinity,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(15, 3, 15, 10),
                    child: (item.inventorySpace == 'consumable')
                        ? Container(
                            width: double.infinity,
                            child: Text(
                              item.description,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                height: 1.2,
                                fontSize: 16,
                                fontFamily: 'Calibri',
                                color: Colors.white,
                              ),
                            ),
                          )
                        : Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  SvgPicture.asset(
                                    'assets/item/pDamage.svg',
                                    color: Colors.grey[700],
                                    width: MediaQuery.of(context).size.width *
                                        0.055,
                                  ),
                                  Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(5, 0, 3, 0),
                                    child: Text(
                                      '${item.pDamage}',
                                      style: TextStyle(
                                        fontFamily: 'Santana',
                                        fontWeight: FontWeight.bold,
                                        height: 1,
                                        fontSize: 18,
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
                                    width: MediaQuery.of(context).size.width *
                                        0.065,
                                  ),
                                  Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(5, 0, 3, 0),
                                    child: Text(
                                      '${item.mDamage}',
                                      style: TextStyle(
                                        fontFamily: 'Santana',
                                        fontWeight: FontWeight.bold,
                                        height: 1,
                                        fontSize: 18,
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
                                    width: MediaQuery.of(context).size.width *
                                        0.055,
                                  ),
                                  Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(5, 0, 3, 0),
                                    child: Text(
                                      '${item.pArmor}',
                                      style: TextStyle(
                                        fontFamily: 'Santana',
                                        fontWeight: FontWeight.bold,
                                        height: 1,
                                        fontSize: 18,
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
                                    width: MediaQuery.of(context).size.width *
                                        0.055,
                                  ),
                                  Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(5, 0, 3, 0),
                                    child: Text(
                                      '${item.mArmor}',
                                      style: TextStyle(
                                        fontFamily: 'Santana',
                                        fontWeight: FontWeight.bold,
                                        height: 1,
                                        fontSize: 18,
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
                                    'assets/item/weight.svg',
                                    color: Colors.grey[700],
                                    width: MediaQuery.of(context).size.width *
                                        0.04,
                                  ),
                                  Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(5, 0, 0, 0),
                                    child: Text(
                                      '${item.weight}',
                                      style: TextStyle(
                                        fontFamily: 'Santana',
                                        fontWeight: FontWeight.bold,
                                        height: 1,
                                        fontSize: 18,
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
                  height: 0,
                  thickness: 2,
                  color: Colors.grey[700],
                ),

                // Container(
                //   width: double.infinity,
                //   child: Padding(
                //     padding: const EdgeInsets.fromLTRB(35, 10, 35, 20),
                //     child: Text(
                //       item.description,
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
                  child: GestureDetector(
                    onTap: () {
                      checkPlayers(item);
                    },
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
                                padding: const EdgeInsets.fromLTRB(0, 0, 20, 0),
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
                              'GIVE',
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

  showAlertDialogLoot(BuildContext context) {
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
                width: MediaQuery.of(context).size.width * 0.7,
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
                              'LOOT VALUE',
                              style: TextStyle(
                                fontFamily: 'Santana',
                                height: 1,
                                fontSize: 33,
                                color: Colors.white,
                                letterSpacing: 1.2,
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
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(30, 0, 30, 0),
                                child: Container(
                                  height:
                                      MediaQuery.of(context).size.height * 0.15,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            chooseAmount(-1);
                                          });
                                        },
                                        child: SvgPicture.asset(
                                          'assets/ui/arrowLeft.svg',
                                          color: Colors.white,
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.08,
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                            10, 0, 10, 0),
                                        child: Center(
                                            child: Container(
                                          // height: 125,
                                          child: Container(
                                            // width: 100,
                                            // height: 100,
                                            // color: Colors.white,
                                            child: Center(
                                              child: Row(
                                                children: [
                                                  Text(
                                                    '${lootAmount * 100}',
                                                    style: TextStyle(
                                                      fontFamily: 'Headline',
                                                      height: 1,
                                                      fontSize: 50.0,
                                                      color: Colors.grey[700],
                                                      letterSpacing: 2,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                          // color: Colors.red,
                                        )),
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            chooseAmount(1);
                                          });
                                        },
                                        child: SvgPicture.asset(
                                          'assets/ui/arrowRight.svg',
                                          color: Colors.white,
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.08,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              TextButton(
                                style: TextButton.styleFrom(
                                  padding:
                                      const EdgeInsets.fromLTRB(0, 15, 0, 20),
                                ),
                                onPressed: () {
                                  setState(() {
                                    widget.dsix.gm.createRandomLoot(lootAmount);

                                    widget.refresh();
                                    Navigator.pop(context);
                                  });
                                },
                                child: Container(
                                  height:
                                      MediaQuery.of(context).size.height * 0.08,
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
                                                0, 0, 20, 0),
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
    lootSelection = [];
    widget.dsix.gm.lootList.forEach((element) {
      if (element == widget.dsix.gm.loot) {
        lootSelection.add(true);
      } else {
        lootSelection.add(false);
      }
    });

    if (widget.dsix.gm.lootList.isEmpty) {
      _layoutIndex = 0;
    }

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
                      _layoutIndex = 0;
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
                    itemCount: widget.dsix.gm.lootList.length,
                    itemBuilder: (BuildContext context, int index) {
                      return GestureDetector(
                        onLongPress: () {
                          setState(() {
                            widget.dsix.gm.deleteLoot();
                          });
                        },
                        onTap: () {
                          setState(() {
                            _layoutIndex = 1;
                            widget.dsix.gm.selectLoot(index);
                          });
                        },
                        child: Container(
                          height: 35,
                          width: 35,
                          child: SvgPicture.asset(
                            'assets/item/${widget.dsix.gm.lootList[index].icon}.svg',
                            color: lootSelection[index]
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
        Expanded(
          child: IndexedStack(
            index: _layoutIndex,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(65, 15, 65, 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'SCENE',
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
                        'Scenes and descriptions.',
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
                      onPressed: () {},
                      child: Container(
                        height: MediaQuery.of(context).size.height * 0.08,
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
                                      const EdgeInsets.fromLTRB(0, 0, 15, 0),
                                  child: SvgPicture.asset(
                                    'assets/ui/help.svg',
                                    color: Colors.grey[700],
                                    width: MediaQuery.of(context).size.width *
                                        0.04,
                                  ),
                                ),
                              ],
                            ),
                            Center(
                              child: Text(
                                'SCENE',
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
                        padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                      ),
                      onPressed: () {},
                      child: Container(
                        height: MediaQuery.of(context).size.height * 0.08,
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
                                      const EdgeInsets.fromLTRB(0, 0, 15, 0),
                                  child: SvgPicture.asset(
                                    'assets/ui/help.svg',
                                    color: Colors.grey[700],
                                    width: MediaQuery.of(context).size.width *
                                        0.04,
                                  ),
                                ),
                              ],
                            ),
                            Center(
                              child: Text(
                                'DESCRIPTION',
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
                        padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                      ),
                      onPressed: () {},
                      child: Container(
                        height: MediaQuery.of(context).size.height * 0.08,
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
                                      const EdgeInsets.fromLTRB(0, 0, 15, 0),
                                  child: SvgPicture.asset(
                                    'assets/ui/help.svg',
                                    color: Colors.grey[700],
                                    width: MediaQuery.of(context).size.width *
                                        0.04,
                                  ),
                                ),
                              ],
                            ),
                            Center(
                              child: Text(
                                'OBSTACLE',
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
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(65, 15, 65, 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              // color: Colors.amberAccent,
                              width: MediaQuery.of(context).size.width * 0.6,
                              child: Text(
                                '${widget.dsix.gm.loot.name}',
                                style: TextStyle(
                                  fontFamily: 'Headline',
                                  height: 1.3,
                                  fontSize: 45,
                                  color: Colors.grey[700],
                                  letterSpacing: 2,
                                ),
                              ),
                            ),
                            // Padding(
                            //   padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                            //   child: GestureDetector(
                            //     onTap: () {
                            //       setState(() {
                            //         widget.dsix.gm.deleteLoot();
                            //       });
                            //     },
                            //     child: Icon(
                            //       Icons.clear,
                            //       color: Colors.red,
                            //       size: 30,
                            //     ),
                            //   ),
                            // ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                          child: Text(
                            '${widget.dsix.gm.loot.lootDescription}',
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
                  Divider(
                    height: 0,
                    thickness: 2,
                    color: Colors.grey[700],
                  ),
                  Expanded(
                    child: ListView.builder(
                        shrinkWrap: true,
                        physics: AlwaysScrollableScrollPhysics(),
                        scrollDirection: Axis.vertical,
                        itemCount: widget.dsix.gm.loot.itemList.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Column(
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(20, 0, 20, 0),
                                child: ListTile(
                                  onTap: () {
                                    setState(() {
                                      showItem(
                                          widget.dsix.gm.loot.itemList[index]);
                                    });
                                  },
                                  title: Text(
                                    '${widget.dsix.gm.loot.itemList[index].name}',
                                    style: TextStyle(
                                      fontFamily: 'Headliner',
                                      height: 1.5,
                                      fontSize: 20.0,
                                      color: Colors.grey[300],
                                      letterSpacing: 2.5,
                                    ),
                                  ),
                                  trailing: Text(
                                    '\$ ${widget.dsix.gm.loot.itemList[index].value}',
                                    style: TextStyle(
                                      height: 1.5,
                                      fontSize: 18,
                                      fontFamily: 'Calibri',
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                              Divider(
                                height: 0,
                                thickness: 2,
                                color: Colors.grey[700],
                              ),
                            ],
                          );
                        }),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
