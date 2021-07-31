import 'package:flutter/material.dart';
import 'package:dsixv02app/models/dsix/dsix.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../models/shared/item.dart';
import '../models/shared/exceptions.dart';
import 'package:dsixv02app/models/player/player.dart';

class InventoryPage extends StatefulWidget {
  final Function() refresh;
  final Function(String) alert;
  final Dsix dsix;

  const InventoryPage({Key key, this.dsix, this.refresh, this.alert})
      : super(key: key);

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
  List<String> ammoQuantity = [];
  List<String> enchantQuantity = [];
  String action;

  void checkColor() {
    if (widget.dsix.gm.getCurrentPlayer().mainHandEquip.name == '') {
      mainHandColor =
          widget.dsix.gm.getCurrentPlayer().playerColor.primaryColor;
    } else {
      mainHandColor = Colors.white;
    }

    if (widget.dsix.gm.getCurrentPlayer().offHandEquip.name == '') {
      offHandColor = widget.dsix.gm.getCurrentPlayer().playerColor.primaryColor;
    } else {
      offHandColor = Colors.white;
    }

    if (widget.dsix.gm.getCurrentPlayer().headEquip.name == '') {
      headColor = widget.dsix.gm.getCurrentPlayer().playerColor.primaryColor;
    } else {
      headColor = Colors.white;
    }

    if (widget.dsix.gm.getCurrentPlayer().bodyEquip.name == '') {
      bodyColor = widget.dsix.gm.getCurrentPlayer().playerColor.primaryColor;
    } else {
      bodyColor = Colors.white;
    }

    if (widget.dsix.gm.getCurrentPlayer().handsEquip.name == '') {
      handsColor = widget.dsix.gm.getCurrentPlayer().playerColor.primaryColor;
    } else {
      handsColor = Colors.white;
    }

    if (widget.dsix.gm.getCurrentPlayer().feetEquip.name == '') {
      feetColor = widget.dsix.gm.getCurrentPlayer().playerColor.primaryColor;
    } else {
      feetColor = Colors.white;
    }
  }

  void useOrEquip(Item item) {
    try {
      widget.dsix.gm.getCurrentPlayer().useOrEquip(item);
    } on NoGoldException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(widget.alert(e.message));
      return;
    } on MaxHpException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(widget.alert(e.message));
      return;
    } on HealException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(widget.alert(e.message));
      return;
    } on MaxAmmoException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(widget.alert(e.message));
      return;
    } on EnchantException {
      enchantItem(item);
      return;
    } on RestockException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(widget.alert(e.message));
      return;
    } on UseItemException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(widget.alert(e.message));

      return;
    }

    checkColor();
  }

  void sellItem(Item item) {
    try {
      widget.dsix.gm.getCurrentPlayer().sellItem(item);
    } on SellException catch (e) {
      checkColor();
      ScaffoldMessenger.of(context).showSnackBar(widget.alert(e.message));
      return;
    }
  }

  void checkEquipped(Item item) {
    if (item.name == '') {
      return;
    }

    //SHOW HOW MUCH ENCHANTMENT AN ITEM HAS
    enchantQuantity = [];
    for (int check = 0; check < item.enchant; check++) {
      enchantQuantity.add('magicRune');
    }

    //ADD AMMO TO THE DISPLAY
    ammoQuantity = [];

    if (item.itemClass == 'thrownWeapon' || item.itemClass == 'ammo') {
      for (int check = 0; check < item.uses; check++) {
        ammoQuantity.add('ammo');
      }
    }
    showAlertDialogItemDetail(context, item);
  }

  List<Player> availablePlayers = [];
  void checkPlayers(Item item) {
    availablePlayers = [];
    widget.dsix.gm.players.forEach((element) {
      if (element.characterFinished) {
        availablePlayers.add(element);
      }
    });
    availablePlayers.remove(widget.dsix.gm.getCurrentPlayer());
    if (availablePlayers.isEmpty) {
      ScaffoldMessenger.of(context)
          .showSnackBar(widget.alert('NO OTHER PLAYERS'));
    } else {
      showAlertDialogGive(context, item);
    }
  }

  void giveItem(Item item, Color primaryColor) {
    try {
      widget.dsix.gm.players
          .singleWhere(
              (element) => element.playerColor.primaryColor == primaryColor)
          .receiveItem(item);
    } on TooHeavyException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(widget.alert(e.message));
      return;
    }
    widget.dsix.gm.getCurrentPlayer().giveItem(item);
  }

  List<Item> availableItems = [];
  void enchantItem(Item item) {
    availableItems = [];
    try {
      availableItems =
          widget.dsix.gm.getCurrentPlayer().availableItemsForEnchant();
    } on NoAvailableItemsException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(widget.alert(e.message));

      return;
    }

    showAlertDialogEnchant(context, item);
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
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                  child: SizedBox(
                    height: 200,
                    width: double.infinity,
                    child: Stack(children: <Widget>[
                      // Padding(
                      //   padding: const EdgeInsets.fromLTRB(260, 5, 0, 0),
                      //   child: GestureDetector(
                      //     onTap: () {
                      //       Navigator.of(context).pop(true);
                      //       showAlertDialogDestroyItem(context, item);
                      //     },
                      //     child: Icon(
                      //       Icons.clear,
                      //       color: widget.dsix.gm
                      //           .getCurrentPlayer()
                      //           .playerColor
                      //           .primaryColor,
                      //       size: 30,
                      //     ),
                      //   ),
                      // ),
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
                        padding: const EdgeInsets.all(15),
                        child: Container(
                          width: 27,
                          child: GridView.count(
                            crossAxisCount: 1,
                            children:
                                List.generate(enchantQuantity.length, (index) {
                              return Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 0),
                                child: SvgPicture.asset(
                                  'assets/item/${enchantQuantity[index]}.svg',
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
                        padding: const EdgeInsets.fromLTRB(0, 20, 0, 15),
                        child: SvgPicture.asset(
                          'assets/item/${item.icon}.svg',
                          color: Colors.white,
                        ),
                      ),
                    ]),
                  ),
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

                // Container(
                //   width: double.infinity,
                //   child: Padding(
                //     padding: const EdgeInsets.fromLTRB(35, 10, 35, 10),
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
                  child: TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                      //HERE
                      useOrEquip(
                        item,
                      );
                      widget.refresh();
                    },
                    style: TextButton.styleFrom(
                      padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                    ),
                    child: Container(
                      height: MediaQuery.of(context).size.height * 0.08,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: widget.dsix.gm
                              .getCurrentPlayer()
                              .playerColor
                              .primaryColor,
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
                              item.action,
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

                      checkPlayers(item);
                    },
                    style: TextButton.styleFrom(
                      padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                    ),
                    child: Container(
                      height: MediaQuery.of(context).size.height * 0.08,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: widget.dsix.gm
                              .getCurrentPlayer()
                              .playerColor
                              .primaryColor,
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
                                  Icons.keyboard_arrow_right,
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
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                  child: TextButton(
                    onPressed: () {
                      Navigator.of(context).pop(true);
                      showAlertDialogSellItem(context, item);
                    },
                    style: TextButton.styleFrom(
                      padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                    ),
                    child: Container(
                      height: MediaQuery.of(context).size.height * 0.08,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: widget.dsix.gm
                              .getCurrentPlayer()
                              .playerColor
                              .primaryColor,
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
                              'SELL',
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

  showAlertDialogSellItem(BuildContext context, Item item) {
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
            width: 300,
            // height: 330,
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
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          'SELL FOR \$${item.value ~/ 2}',
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
                //       'The item will be sold for \$${item.value ~/ 2}. Are you sure about that?',
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
                      sellItem(item);

                      widget.refresh();
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
                          color: widget.dsix.gm
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
                                padding: const EdgeInsets.fromLTRB(0, 0, 15, 0),
                                child: Icon(
                                  Icons.check,
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
                          color: widget.dsix.gm
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
                                padding: const EdgeInsets.fromLTRB(0, 0, 15, 0),
                                child: Icon(
                                  Icons.clear,
                                  color: widget.dsix.gm
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
                    color: widget.dsix.gm
                        .getCurrentPlayer()
                        .playerColor
                        .primaryColor,
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
                        color: widget.dsix.gm
                            .getCurrentPlayer()
                            .playerColor
                            .primaryColor,
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(30, 5, 30, 7),
                          child: Center(
                            child: Text(
                              'SELECT A PLAYER',
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
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                        child: Container(
                          height: MediaQuery.of(context).size.height *
                              0.08 *
                              availablePlayers.length,
                          child: ListView.builder(
                              itemCount: availablePlayers.length,
                              itemBuilder: (BuildContext context, int index) {
                                return Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(0, 0, 0, 0),
                                  child: TextButton(
                                    onPressed: () {
                                      giveItem(
                                          item,
                                          availablePlayers[index]
                                              .playerColor
                                              .primaryColor);
                                      widget.refresh();
                                      Navigator.pop(context);
                                    },
                                    style: TextButton.styleFrom(
                                      padding:
                                          const EdgeInsets.fromLTRB(0, 0, 0, 0),
                                    ),
                                    child: Container(
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.08,
                                      width: double.infinity,
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                          color: availablePlayers[index]
                                              .playerColor
                                              .primaryColor,
                                          width:
                                              3, //                   <--- border width here
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
                                                        0, 0, 15, 0),
                                                child: Icon(
                                                  Icons.keyboard_arrow_right,
                                                  color: availablePlayers[index]
                                                      .playerColor
                                                      .primaryColor,
                                                  size: 25,
                                                ),
                                              ),
                                            ],
                                          ),
                                          Center(
                                            child: Text(
                                              '${availablePlayers[index].playerColor.name}',
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
              ),
            );
          },
        );
      },
    );
  }

  showAlertDialogEnchant(BuildContext context, Item item) {
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
                    color: widget.dsix.gm
                        .getCurrentPlayer()
                        .playerColor
                        .primaryColor,
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
                        color: widget.dsix.gm
                            .getCurrentPlayer()
                            .playerColor
                            .primaryColor,
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(30, 5, 30, 7),
                          child: Center(
                            child: Text(
                              'ENCHANT',
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
                            'Select an item to enchant.',
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
                        height: 50.0 * availableItems.length,
                        child: ListView.builder(
                            itemCount: availableItems.length,
                            itemBuilder: (BuildContext context, int index) {
                              return Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(30, 0, 30, 0),
                                child: TextButton(
                                  onPressed: () {
                                    widget.dsix.gm
                                        .getCurrentPlayer()
                                        .enchant(availableItems[index]);
                                    widget.dsix.gm
                                        .getCurrentPlayer()
                                        .destroyItem(item);
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
                                        color: widget.dsix.gm
                                            .getCurrentPlayer()
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
                                                Icons.plus_one,
                                                color: widget.dsix.gm
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
                                            '${availableItems[index].name}',
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

  showAlertDialogDestroyItem(BuildContext context, Item item) {
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
                    padding: const EdgeInsets.fromLTRB(0, 5, 0, 5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          'DESTROY ITEM?',
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
                      widget.dsix.gm.getCurrentPlayer().destroyItem(item);
                      checkColor();
                      widget.refresh();
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
                          color: widget.dsix.gm
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
                                padding: const EdgeInsets.fromLTRB(0, 0, 15, 0),
                                child: Icon(
                                  Icons.check,
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
                          color: widget.dsix.gm
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
                                padding: const EdgeInsets.fromLTRB(0, 0, 15, 0),
                                child: Icon(
                                  Icons.clear,
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
                color:
                    widget.dsix.gm.getCurrentPlayer().playerColor.primaryColor,
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
                  color: widget.dsix.gm
                      .getCurrentPlayer()
                      .playerColor
                      .primaryColor,
                  width: double.infinity,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(30, 10, 30, 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          'WEIGHT: ${widget.dsix.gm.getCurrentPlayer().currentWeight}/${widget.dsix.gm.getCurrentPlayer().race.maxWeight} ',
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

  String alertTitle;
  String alertDescription;

  showAlertDialogAlert(
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
                color:
                    widget.dsix.gm.getCurrentPlayer().playerColor.primaryColor,
                width: 1.5, //                   <--- border width here
              ),
            ),
            width: 300,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Container(
                  color: widget.dsix.gm
                      .getCurrentPlayer()
                      .playerColor
                      .primaryColor,
                  width: double.infinity,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(30, 10, 30, 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          alertTitle,
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
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(35, 15, 25, 20),
                  child: Text(
                    alertDescription,
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

  //SET COLOR ITEMS

  @override
  void initState() {
    super.initState();

    if (widget.dsix.gm.getCurrentPlayer().feetEquip.name == '') {
      feetColor = widget.dsix.gm.getCurrentPlayer().playerColor.primaryColor;
    } else {
      feetColor = Colors.white;
    }
    if (widget.dsix.gm.getCurrentPlayer().handsEquip.name == '') {
      handsColor = widget.dsix.gm.getCurrentPlayer().playerColor.primaryColor;
    } else {
      handsColor = Colors.white;
    }
    if (widget.dsix.gm.getCurrentPlayer().headEquip.name == '') {
      headColor = widget.dsix.gm.getCurrentPlayer().playerColor.primaryColor;
    } else {
      headColor = Colors.white;
    }
    if (widget.dsix.gm.getCurrentPlayer().mainHandEquip.name == '') {
      mainHandColor =
          widget.dsix.gm.getCurrentPlayer().playerColor.primaryColor;
    } else {
      mainHandColor = Colors.white;
    }
    if (widget.dsix.gm.getCurrentPlayer().offHandEquip.name == '') {
      offHandColor = widget.dsix.gm.getCurrentPlayer().playerColor.primaryColor;
    } else {
      offHandColor = Colors.white;
    }
    if (widget.dsix.gm.getCurrentPlayer().bodyEquip.name == '') {
      bodyColor = widget.dsix.gm.getCurrentPlayer().playerColor.primaryColor;
    } else {
      bodyColor = Colors.white;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          height: MediaQuery.of(context).size.height * 0.1,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(17, 2.5, 15, 5),
            child: Row(
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
                      width: MediaQuery.of(context).size.width * 0.070,
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(8, 0, 0, 0),
                      child: Text(
                        '${widget.dsix.gm.getCurrentPlayer().pDamage}',
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
                      'assets/item/mDamage.svg',
                      color: widget.dsix.gm
                          .getCurrentPlayer()
                          .playerColor
                          .primaryColor,
                      width: MediaQuery.of(context).size.width * 0.080,
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(8, 0, 0, 0),
                      child: Text(
                        '${widget.dsix.gm.getCurrentPlayer().mDamage}',
                        style: TextStyle(
                          fontFamily: 'Santana',
                          height: 1,
                          fontSize: 25.0,
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
                      'assets/item/pArmor.svg',
                      color: widget.dsix.gm
                          .getCurrentPlayer()
                          .playerColor
                          .primaryColor,
                      width: MediaQuery.of(context).size.width * 0.070,
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(8, 0, 0, 0),
                      child: Text(
                        '${widget.dsix.gm.getCurrentPlayer().pArmor}',
                        style: TextStyle(
                          fontFamily: 'Santana',
                          height: 1,
                          fontSize: 25.0,
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
                      'assets/item/mArmor.svg',
                      color: widget.dsix.gm
                          .getCurrentPlayer()
                          .playerColor
                          .primaryColor,
                      width: MediaQuery.of(context).size.width * 0.070,
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(8, 0, 0, 0),
                      child: Text(
                        '${widget.dsix.gm.getCurrentPlayer().mArmor}',
                        style: TextStyle(
                          fontFamily: 'Santana',
                          height: 1,
                          fontSize: 25.0,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
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
                          color: widget.dsix.gm
                              .getCurrentPlayer()
                              .playerColor
                              .primaryColor,
                          width: MediaQuery.of(context).size.width * 0.055,
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(7, 1, 0, 5),
                          child: Text(
                            '${widget.dsix.gm.getCurrentPlayer().currentWeight}',
                            textAlign: TextAlign.left,
                            style: TextStyle(
                              fontFamily: 'Santana',
                              height: 1.1,
                              fontSize: 20.0,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 2,
                            ),
                          ),
                        ),
                        Text(
                          '/',
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            fontFamily: 'Santana',
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
                            '${widget.dsix.gm.getCurrentPlayer().race.maxWeight}',
                            textAlign: TextAlign.left,
                            style: TextStyle(
                              fontFamily: 'Santana',
                              height: 1.1,
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold,
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
          color: widget.dsix.gm.getCurrentPlayer().playerColor.primaryColor,
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
                            color: widget.dsix.gm
                                .getCurrentPlayer()
                                .playerColor
                                .primaryColor,
                            width:
                                1.5, //                   <--- border width here
                          ),
                        ),
                        child: GestureDetector(
                          onDoubleTap: () {
                            useOrEquip(
                              widget.dsix.gm.getCurrentPlayer().mainHandEquip,
                            );

                            widget.refresh();
                          },
                          onTap: () {
                            checkEquipped(
                              widget.dsix.gm.getCurrentPlayer().mainHandEquip,
                            );
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(10),
                            child: SvgPicture.asset(
                              'assets/item/${widget.dsix.gm.getCurrentPlayer().mainHandEquip.icon}.svg',
                              color: mainHandColor,
                            ),
                          ),
                        ),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width * 0.265,
                        height: MediaQuery.of(context).size.width * 0.25,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: widget.dsix.gm
                                .getCurrentPlayer()
                                .playerColor
                                .primaryColor,
                            width:
                                1.5, //                   <--- border width here
                          ),
                        ),
                        child: GestureDetector(
                          onDoubleTap: () {
                            useOrEquip(
                              widget.dsix.gm.getCurrentPlayer().handsEquip,
                            );
                            widget.refresh();
                          },
                          onTap: () {
                            checkEquipped(
                              widget.dsix.gm.getCurrentPlayer().handsEquip,
                            );
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(10),
                            child: SvgPicture.asset(
                              'assets/item/${widget.dsix.gm.getCurrentPlayer().handsEquip.icon}.svg',
                              color: handsColor,
                            ),
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
                            color: widget.dsix.gm
                                .getCurrentPlayer()
                                .playerColor
                                .primaryColor,
                            width:
                                1.5, //                   <--- border width here
                          ),
                        ),
                        child: GestureDetector(
                          onDoubleTap: () {
                            useOrEquip(
                              widget.dsix.gm.getCurrentPlayer().headEquip,
                            );
                            widget.refresh();
                          },
                          onTap: () {
                            checkEquipped(
                              widget.dsix.gm.getCurrentPlayer().headEquip,
                            );
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(10),
                            child: SvgPicture.asset(
                              'assets/item/${widget.dsix.gm.getCurrentPlayer().headEquip.icon}.svg',
                              color: headColor,
                            ),
                          ),
                        ),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width * 0.265,
                        height: MediaQuery.of(context).size.height * 0.235,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: widget.dsix.gm
                                .getCurrentPlayer()
                                .playerColor
                                .primaryColor,
                            width:
                                1.5, //                   <--- border width here
                          ),
                        ),
                        child: GestureDetector(
                          onDoubleTap: () {
                            useOrEquip(
                              widget.dsix.gm.getCurrentPlayer().bodyEquip,
                            );
                            widget.refresh();
                          },
                          onTap: () {
                            checkEquipped(
                              widget.dsix.gm.getCurrentPlayer().bodyEquip,
                            );
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(10),
                            child: SvgPicture.asset(
                              'assets/item/${widget.dsix.gm.getCurrentPlayer().bodyEquip.icon}.svg',
                              color: bodyColor,
                            ),
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
                            color: widget.dsix.gm
                                .getCurrentPlayer()
                                .playerColor
                                .primaryColor,
                            width:
                                1.5, //                   <--- border width here
                          ),
                        ),
                        child: GestureDetector(
                          onDoubleTap: () {
                            useOrEquip(
                              widget.dsix.gm.getCurrentPlayer().offHandEquip,
                            );
                            widget.refresh();
                          },
                          onTap: () {
                            checkEquipped(
                              widget.dsix.gm.getCurrentPlayer().offHandEquip,
                            );
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(10),
                            child: SvgPicture.asset(
                              'assets/item/${widget.dsix.gm.getCurrentPlayer().offHandEquip.icon}.svg',
                              color: offHandColor,
                            ),
                          ),
                        ),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width * 0.265,
                        height: MediaQuery.of(context).size.width * 0.25,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: widget.dsix.gm
                                .getCurrentPlayer()
                                .playerColor
                                .primaryColor,
                            width:
                                1.5, //                   <--- border width here
                          ),
                        ),
                        child: GestureDetector(
                          onDoubleTap: () {
                            useOrEquip(
                              widget.dsix.gm.getCurrentPlayer().feetEquip,
                            );
                            widget.refresh();
                          },
                          onTap: () {
                            checkEquipped(
                              widget.dsix.gm.getCurrentPlayer().feetEquip,
                            );
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(10),
                            child: SvgPicture.asset(
                              'assets/item/${widget.dsix.gm.getCurrentPlayer().feetEquip.icon}.svg',
                              color: feetColor,
                            ),
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
          color: widget.dsix.gm.getCurrentPlayer().playerColor.primaryColor,
        ),
        Expanded(
          flex: 4,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(5, 2, 5, 0),
            child: GridView.count(
              crossAxisCount: 6,
              children: List.generate(
                  widget.dsix.gm.getCurrentPlayer().inventory.length, (index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: GestureDetector(
                    onLongPress: () {
                      showAlertDialogDestroyItem(context,
                          widget.dsix.gm.getCurrentPlayer().inventory[index]);
                    },
                    onTap: () {
                      checkEquipped(
                        widget.dsix.gm.getCurrentPlayer().inventory[index],
                      );
                    },
                    onDoubleTap: () {
                      useOrEquip(
                        widget.dsix.gm.getCurrentPlayer().inventory[index],
                      );
                      widget.refresh();
                    },
                    child: SvgPicture.asset(
                      'assets/item/${widget.dsix.gm.getCurrentPlayer().inventory[index].icon}.svg',
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
