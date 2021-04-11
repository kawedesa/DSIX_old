import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:dsixv02app/models/game/dsix.dart';
import '../game/item.dart';
import '../game/shop.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../game/dsix.dart';
import '../player/exceptions.dart';

class ShopPage extends StatefulWidget {
  final Function() refresh;
  final Dsix dsix;

  const ShopPage({Key key, this.dsix, this.refresh}) : super(key: key);

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
  var textPadding = CrossAxisAlignment.start;
  double fontTextAdjust = 18;

  String exceptionTitle;
  String exceptionDescription;

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

//SHOW MENU

    displayItems = shop.menuSelection(shopMenu[index]);

    title = shopMenuTitle[index];

    textPadding = CrossAxisAlignment.center;
    shopDescription = '';
    fontTextAdjust = 0;
  }

  void showItem(int index) {
    ammoQuantity.clear();

    if (displayItems[index].itemClass == 'thrownWeapon' ||
        displayItems[index].itemClass == 'ammo') {
      for (int check = 0; check < displayItems[index].uses; check++) {
        ammoQuantity.add('ammo');
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
                color: widget.dsix.getCurrentPlayer().playerColor.primaryColor,
                width: 2.5, //                   <--- border width here
              ),
            ),
            width: 300,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Container(
                  color:
                      widget.dsix.getCurrentPlayer().playerColor.primaryColor,
                  width: double.infinity,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(0, 5, 0, 7),
                    child: Center(
                      child: Text(
                        '${displayItems[index].name}',
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
                                  color: widget.dsix
                                      .getCurrentPlayer()
                                      .playerColor
                                      .primaryColor,
                                ),
                              );
                            }),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 20, 0, 15),
                        child: SvgPicture.asset(
                          'assets/item/${displayItems[index].icon}.svg',
                          color: Colors.white,
                        ),
                      ),
                    ]),
                  ),
                ),

                Divider(
                  thickness: 2,
                  color:
                      widget.dsix.getCurrentPlayer().playerColor.primaryColor,
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
                              color: widget.dsix
                                  .getCurrentPlayer()
                                  .playerColor
                                  .primaryColor,
                              width: MediaQuery.of(context).size.width * 0.055,
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
                              color: widget.dsix
                                  .getCurrentPlayer()
                                  .playerColor
                                  .primaryColor,
                              width: MediaQuery.of(context).size.width * 0.055,
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
                              color: widget.dsix
                                  .getCurrentPlayer()
                                  .playerColor
                                  .primaryColor,
                              width: MediaQuery.of(context).size.width * 0.065,
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
                              color: widget.dsix
                                  .getCurrentPlayer()
                                  .playerColor
                                  .primaryColor,
                              width: MediaQuery.of(context).size.width * 0.055,
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
                              color: widget.dsix
                                  .getCurrentPlayer()
                                  .playerColor
                                  .primaryColor,
                              width: MediaQuery.of(context).size.width * 0.045,
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
                  color:
                      widget.dsix.getCurrentPlayer().playerColor.primaryColor,
                ),

                Container(
                  width: double.infinity,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(35, 10, 35, 10),
                    child: Text(
                      displayItems[index].description,
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
                      Navigator.of(context).pop(true);
                      buy(index);
                    },
                    style: TextButton.styleFrom(
                      padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                    ),
                    child: Container(
                      height: MediaQuery.of(context).size.height * 0.058,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: widget.dsix
                              .getCurrentPlayer()
                              .playerColor
                              .primaryColor,
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
                                  Icons.attach_money,
                                  color: widget.dsix
                                      .getCurrentPlayer()
                                      .playerColor
                                      .primaryColor,
                                  size: 20,
                                ),
                              ),
                            ],
                          ),
                          Center(
                            child: Text(
                              '${displayItems[index].value}',
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
      context: context,
      builder: (BuildContext context) {
        return alerta;
      },
    );
  }

  void buy(int index) {
    try {
      widget.dsix.getCurrentPlayer().buyItem(displayItems[index]);
    } on NoGoldException catch (e) {
      exceptionTitle = e.title;
      exceptionDescription = e.message;

      showAlertDialogExceptions(context);
    } on TooHeavyException catch (e) {
      exceptionTitle = e.title;
      exceptionDescription = e.message;

      showAlertDialogExceptions(context);
    }

    widget.refresh();
  }

  showAlertDialogExceptions(
    BuildContext context,
  ) {
    AlertDialog alerta = AlertDialog(
      backgroundColor: Colors.black,
      contentPadding: EdgeInsets.fromLTRB(0, 0, 0, 0),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            decoration: BoxDecoration(
              border: Border.all(
                color: widget.dsix.getCurrentPlayer().playerColor.primaryColor,
                width: 2.5, //                   <--- border width here
              ),
            ),
            width: 300,
            // height: 275,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Container(
                  color:
                      widget.dsix.getCurrentPlayer().playerColor.primaryColor,
                  width: double.infinity,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(30, 10, 30, 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          exceptionTitle,
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
                  padding: const EdgeInsets.fromLTRB(35, 15, 25, 20),
                  child: Text(
                    exceptionDescription,
                    style: TextStyle(
                      height: 1.25,
                      fontSize: 19,
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
        Container(
          height: MediaQuery.of(context).size.height * 0.1,
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
                          color: widget.dsix
                              .getCurrentPlayer()
                              .playerColor
                              .primaryColor,
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
          color: widget.dsix.getCurrentPlayer().playerColor.primaryColor,
        ),
        Expanded(
          flex: 13,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Column(
                  crossAxisAlignment: textPadding,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.fromLTRB(40, 15, 40, 0),
                      child: Text(
                        title,
                        style: TextStyle(
                          fontFamily: 'Headline',
                          height: 1.3,
                          fontSize: 45,
                          color: widget.dsix
                              .getCurrentPlayer()
                              .playerColor
                              .primaryColor,
                          letterSpacing: 2,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(40, 10, 40, 0),
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
                      child: GridView.count(
                        crossAxisCount: 4,
                        mainAxisSpacing: 20,
                        children: List.generate(displayItems.length, (index) {
                          return TextButton(
                            onPressed: () {
                              showItem(index);
                            },
                            style: TextButton.styleFrom(
                              padding: const EdgeInsets.fromLTRB(5, 0, 5, 0),
                            ),
                            child: Container(
                              width: double.infinity,
                              height: 80,
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
                                      color: widget.dsix
                                          .getCurrentPlayer()
                                          .playerColor
                                          .primaryColor,
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
