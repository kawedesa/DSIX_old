import 'package:flutter/material.dart';
import 'package:dsixv02app/models/game/dsix.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../models/game/item.dart';
import '../models/player/exceptions.dart';

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
  List<String> ammoQuantity = [];
  String buttonText;

  void checkColor() {
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

    if (widget.dsix.getCurrentPlayer().headEquip.name == '') {
      headColor = widget.dsix.getCurrentPlayer().playerColor.primaryColor;
    } else {
      headColor = Colors.white;
    }

    if (widget.dsix.getCurrentPlayer().bodyEquip.name == '') {
      bodyColor = widget.dsix.getCurrentPlayer().playerColor.primaryColor;
    } else {
      bodyColor = Colors.white;
    }

    if (widget.dsix.getCurrentPlayer().handsEquip.name == '') {
      handsColor = widget.dsix.getCurrentPlayer().playerColor.primaryColor;
    } else {
      handsColor = Colors.white;
    }

    if (widget.dsix.getCurrentPlayer().feetEquip.name == '') {
      feetColor = widget.dsix.getCurrentPlayer().playerColor.primaryColor;
    } else {
      feetColor = Colors.white;
    }
  }

  void useOrEquip(Item item, String buttonText) {
    try {
      widget.dsix.getCurrentPlayer().useOrEquip(item, buttonText);
    } on NoGoldException catch (e) {
      alertTitle = e.title;
      alertDescription = e.message;
      showAlertDialogAlert(context);
      return;
    } on MaxHpException catch (e) {
      alertTitle = e.title;
      alertDescription = e.message;
      showAlertDialogAlert(context);
      return;
    } on MaxAmmoException catch (e) {
      alertTitle = e.title;
      alertDescription = e.message;
      showAlertDialogAlert(context);
      return;
    }

    checkColor();

    widget.refresh();
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

    if (inventorySpace != 'inventory') {
      buttonText = 'UNEQUIP';
    } else {
      if (item.inventorySpace == 'consumable') {
        if (item.name == 'AMMO') {
          buttonText = 'REFIL';
        } else {
          buttonText = 'USE';
        }
      } else {
        buttonText = 'EQUIP';
      }
    }

    showAlertDialogItemDetail(context, item, buttonText);
  }

  showAlertDialogItemDetail(
      BuildContext context, Item item, String buttonText) {
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
                        '${item.name}',
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
                        padding: const EdgeInsets.fromLTRB(270, 5, 0, 0),
                        child: GestureDetector(
                          onTap: () {
                            Navigator.of(context).pop(true);
                            showAlertDialogDestroyItem(
                                context, item, buttonText);
                          },
                          child: Icon(
                            Icons.clear,
                            color: widget.dsix
                                .getCurrentPlayer()
                                .playerColor
                                .primaryColor,
                            size: 20,
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
                          'assets/item/${item.icon}.svg',
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
                              color: widget.dsix
                                  .getCurrentPlayer()
                                  .playerColor
                                  .primaryColor,
                              width: MediaQuery.of(context).size.width * 0.055,
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
                              color: widget.dsix
                                  .getCurrentPlayer()
                                  .playerColor
                                  .primaryColor,
                              width: MediaQuery.of(context).size.width * 0.065,
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
                              color: widget.dsix
                                  .getCurrentPlayer()
                                  .playerColor
                                  .primaryColor,
                              width: MediaQuery.of(context).size.width * 0.055,
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
                              color: widget.dsix
                                  .getCurrentPlayer()
                                  .playerColor
                                  .primaryColor,
                              width: MediaQuery.of(context).size.width * 0.045,
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
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(35, 10, 35, 10),
                    child: Text(
                      item.description,
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
                  padding: const EdgeInsets.fromLTRB(30, 5, 30, 0),
                  child: TextButton(
                    onPressed: () {
                      useOrEquip(item, buttonText);
                    },
                    style: TextButton.styleFrom(
                      padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
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
                                padding: const EdgeInsets.fromLTRB(0, 0, 10, 0),
                                child: Icon(
                                  Icons.check,
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
                              buttonText,
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

                Padding(
                  padding: const EdgeInsets.fromLTRB(30, 0, 30, 10),
                  child: TextButton(
                    onPressed: () {
                      Navigator.of(context).pop(true);
                      showAlertDialogSellItem(context, item, buttonText);
                    },
                    style: TextButton.styleFrom(
                      padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
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
                              'SELL',
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

  showAlertDialogSellItem(BuildContext context, Item item, String buttonText) {
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
                    padding: const EdgeInsets.fromLTRB(0, 5, 0, 7),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          '${item.name}',
                          style: TextStyle(
                            fontFamily: 'Headline',
                            height: 1.3,
                            fontSize: 25.0,
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
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(35, 15, 35, 20),
                    child: Text(
                      'The item will be sold for half of it\'s cost!',
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
                  padding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
                  child: TextButton(
                    onPressed: () {
                      widget.dsix.getCurrentPlayer().sellItem(item, buttonText);
                      checkColor();
                      widget.refresh();
                      Navigator.of(context).pop(true);
                    },
                    style: TextButton.styleFrom(
                      padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
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
                                padding: const EdgeInsets.fromLTRB(0, 0, 10, 0),
                                child: Icon(
                                  Icons.check,
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
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(30, 0, 30, 10),
                  child: TextButton(
                    onPressed: () {
                      Navigator.of(context).pop(true);
                    },
                    style: TextButton.styleFrom(
                      padding: const EdgeInsets.fromLTRB(0, 0, 0, 15),
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
                                padding: const EdgeInsets.fromLTRB(0, 0, 10, 0),
                                child: Icon(
                                  Icons.clear,
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
                              'CANCEL',
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

  showAlertDialogDestroyItem(
      BuildContext context, Item item, String buttonText) {
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
                    padding: const EdgeInsets.fromLTRB(0, 5, 0, 5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          '${item.name}',
                          style: TextStyle(
                            fontFamily: 'Headline',
                            height: 1.3,
                            fontSize: 25.0,
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
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(35, 15, 35, 20),
                    child: Text(
                      'The item will be destroyed!',
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
                  padding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
                  child: TextButton(
                    onPressed: () {
                      widget.dsix
                          .getCurrentPlayer()
                          .destroyItem(item, buttonText);
                      checkColor();
                      widget.refresh();
                      Navigator.of(context).pop(true);
                    },
                    style: TextButton.styleFrom(
                      padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
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
                                padding: const EdgeInsets.fromLTRB(0, 0, 10, 0),
                                child: Icon(
                                  Icons.check,
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
                                padding: const EdgeInsets.fromLTRB(0, 0, 10, 0),
                                child: Icon(
                                  Icons.clear,
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
                              'CANCEL',
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
                color: widget.dsix.getCurrentPlayer().playerColor.primaryColor,
                width: 1.5, //                   <--- border width here
              ),
            ),
            width: 300,
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
                      color: widget.dsix
                          .getCurrentPlayer()
                          .playerColor
                          .primaryColor,
                      width: MediaQuery.of(context).size.width * 0.070,
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
                      color: widget.dsix
                          .getCurrentPlayer()
                          .playerColor
                          .primaryColor,
                      width: MediaQuery.of(context).size.width * 0.070,
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
                      color: widget.dsix
                          .getCurrentPlayer()
                          .playerColor
                          .primaryColor,
                      width: MediaQuery.of(context).size.width * 0.080,
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
                      color: widget.dsix
                          .getCurrentPlayer()
                          .playerColor
                          .primaryColor,
                      width: MediaQuery.of(context).size.width * 0.070,
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
                          color: widget.dsix
                              .getCurrentPlayer()
                              .playerColor
                              .primaryColor,
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
                              'mainHand',
                            );
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
                              'hands',
                            );
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
                              'head',
                            );
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
                                'body');
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
                                'feet');
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
                          'inventory');
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
