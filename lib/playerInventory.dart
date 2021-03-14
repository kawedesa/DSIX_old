import 'package:flutter/material.dart';
import 'package:dsixv02app/models/game/game.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'item.dart';
import 'package:dsixv02app/models/game/game.dart';

class InventoryPage extends StatefulWidget {
  final Function() refresh;
  final Dsix dsix;

  const InventoryPage({Key key, this.dsix, this.refresh}) : super(key: key);

  @override
  _InventoryStatePage createState() => _InventoryStatePage();
}

class _InventoryStatePage extends State<InventoryPage> {
  Color feetColor;
  Color handsColor;
  Color headColor;
  Color mainHandColor;
  Color offHandColor;
  Color bodyColor;
  Widget button;
  List<String> ammoQuantity = [];

  void equip(Item item) {
    widget.dsix.getCurrentPlayer().pDamage += item.pDamage;
    widget.dsix.getCurrentPlayer().pArmor += item.pArmor;
    widget.dsix.getCurrentPlayer().mDamage += item.mDamage;
    widget.dsix.getCurrentPlayer().mArmor += item.mArmor;

    //WEAPONS

    if (item.inventorySpace == '1HAND') {
      if (widget.dsix.getCurrentPlayer().mainHandEquip.icon == 'mainHand') {
        mainHandColor = Colors.white;
        widget.dsix.getCurrentPlayer().mainHandEquip = item;
        widget.dsix.getCurrentPlayer().inventory.remove(item);
      } else if (widget.dsix.getCurrentPlayer().offHandEquip.icon ==
          'offHand') {
        offHandColor = Colors.white;
        widget.dsix.getCurrentPlayer().offHandEquip = item;
        widget.dsix.getCurrentPlayer().inventory.remove(item);
      } else if (widget.dsix.getCurrentPlayer().mainHandEquip.icon !=
          'mainHand') {
        unequip(widget.dsix.getCurrentPlayer().mainHandEquip, 'mainHand');
        mainHandColor = Colors.white;
        widget.dsix.getCurrentPlayer().mainHandEquip = item;
        widget.dsix.getCurrentPlayer().inventory.remove(item);
      }
    } else if (item.inventorySpace == '2HAND') {
      unequip(widget.dsix.getCurrentPlayer().mainHandEquip, 'mainHand');
      unequip(widget.dsix.getCurrentPlayer().offHandEquip, 'offHand');
      mainHandColor = Colors.white;
      offHandColor = Colors.white;
      widget.dsix.getCurrentPlayer().mainHandEquip = item;
      widget.dsix.getCurrentPlayer().offHandEquip = item;
      widget.dsix.getCurrentPlayer().inventory.remove(item);
    }

    //ARMOR

    else if (item.inventorySpace == 'HEAD') {
      unequip(widget.dsix.getCurrentPlayer().headEquip, 'head');
      headColor = Colors.white;
      widget.dsix.getCurrentPlayer().headEquip = item;
      widget.dsix.getCurrentPlayer().inventory.remove(item);
    } else if (item.inventorySpace == 'BODY') {
      unequip(widget.dsix.getCurrentPlayer().bodyEquip, 'body');
      bodyColor = Colors.white;
      widget.dsix.getCurrentPlayer().bodyEquip = item;
      widget.dsix.getCurrentPlayer().inventory.remove(item);
    } else if (item.inventorySpace == 'FEET') {
      unequip(widget.dsix.getCurrentPlayer().feetEquip, 'feet');
      feetColor = Colors.white;
      widget.dsix.getCurrentPlayer().feetEquip = item;
      widget.dsix.getCurrentPlayer().inventory.remove(item);
    } else if (item.inventorySpace == 'HANDS') {
      unequip(widget.dsix.getCurrentPlayer().handsEquip, 'hands');
      handsColor = Colors.white;
      widget.dsix.getCurrentPlayer().handsEquip = item;
      widget.dsix.getCurrentPlayer().inventory.remove(item);
    }
  }

  void unequip(Item item, String inventorySpace) {
    widget.dsix.getCurrentPlayer().pDamage -= item.pDamage;
    widget.dsix.getCurrentPlayer().pArmor -= item.pArmor;
    widget.dsix.getCurrentPlayer().mDamage -= item.mDamage;
    widget.dsix.getCurrentPlayer().mArmor -= item.mArmor;

    //WEAPONS

    if (item.icon == 'mainHand') {
      widget.dsix.getCurrentPlayer().mainHandEquip = Item(
        'mainHand',
        '',
        '',
        '',
        '',
        0,
        0,
        0,
        0,
        0,
        0,
        0,
      );
      mainHandColor = widget.dsix.getCurrentPlayer().playerColor.primaryColor;
    } else if (item.icon == 'offHand') {
      widget.dsix.getCurrentPlayer().offHandEquip = Item(
        'offHand',
        '',
        '',
        '',
        '',
        0,
        0,
        0,
        0,
        0,
        0,
        0,
      );
      offHandColor = widget.dsix.getCurrentPlayer().playerColor.primaryColor;
    } else if (item.inventorySpace == '1HAND') {
      if (inventorySpace == 'mainHand') {
        widget.dsix.getCurrentPlayer().inventory.add(item);
        widget.dsix.getCurrentPlayer().mainHandEquip = Item(
          'mainHand',
          '',
          '',
          '',
          '',
          0,
          0,
          0,
          0,
          0,
          0,
          0,
        );
        mainHandColor = widget.dsix.getCurrentPlayer().playerColor.primaryColor;
      } else if (inventorySpace == 'offHand') {
        widget.dsix.getCurrentPlayer().inventory.add(item);
        widget.dsix.getCurrentPlayer().offHandEquip = Item(
          'offHand',
          '',
          '',
          '',
          '',
          0,
          0,
          0,
          0,
          0,
          0,
          0,
        );
        offHandColor = widget.dsix.getCurrentPlayer().playerColor.primaryColor;
      }
    } else if (item.inventorySpace == '2HAND') {
      widget.dsix.getCurrentPlayer().inventory.add(item);
      widget.dsix.getCurrentPlayer().mainHandEquip = Item(
        'mainHand',
        '',
        '',
        '',
        '',
        0,
        0,
        0,
        0,
        0,
        0,
        0,
      );
      widget.dsix.getCurrentPlayer().offHandEquip = Item(
        'offHand',
        '',
        '',
        '',
        '',
        0,
        0,
        0,
        0,
        0,
        0,
        0,
      );
      mainHandColor = widget.dsix.getCurrentPlayer().playerColor.primaryColor;
      offHandColor = widget.dsix.getCurrentPlayer().playerColor.primaryColor;
    }

    //ARMOR

    else if (item.icon == 'head') {
      widget.dsix.getCurrentPlayer().headEquip = Item(
        'head',
        '',
        '',
        '',
        '',
        0,
        0,
        0,
        0,
        0,
        0,
        0,
      );
      headColor = widget.dsix.getCurrentPlayer().playerColor.primaryColor;
    } else if (item.icon == 'body') {
      widget.dsix.getCurrentPlayer().bodyEquip = Item(
        'body',
        '',
        '',
        '',
        '',
        0,
        0,
        0,
        0,
        0,
        0,
        0,
      );
      bodyColor = widget.dsix.getCurrentPlayer().playerColor.primaryColor;
    } else if (item.icon == 'hands') {
      widget.dsix.getCurrentPlayer().handsEquip = Item(
        'hands',
        '',
        '',
        '',
        '',
        0,
        0,
        0,
        0,
        0,
        0,
        0,
      );
      handsColor = widget.dsix.getCurrentPlayer().playerColor.primaryColor;
    } else if (item.icon == 'feet') {
      widget.dsix.getCurrentPlayer().feetEquip = Item(
        'feet',
        '',
        '',
        '',
        '',
        0,
        0,
        0,
        0,
        0,
        0,
        0,
      );
      feetColor = widget.dsix.getCurrentPlayer().playerColor.primaryColor;
    } else if (item.inventorySpace == 'HEAD') {
      widget.dsix.getCurrentPlayer().inventory.add(item);
      widget.dsix.getCurrentPlayer().headEquip = Item(
        'head',
        '',
        '',
        '',
        '',
        0,
        0,
        0,
        0,
        0,
        0,
        0,
      );
      headColor = widget.dsix.getCurrentPlayer().playerColor.primaryColor;
    } else if (item.inventorySpace == 'BODY') {
      widget.dsix.getCurrentPlayer().inventory.add(item);
      widget.dsix.getCurrentPlayer().bodyEquip = Item(
        'body',
        '',
        '',
        '',
        '',
        0,
        0,
        0,
        0,
        0,
        0,
        0,
      );
      bodyColor = widget.dsix.getCurrentPlayer().playerColor.primaryColor;
    } else if (item.inventorySpace == 'FEET') {
      widget.dsix.getCurrentPlayer().inventory.add(item);
      widget.dsix.getCurrentPlayer().feetEquip = Item(
        'feet',
        '',
        '',
        '',
        '',
        0,
        0,
        0,
        0,
        0,
        0,
        0,
      );
      feetColor = widget.dsix.getCurrentPlayer().playerColor.primaryColor;
    } else if (item.inventorySpace == 'HANDS') {
      widget.dsix.getCurrentPlayer().inventory.add(item);
      widget.dsix.getCurrentPlayer().handsEquip = Item(
        'hands',
        '',
        '',
        '',
        '',
        0,
        0,
        0,
        0,
        0,
        0,
        0,
      );
      handsColor = widget.dsix.getCurrentPlayer().playerColor.primaryColor;
    }
  }

  void sell(Item item, String inventorySpace) {
    widget.dsix.getCurrentPlayer().gold += item.value ~/ 2;
    widget.dsix.getCurrentPlayer().currentWeight -= item.weight;

    if (inventorySpace != 'INVENTORY') {
      unequip(item, inventorySpace);
      widget.dsix.getCurrentPlayer().inventory.remove(item);
    } else {
      widget.dsix.getCurrentPlayer().inventory.remove(item);
    }
    widget.refresh();

    //Pop back to inventory

    Navigator.of(context).pop(true);
  }

  void destroy(Item item, String inventorySpace) {
    widget.dsix.getCurrentPlayer().currentWeight -= item.weight;

    if (inventorySpace != '') {
      unequip(item, inventorySpace);
      widget.dsix.getCurrentPlayer().inventory.remove(item);
    } else {
      widget.dsix.getCurrentPlayer().inventory.remove(item);
    }
    widget.refresh();

    //Pop back to inventory

    Navigator.of(context).pop(true);
  }

  void checkEquipped(Item item, String inventorySpace) {
    if (item.name == '') {
      return;
    }

    //ADD AMMO TO THE DISPLAY
    ammoQuantity = [];

    if (item.itemClass == 'thrownWeapon' || item.itemClass == 'ammo') {
      for (int check = 0; check < item.uses; check++) {
        ammoQuantity.add('ammo');
      }
    }

    //EQUIP and UNEQUIP

    if (inventorySpace != 'INVENTORY') {
      button = Padding(
        padding: const EdgeInsets.fromLTRB(30, 5, 30, 0),
        child: TextButton(
          onPressed: () {
            unequip(item, inventorySpace);
            widget.refresh();
            Navigator.of(context).pop(true);
          },
          style: TextButton.styleFrom(
            padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
          ),
          child: Stack(
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 12, 12, 0),
                    child: SvgPicture.asset(
                      'assets/ui/down.svg',
                      color: widget.dsix
                          .getCurrentPlayer()
                          .playerColor
                          .primaryColor,
                      width: MediaQuery.of(context).size.width * 0.055,
                    ),
                  ),
                ],
              ),
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  border: Border.all(
                    color:
                        widget.dsix.getCurrentPlayer().playerColor.primaryColor,
                    width: 2.5, //                   <--- border width here
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(0, 8, 0, 8),
                  child: Center(
                    child: Text(
                      'UNEQUIP',
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
      );
      showAlertDialogItemDetail(context, item, inventorySpace);
    } else {
      button = Padding(
        padding: const EdgeInsets.fromLTRB(30, 5, 30, 0),
        child: TextButton(
          onPressed: () {
            equip(item);
            widget.refresh();
            Navigator.of(context).pop(true);
          },
          style: TextButton.styleFrom(
            padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
          ),
          child: Stack(
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 12, 12, 0),
                    child: SvgPicture.asset(
                      'assets/ui/up.svg',
                      color: widget.dsix
                          .getCurrentPlayer()
                          .playerColor
                          .primaryColor,
                      width: MediaQuery.of(context).size.width * 0.055,
                    ),
                  ),
                ],
              ),
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  border: Border.all(
                    color:
                        widget.dsix.getCurrentPlayer().playerColor.primaryColor,
                    width: 2.5, //                   <--- border width here
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(0, 8, 0, 8),
                  child: Center(
                    child: Text(
                      'EQUIP',
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
      );
      showAlertDialogItemDetail(context, item, inventorySpace);
    }
  }

  showAlertDialogItemDetail(
      BuildContext context, Item item, String inventorySpace) {
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
            // height: 630,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Container(
                  color:
                      widget.dsix.getCurrentPlayer().playerColor.primaryColor,
                  width: double.infinity,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(0, 5, 0, 5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          '${item.name}',
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
                        padding: const EdgeInsets.fromLTRB(275, 0, 0, 0),
                        child: GestureDetector(
                          onTap: () {
                            showAlertDialogDestroyItem(
                                context, item, inventorySpace);
                          },
                          child: SvgPicture.asset(
                            'assets/ui/cancel.svg',
                            color: widget.dsix
                                .getCurrentPlayer()
                                .playerColor
                                .primaryColor,
                            width: MediaQuery.of(context).size.width * 0.05,
                          ),
                        ),
                      ),
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
                          'assets/item/${item.icon}.svg',
                          color: Colors.white,
                          //width: MediaQuery.of(context).size.width * 0.125,
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
                              color: Colors.white,
                              width: MediaQuery.of(context).size.width * 0.060,
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(5, 0, 3, 0),
                              child: Text(
                                '${item.pDamage}',
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
                                '${item.pArmor}',
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
                                '${item.mDamage}',
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
                                '${item.mArmor}',
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
                                '${item.weight}',
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
                  // height: 165,
                  //color: widget.dsix.getCurrentPlayer().playerColor.secondaryColor,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(35, 10, 35, 10),
                    child: Text(
                      item.description,
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

                button,

                Padding(
                  padding: const EdgeInsets.fromLTRB(30, 0, 30, 15),
                  child: TextButton(
                    onPressed: () {
                      showAlertDialogSellItem(context, item, inventorySpace);
                    },
                    style: TextButton.styleFrom(
                      padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
                    ),
                    child: Stack(
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.fromLTRB(0, 12, 12, 0),
                              child: SvgPicture.asset(
                                'assets/ui/money.svg',
                                color: widget.dsix
                                    .getCurrentPlayer()
                                    .playerColor
                                    .primaryColor,
                                width:
                                    MediaQuery.of(context).size.width * 0.055,
                              ),
                            ),
                          ],
                        ),
                        Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: widget.dsix
                                  .getCurrentPlayer()
                                  .playerColor
                                  .primaryColor,
                              width:
                                  2.5, //                   <--- border width here
                            ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(0, 8, 0, 8),
                            child: Center(
                              child: Text(
                                'SELL',
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

  showAlertDialogSellItem(
      BuildContext context, Item item, String inventorySpace) {
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
            // height: 330,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Container(
                  color:
                      widget.dsix.getCurrentPlayer().playerColor.primaryColor,
                  width: double.infinity,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(0, 5, 0, 5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          '${item.name}',
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

                Container(
                  width: double.infinity,
                  // height: 145,
                  //color: widget.dsix.getCurrentPlayer().playerColor.secondaryColor,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(35, 10, 35, 15),
                    child: Text(
                      'You are going to sell the item for half of it\'s cost! Are you sure?',
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
                  padding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
                  child: TextButton(
                    onPressed: () {
                      sell(item, inventorySpace);
                      Navigator.of(context).pop(true);
                    },
                    style: TextButton.styleFrom(
                      padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
                    ),
                    child: Stack(
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.fromLTRB(0, 12, 12, 0),
                              child: SvgPicture.asset(
                                'assets/ui/check.svg',
                                color: widget.dsix
                                    .getCurrentPlayer()
                                    .playerColor
                                    .primaryColor,
                                width:
                                    MediaQuery.of(context).size.width * 0.055,
                              ),
                            ),
                          ],
                        ),
                        Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: widget.dsix
                                  .getCurrentPlayer()
                                  .playerColor
                                  .primaryColor,
                              width:
                                  2.5, //                   <--- border width here
                            ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(0, 8, 0, 8),
                            child: Center(
                              child: Text(
                                'CONFIRM',
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
                Padding(
                  padding: const EdgeInsets.fromLTRB(30, 0, 30, 15),
                  child: TextButton(
                    onPressed: () {
                      Navigator.of(context).pop(true);
                    },
                    style: TextButton.styleFrom(
                      padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
                    ),
                    child: Stack(
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.fromLTRB(0, 12, 12, 0),
                              child: SvgPicture.asset(
                                'assets/ui/cancel.svg',
                                color: widget.dsix
                                    .getCurrentPlayer()
                                    .playerColor
                                    .primaryColor,
                                width:
                                    MediaQuery.of(context).size.width * 0.055,
                              ),
                            ),
                          ],
                        ),
                        Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: widget.dsix
                                  .getCurrentPlayer()
                                  .playerColor
                                  .primaryColor,
                              width:
                                  2.5, //                   <--- border width here
                            ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(0, 8, 0, 8),
                            child: Center(
                              child: Text(
                                'CANCEL',
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

  showAlertDialogDestroyItem(
      BuildContext context, Item item, String inventorySpace) {
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
            // height: 330,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Container(
                  color:
                      widget.dsix.getCurrentPlayer().playerColor.primaryColor,
                  width: double.infinity,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(0, 5, 0, 5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          '${item.name}',
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

                Container(
                  width: double.infinity,
                  // height: 145,
                  //color: widget.dsix.getCurrentPlayer().playerColor.secondaryColor,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(35, 10, 35, 15),
                    child: Text(
                      'The item will be destroyed and you will get nothing in return! Are you sure?',
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
                  padding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
                  child: TextButton(
                    onPressed: () {
                      destroy(item, inventorySpace);
                      Navigator.of(context).pop(true);
                    },
                    style: TextButton.styleFrom(
                      padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
                    ),
                    child: Stack(
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.fromLTRB(0, 12, 12, 0),
                              child: SvgPicture.asset(
                                'assets/ui/check.svg',
                                color: widget.dsix
                                    .getCurrentPlayer()
                                    .playerColor
                                    .primaryColor,
                                width:
                                    MediaQuery.of(context).size.width * 0.055,
                              ),
                            ),
                          ],
                        ),
                        Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: widget.dsix
                                  .getCurrentPlayer()
                                  .playerColor
                                  .primaryColor,
                              width:
                                  2.5, //                   <--- border width here
                            ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(0, 8, 0, 8),
                            child: Center(
                              child: Text(
                                'CONFIRM',
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
                Padding(
                  padding: const EdgeInsets.fromLTRB(30, 0, 30, 15),
                  child: TextButton(
                    onPressed: () {
                      Navigator.of(context).pop(true);
                    },
                    style: TextButton.styleFrom(
                      padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
                    ),
                    child: Stack(
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.fromLTRB(0, 12, 12, 0),
                              child: SvgPicture.asset(
                                'assets/ui/cancel.svg',
                                color: widget.dsix
                                    .getCurrentPlayer()
                                    .playerColor
                                    .primaryColor,
                                width:
                                    MediaQuery.of(context).size.width * 0.055,
                              ),
                            ),
                          ],
                        ),
                        Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: widget.dsix
                                  .getCurrentPlayer()
                                  .playerColor
                                  .primaryColor,
                              width:
                                  2.5, //                   <--- border width here
                            ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(0, 8, 0, 8),
                            child: Center(
                              child: Text(
                                'CANCEL',
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

  showAlertDialogWeight(BuildContext context) {
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
                width: 1.5, //                   <--- border width here
              ),
            ),
            width: 300,
            // height: 200,
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
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          'WEIGHT: ${widget.dsix.getCurrentPlayer().currentWeight}/${widget.dsix.getCurrentPlayer().maxWeight} ',
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
                    'This represents the maximum weight you can carry.',
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

  //SET COLOR ITEMS

  @override
  void initState() {
    super.initState();

    if (widget.dsix.getCurrentPlayer().feetEquip.name == '') {
      feetColor = widget.dsix.getCurrentPlayer().playerColor.primaryColor;
    } else {
      feetColor = Colors.white;
    }
    if (widget.dsix.getCurrentPlayer().handsEquip.name == '') {
      handsColor = widget.dsix.getCurrentPlayer().playerColor.primaryColor;
    } else {
      handsColor = Colors.white;
    }
    if (widget.dsix.getCurrentPlayer().headEquip.name == '') {
      headColor = widget.dsix.getCurrentPlayer().playerColor.primaryColor;
    } else {
      headColor = Colors.white;
    }
    if (widget.dsix.getCurrentPlayer().mainHandEquip.name == '') {
      mainHandColor = widget.dsix.getCurrentPlayer().playerColor.primaryColor;
    } else {
      mainHandColor = Colors.white;
    }
    if (widget.dsix.getCurrentPlayer().offHandEquip.name == '') {
      offHandColor = widget.dsix.getCurrentPlayer().playerColor.primaryColor;
    } else {
      offHandColor = Colors.white;
    }
    if (widget.dsix.getCurrentPlayer().bodyEquip.name == '') {
      bodyColor = widget.dsix.getCurrentPlayer().playerColor.primaryColor;
    } else {
      bodyColor = Colors.white;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Expanded(
          flex: 2,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(17, 5, 15, 5),
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
                      width: MediaQuery.of(context).size.width * 0.080,
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(8, 0, 0, 0),
                      child: Text(
                        '${widget.dsix.getCurrentPlayer().pDamage}',
                        style: TextStyle(
                          fontFamily: 'Headline',
                          height: 1,
                          fontSize: 23,
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
                      width: MediaQuery.of(context).size.width * 0.080,
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(8, 0, 0, 0),
                      child: Text(
                        '${widget.dsix.getCurrentPlayer().pArmor}',
                        style: TextStyle(
                          fontFamily: 'Headline',
                          height: 1,
                          fontSize: 23.0,
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
                      width: MediaQuery.of(context).size.width * 0.090,
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(8, 0, 0, 0),
                      child: Text(
                        '${widget.dsix.getCurrentPlayer().mDamage}',
                        style: TextStyle(
                          fontFamily: 'Headline',
                          height: 1,
                          fontSize: 23.0,
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
                      width: MediaQuery.of(context).size.width * 0.080,
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(8, 0, 0, 0),
                      child: Text(
                        '${widget.dsix.getCurrentPlayer().mArmor}',
                        style: TextStyle(
                          fontFamily: 'Headline',
                          height: 1,
                          fontSize: 23.0,
                          color: Colors.white,
                          letterSpacing: 3,
                        ),
                      ),
                    ),
                  ],
                ),
                GestureDetector(
                  onTap: () {
                    showAlertDialogWeight(context);
                  },
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        SvgPicture.asset(
                          'assets/item/weight.svg',
                          color: Colors.white,
                          width: MediaQuery.of(context).size.width * 0.055,
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(7, 1, 0, 5),
                          child: Text(
                            '${widget.dsix.getCurrentPlayer().currentWeight}',
                            textAlign: TextAlign.left,
                            style: TextStyle(
                              fontFamily: 'Headline',
                              height: 1.1,
                              fontSize: 20.0,
                              color: Colors.white,
                              letterSpacing: 2,
                            ),
                          ),
                        ),
                        Text(
                          '/',
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            fontFamily: 'Headline',
                            height: 1.1,
                            fontSize: 23.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            letterSpacing: 2,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(1, 6, 5, 0),
                          child: Text(
                            '${widget.dsix.getCurrentPlayer().maxWeight}',
                            textAlign: TextAlign.left,
                            style: TextStyle(
                              fontFamily: 'Headline',
                              height: 1.1,
                              fontSize: 20.0,
                              color: Colors.white,
                              letterSpacing: 2,
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
        Divider(
          height: 0,
          thickness: 2,
          color: widget.dsix.getCurrentPlayer().playerColor.primaryColor,
        ),
        Expanded(
          flex: 9,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(25, 20, 25, 25),
            child: Stack(children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Container(
                        width: MediaQuery.of(context).size.width * 0.265,
                        height: MediaQuery.of(context).size.height * 0.235,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: widget.dsix
                                .getCurrentPlayer()
                                .playerColor
                                .primaryColor,
                            width:
                                1.5, //                   <--- border width here
                          ),
                        ),
                        child: TextButton(
                          style: TextButton.styleFrom(
                            padding: const EdgeInsets.all(10),
                          ),
                          onPressed: () {
                            checkEquipped(
                                widget.dsix.getCurrentPlayer().mainHandEquip,
                                'mainHand');
                          },
                          child: SvgPicture.asset(
                            'assets/item/${widget.dsix.getCurrentPlayer().mainHandEquip.icon}.svg',
                            color: mainHandColor,
                          ),
                        ),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width * 0.265,
                        height: MediaQuery.of(context).size.width * 0.25,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: widget.dsix
                                .getCurrentPlayer()
                                .playerColor
                                .primaryColor,
                            width:
                                1.5, //                   <--- border width here
                          ),
                        ),
                        child: TextButton(
                          style: TextButton.styleFrom(
                            padding: const EdgeInsets.all(10),
                          ),
                          onPressed: () {
                            checkEquipped(
                                widget.dsix.getCurrentPlayer().handsEquip,
                                'HANDS');
                          },
                          child: SvgPicture.asset(
                            'assets/item/${widget.dsix.getCurrentPlayer().handsEquip.icon}.svg',
                            color: handsColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Container(
                        width: MediaQuery.of(context).size.width * 0.265,
                        height: MediaQuery.of(context).size.width * 0.25,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: widget.dsix
                                .getCurrentPlayer()
                                .playerColor
                                .primaryColor,
                            width:
                                1.5, //                   <--- border width here
                          ),
                        ),
                        child: TextButton(
                          style: TextButton.styleFrom(
                            padding: const EdgeInsets.all(10),
                          ),
                          onPressed: () {
                            checkEquipped(
                                widget.dsix.getCurrentPlayer().headEquip,
                                'HEAD');
                          },
                          child: SvgPicture.asset(
                            'assets/item/${widget.dsix.getCurrentPlayer().headEquip.icon}.svg',
                            color: headColor,
                          ),
                        ),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width * 0.265,
                        height: MediaQuery.of(context).size.height * 0.235,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: widget.dsix
                                .getCurrentPlayer()
                                .playerColor
                                .primaryColor,
                            width:
                                1.5, //                   <--- border width here
                          ),
                        ),
                        child: TextButton(
                          style: TextButton.styleFrom(
                            padding: const EdgeInsets.all(3),
                          ),
                          onPressed: () {
                            checkEquipped(
                                widget.dsix.getCurrentPlayer().bodyEquip,
                                'BODY');
                          },
                          child: SvgPicture.asset(
                            'assets/item/${widget.dsix.getCurrentPlayer().bodyEquip.icon}.svg',
                            color: bodyColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Container(
                        width: MediaQuery.of(context).size.width * 0.265,
                        height: MediaQuery.of(context).size.height * 0.235,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: widget.dsix
                                .getCurrentPlayer()
                                .playerColor
                                .primaryColor,
                            width:
                                1.5, //                   <--- border width here
                          ),
                        ),
                        child: TextButton(
                          onPressed: () {
                            checkEquipped(
                                widget.dsix.getCurrentPlayer().offHandEquip,
                                'offHand');
                          },
                          style: TextButton.styleFrom(
                            padding: const EdgeInsets.all(10),
                          ),
                          child: SvgPicture.asset(
                            'assets/item/${widget.dsix.getCurrentPlayer().offHandEquip.icon}.svg',
                            color: offHandColor,
                          ),
                        ),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width * 0.265,
                        height: MediaQuery.of(context).size.width * 0.25,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: widget.dsix
                                .getCurrentPlayer()
                                .playerColor
                                .primaryColor,
                            width:
                                1.5, //                   <--- border width here
                          ),
                        ),
                        child: TextButton(
                          style: TextButton.styleFrom(
                            padding: const EdgeInsets.all(10),
                          ),
                          onPressed: () {
                            checkEquipped(
                                widget.dsix.getCurrentPlayer().feetEquip,
                                'FEET');
                          },
                          child: SvgPicture.asset(
                            'assets/item/${widget.dsix.getCurrentPlayer().feetEquip.icon}.svg',
                            color: feetColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ]),
          ),
        ),
        Divider(
          height: 0,
          thickness: 2,
          color: widget.dsix.getCurrentPlayer().playerColor.primaryColor,
        ),
        Expanded(
          flex: 4,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(5, 2, 5, 0),
            child: GridView.count(
              crossAxisCount: 6,
              children: List.generate(
                  widget.dsix.getCurrentPlayer().inventory.length, (index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: TextButton(
                    onPressed: () {
                      checkEquipped(
                          widget.dsix.getCurrentPlayer().inventory[index],
                          'INVENTORY');
                    },
                    style: TextButton.styleFrom(
                      padding: const EdgeInsets.all(0),
                    ),
                    child: SvgPicture.asset(
                      'assets/item/${widget.dsix.getCurrentPlayer().inventory[index].icon}.svg',
                      color: Colors.white,
                      width: MediaQuery.of(context).size.width * 0.125,
                    ),
                  ),
                );
              }),
            ),
          ),
        ),
      ],
    );
  }
}
