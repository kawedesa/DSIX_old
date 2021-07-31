import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:dsixv02app/models/dsix/dsix.dart';
import '../models/shared/item.dart';
import '../models/shared/shop.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../models/dsix/dsix.dart';
import '../models/shared/exceptions.dart';

class ShopPage extends StatefulWidget {
  final Function() refresh;
  final Function(String) alert;
  final Dsix dsix;

  const ShopPage({Key key, this.dsix, this.refresh, this.alert})
      : super(key: key);

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

  String title = 'LIGHT WEAPON';
  String shopDescription =
      'Don\'t forget to buy stuff! The world is a dangerous place. Select the category above and click on the item to see it.';
  var textPadding = CrossAxisAlignment.start;

  List<String> selectedMenu = [
    'lightWeapon',
    'null',
    'null',
    'null',
    'null',
    'null',
  ];

  List<Item> displayItems = [];

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
                color:
                    widget.dsix.gm.getCurrentPlayer().playerColor.primaryColor,
                width: 2.5, //                   <--- border width here
              ),
            ),
            width: MediaQuery.of(context).size.width * 0.7,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Container(
                  color: widget.dsix.gm
                      .getCurrentPlayer()
                      .playerColor
                      .primaryColor,
                  width: double.infinity,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(0, 5, 0, 7),
                    child: Center(
                      child: Text(
                        '${item.name}',
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
                  ),
                ), //ITEM NAME
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.4,
                  width: double.infinity,
                  child: Stack(children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(15),
                      child: Container(
                        width: 25,
                        child: GridView.count(
                          crossAxisCount: 1,
                          children: List.generate(ammoQuantity.length, (index) {
                            return Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 0),
                              child: SvgPicture.asset(
                                'assets/item/${ammoQuantity[index]}.svg',
                                color: widget.dsix.gm
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
                      padding: const EdgeInsets.fromLTRB(25, 20, 25, 20),
                      child: SvgPicture.asset(
                        'assets/item/${item.icon}.svg',
                        color: Colors.white,
                      ),
                    ),
                  ]),
                ),

                Divider(
                  thickness: 2,
                  color: widget.dsix.gm
                      .getCurrentPlayer()
                      .playerColor
                      .primaryColor,
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
                                    color: widget.dsix.gm
                                        .getCurrentPlayer()
                                        .playerColor
                                        .primaryColor,
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
                                    color: widget.dsix.gm
                                        .getCurrentPlayer()
                                        .playerColor
                                        .primaryColor,
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
                                    color: widget.dsix.gm
                                        .getCurrentPlayer()
                                        .playerColor
                                        .primaryColor,
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
                                    color: widget.dsix.gm
                                        .getCurrentPlayer()
                                        .playerColor
                                        .primaryColor,
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
                                    color: widget.dsix.gm
                                        .getCurrentPlayer()
                                        .playerColor
                                        .primaryColor,
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
                  thickness: 2,
                  height: 0,
                  color: widget.dsix.gm
                      .getCurrentPlayer()
                      .playerColor
                      .primaryColor,
                ),

                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                  child: Builder(builder: (BuildContext context) {
                    return GestureDetector(
                      onTap: () {
                        buy(item);
                        Navigator.of(context).pop(true);
                      },
                      child: Container(
                        height: MediaQuery.of(context).size.height * 0.08,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: widget.dsix.gm
                                .getCurrentPlayer()
                                .playerColor
                                .primaryColor,
                            width:
                                1, //                   <--- border width here
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
                                    Icons.attach_money,
                                    color: widget.dsix.gm
                                        .getCurrentPlayer()
                                        .playerColor
                                        .primaryColor,
                                    size: 25,
                                  ),
                                ),
                              ],
                            ),
                            Center(
                              child: Text(
                                '${item.value}',
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
                    );
                  }),
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

  void buy(Item item) {
    try {
      widget.dsix.gm.getCurrentPlayer().buyItem(item);
    } on NoGoldException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(widget.alert(e.message));
      return;
    } on TooHeavyException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(widget.alert(e.message));
      return;
    } on BuyException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(widget.alert(e.message));
      widget.refresh();
      return;
    }
  }

  @override
  void initState() {
    displayItems = shop.menuSelection('lightWeapon');
    super.initState();
  }

  Widget build(BuildContext context) {
    return Column(
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
                          color: widget.dsix.gm
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
          color: widget.dsix.gm.getCurrentPlayer().playerColor.primaryColor,
        ),
        Expanded(
          child: Container(
            width: MediaQuery.of(context).size.width * 0.8,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 15, 0, 0),
                  child: Text(
                    title,
                    style: TextStyle(
                      fontFamily: 'Headline',
                      height: 1.3,
                      fontSize: 45,
                      color: widget.dsix.gm
                          .getCurrentPlayer()
                          .playerColor
                          .primaryColor,
                      letterSpacing: 2,
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                    child: Container(
                      child: GridView.count(
                        crossAxisCount: 4,
                        mainAxisSpacing: 20,
                        children: List.generate(displayItems.length, (index) {
                          return TextButton(
                            onPressed: () {
                              showItem(displayItems[index]);
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
                                      color: widget.dsix.gm
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
