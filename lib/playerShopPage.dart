import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'player.dart';
import 'item.dart';
import 'shop.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ShopPage extends StatefulWidget {
  final Function() refresh;
  final Player player;

  const ShopPage({Key key, this.player, this.refresh}) : super(key: key);

  @override
  _ShopPageState createState() => _ShopPageState();
}

class _ShopPageState extends State<ShopPage> {
  final Shop shop = Shop();

  List<String> shopMenu = [
    'lightWeapon',
    'heavyWeapon',
    'rangedWeapon',
    'magicWeapon',
    'armor',
    'resources'
  ];

  List<String> shopMenuTitle = [
    'LIGHT WEAPON',
    'HEAVY WEAPON',
    'RANGED WEAPON',
    'MAGIC WEAPON',
    'ARMOR',
    'RESOURCES'
  ];

  String title = 'SHOP';
  String shopDescription =
      'Don\'t forget to buy stuff! The world is a dangerous place. Select the category above and click on the item to see it.';
  var textPadding = const EdgeInsets.fromLTRB(40, 15, 40, 0);
  double fontTextAdjust = 22;

  List<String> selectedMenu = [
    'null',
    'null',
    'null',
    'null',
    'null',
    'null',
  ];

  var displayItems = List<Item>.empty(growable: true);

  List<String> ammoQuantity = [];

  void menuSelection(index) {
    selectedMenu = [
      'null',
      'null',
      'null',
      'null',
      'null',
      'null',
    ];
    selectedMenu.replaceRange(index, index + 1, [shopMenu[index]]);

    if (selectedMenu[index] == 'lightWeapon') {
      displayItems = shop.lightWeapons;
    } else if (selectedMenu[index] == 'heavyWeapon') {
      displayItems = shop.heavyWeapons;
    } else if (selectedMenu[index] == 'rangedWeapon') {
      displayItems = shop.rangedWeapons;
    } else if (selectedMenu[index] == 'magicWeapon') {
      displayItems = shop.magicWeapons;
    } else if (selectedMenu[index] == 'armor') {
      displayItems = shop.armor;
    } else if (selectedMenu[index] == 'resources') {
      displayItems = shop.resources;
    }

    title = shopMenuTitle[index];

    textPadding = const EdgeInsets.fromLTRB(20, 15, 0, 0);
    shopDescription = '';
    fontTextAdjust = 0;
  }

  void showAmmo(int index) {
    ammoQuantity.clear();

    if (displayItems[index].itemClass == 'thrownWeapon' ||
        displayItems[index].itemClass == 'ammo') {
      int check = 0;
      while (check < displayItems[index].uses) {
        ammoQuantity.add('ammo');
        check++;
      }
    }

    showAlertDialogItemDetail(context, index);
  }

  showAlertDialogItemDetail(BuildContext context, int index) {
    AlertDialog alerta = AlertDialog(
      backgroundColor: Colors.black,
      contentPadding: EdgeInsets.fromLTRB(0, 0, 0, 0),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            decoration: BoxDecoration(
              border: Border.all(
                color: widget.player.playerColor,
                width: 2.5, //                   <--- border width here
              ),
            ),
            width: 300,
            // height: 555,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Container(
                  color: widget.player.playerColor,
                  width: double.infinity,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(0, 5, 0, 5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          '${displayItems[index].name}',
                          style: TextStyle(
                            fontFamily: 'Headline',
                            height: 1.3,
                            fontSize: 30.0,
                            color: Colors.white,
                            letterSpacing: 2,
                          ),
                        ),
                      ],
                    ),
                  ),
                ), //ITEM NAME
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                  child: SizedBox(
                    height: 200,
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
                                  color: Colors.white,
                                  // width: MediaQuery.of(context).size.width * 0.001,
                                ),
                              );
                            }),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(30, 30, 30, 30),
                        child: SvgPicture.asset(
                          'assets/item/${displayItems[index].icon}.svg',
                          color: Colors.white,
                          //width: MediaQuery.of(context).size.width * 0.125,
                        ),
                      ),
                    ]),
                  ),
                ),

                Divider(
                  thickness: 2,
                  color: widget.player.playerColor,
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
                              'assets/item/pDamage.svg',
                              color: Colors.white,
                              width: MediaQuery.of(context).size.width * 0.060,
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(5, 0, 3, 0),
                              child: Text(
                                '${displayItems[index].pDamage}',
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
                              color: Colors.white,
                              width: MediaQuery.of(context).size.width * 0.060,
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(5, 0, 3, 0),
                              child: Text(
                                '${displayItems[index].pArmor}',
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
                              color: Colors.white,
                              width: MediaQuery.of(context).size.width * 0.070,
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(5, 0, 3, 0),
                              child: Text(
                                '${displayItems[index].mDamage}',
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
                              color: Colors.white,
                              width: MediaQuery.of(context).size.width * 0.060,
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(5, 0, 3, 0),
                              child: Text(
                                '${displayItems[index].mArmor}',
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
                              'assets/item/weight.svg',
                              color: Colors.white,
                              width: MediaQuery.of(context).size.width * 0.050,
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(5, 0, 0, 0),
                              child: Text(
                                '${displayItems[index].weight}',
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
                  color: widget.player.playerColor,
                ),

                Container(
                  width: double.infinity,
                  // height: 165,
                  //color: widget.player.playerSecondaryColor,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(35, 10, 35, 10),
                    child: Text(
                      displayItems[index].description,
                      textAlign: TextAlign.justify,
                      style: TextStyle(
                        height: 1.25,
                        fontSize: 23,
                        fontFamily: 'Calibri',
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.fromLTRB(30, 5, 30, 15),
                  child: TextButton(
                    onPressed: () {
                      buy(index);
                    },
                    style: TextButton.styleFrom(
                      padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
                    ),
                    child: Stack(
                      children: <Widget>[
                        Container(
                          width: double.infinity,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: <Widget>[
                              Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(0, 12, 12, 0),
                                child: SvgPicture.asset(
                                  'assets/ui/money.svg',
                                  color: widget.player.playerColor,
                                  width:
                                      MediaQuery.of(context).size.width * 0.055,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: widget.player.playerColor,
                              width:
                                  2.5, //                   <--- border width here
                            ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(0, 8, 0, 8),
                            child: Center(
                              child: Text(
                                '${displayItems[index].value}',
                                style: TextStyle(
                                  height: 1.5,
                                  fontSize: 17,
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 1.5,
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

  void buy(int index) {
    if (widget.player.gold < displayItems[index].value) {
      showAlertDialogNoMoney(context, index);
      return;
    }

    if (widget.player.maxWeight - widget.player.currentWeight <
        displayItems[index].weight) {
      showAlertDialogTooHeavy(context, index);
      return;
    }

    widget.player.gold -= displayItems[index].value;
    widget.player.currentWeight += displayItems[index].weight;

    widget.player.inventory.add(displayItems[index].copyItem());

    Navigator.of(context).pop(true);
    widget.refresh();
  }

  showAlertDialogTooHeavy(BuildContext context, int index) {
    AlertDialog alerta = AlertDialog(
      backgroundColor: Colors.black,
      contentPadding: EdgeInsets.fromLTRB(0, 0, 0, 0),
      content: Container(
        decoration: BoxDecoration(
          border: Border.all(
            color: widget.player.playerColor,
            width: 2.5, //                   <--- border width here
          ),
        ),
        width: 300,
        height: 275,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Container(
              color: widget.player.playerColor,
              width: double.infinity,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(30, 10, 30, 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'TOO HEAVY!',
                      style: TextStyle(
                        fontFamily: 'Headline',
                        height: 1.3,
                        fontSize: 30.0,
                        color: Colors.white,
                        letterSpacing: 3,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(35, 25, 25, 15),
              child: Text(
                'You are already carrying too much weight and can\'t carry this item. You can carry ${widget.player.maxWeight - widget.player.currentWeight} more weight, and this item has ${displayItems[index].weight} weight.',
                style: TextStyle(
                  height: 1.25,
                  fontSize: 22,
                  fontFamily: 'Calibri',
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alerta;
      },
    );
  }

  showAlertDialogNoMoney(BuildContext context, int index) {
    AlertDialog alerta = AlertDialog(
      backgroundColor: Colors.black,
      contentPadding: EdgeInsets.fromLTRB(0, 0, 0, 0),
      content: Container(
        decoration: BoxDecoration(
          border: Border.all(
            color: widget.player.playerColor,
            width: 2.5, //                   <--- border width here
          ),
        ),
        width: 300,
        height: 225,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Container(
              color: widget.player.playerColor,
              width: double.infinity,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(30, 10, 30, 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'NOT ENOUGH GOLD!',
                      style: TextStyle(
                        fontFamily: 'Headline',
                        height: 1.3,
                        fontSize: 30.0,
                        color: Colors.white,
                        letterSpacing: 3,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(35, 25, 25, 15),
              child: Text(
                'You don\'t have enough gold to buy this item. It costs \$${displayItems[index].value}, and you only have \$${widget.player.gold}.',
                style: TextStyle(
                  height: 1.25,
                  fontSize: 22,
                  fontFamily: 'Calibri',
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Expanded(
          flex: 2,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(0, 2.5, 10, 0),
            child: Stack(
              children: <Widget>[
                GridView.count(
                  crossAxisCount: 6,
                  children: List.generate(6, (index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 13),
                      child: SvgPicture.asset(
                        'assets/item/${shopMenu[index]}.svg',
                        color: Colors.white,
                        width: MediaQuery.of(context).size.width * 0.055,
                      ),
                    );
                  }),
                ),
                GridView.count(
                  crossAxisCount: 6,
                  children: List.generate(6, (index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 13),
                      child: TextButton(
                        onPressed: () {
                          setState(() {
                            menuSelection(index);
                          });
                        },
                        style: TextButton.styleFrom(
                          padding: EdgeInsets.all(0),
                        ),
                        child: SvgPicture.asset(
                          'assets/item/${selectedMenu[index]}.svg',
                          color: widget.player.playerColor,
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
          color: widget.player.playerColor,
        ),
        Expanded(
          flex: 13,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: textPadding,
                      child: Text(
                        title,
                        style: TextStyle(
                          fontFamily: 'Headline',
                          height: 1.3,
                          fontSize: 50,
                          color: widget.player.playerColor,
                          letterSpacing: 2,
                        ),
                      ),
                    ),
                    Padding(
                      padding: textPadding,
                      child: Text(
                        shopDescription,
                        textAlign: TextAlign.justify,
                        style: TextStyle(
                          height: 1.3,
                          fontSize: fontTextAdjust,
                          fontFamily: 'Calibri',
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(0, 10, 7, 0),
                    child: Container(
                      //color: widget.player.playerSecondaryColor,
                      child: GridView.count(
                        crossAxisCount: 4,
                        mainAxisSpacing: 20,
                        children: List.generate(displayItems.length, (index) {
                          return TextButton(
                            onPressed: () {
                              showAmmo(index);
                            },
                            style: TextButton.styleFrom(
                              padding: const EdgeInsets.fromLTRB(5, 0, 5, 0),
                            ),
                            child: Container(
                              width: double.infinity,
                              height: 80,
                              //color: widget.player.playerSecondaryColor,

                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  SvgPicture.asset(
                                    'assets/item/${displayItems[index].icon}.svg',
                                    color: Colors.white,
                                    width: MediaQuery.of(context).size.width *
                                        0.125,
                                  ),
                                  Text(
                                    '${displayItems[index].value}',
                                    style: TextStyle(
                                      height: 1,
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      letterSpacing: 2,
                                      fontFamily: 'Calibri',
                                      color: widget.player.playerColor,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        }),
                      ),
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
