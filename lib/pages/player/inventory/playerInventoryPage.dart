import 'package:dsixv02app/core/app_images.dart';
import 'package:dsixv02app/core/app_text_styles.dart';
import 'package:dsixv02app/models/player/itemSlot.dart';
import 'package:dsixv02app/widgets/dialogs/itemDialog.dart';
import 'package:flutter/material.dart';
import 'package:dsixv02app/models/dsix/dsix.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'playerInventoryPageVM.dart';

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
  InventoryPageVM _inventoryPageVM = InventoryPageVM();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
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
                      AppImages.pDamage,
                      color: widget.dsix.getCurrentPlayer().primaryColor,
                      width: MediaQuery.of(context).size.width * 0.070,
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(8, 0, 0, 0),
                      child: Text(
                        '${widget.dsix.getCurrentPlayer().pDamageTotal}',
                        style: AppTextStyles.menuItemStatStyle,
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    SvgPicture.asset(
                      AppImages.mDamage,
                      color: widget.dsix.getCurrentPlayer().primaryColor,
                      width: MediaQuery.of(context).size.width * 0.080,
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(8, 0, 0, 0),
                      child: Text(
                        '${widget.dsix.getCurrentPlayer().mDamageTotal}',
                        style: AppTextStyles.menuItemStatStyle,
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    SvgPicture.asset(
                      AppImages.pArmor,
                      color: widget.dsix.getCurrentPlayer().primaryColor,
                      width: MediaQuery.of(context).size.width * 0.070,
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(8, 0, 0, 0),
                      child: Text(
                        '${widget.dsix.getCurrentPlayer().pArmorTotal}',
                        style: AppTextStyles.menuItemStatStyle,
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    SvgPicture.asset(
                      AppImages.mArmor,
                      color: widget.dsix.getCurrentPlayer().primaryColor,
                      width: MediaQuery.of(context).size.width * 0.070,
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(8, 0, 0, 0),
                      child: Text(
                        '${widget.dsix.getCurrentPlayer().mArmorTotal}',
                        style: AppTextStyles.menuItemStatStyle,
                      ),
                    ),
                  ],
                ),
                GestureDetector(
                  // onTap: () {
                  //   showAlertDialogWeight(context);
                  // },
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        SvgPicture.asset(
                          AppImages.weight,
                          color: widget.dsix.getCurrentPlayer().primaryColor,
                          width: MediaQuery.of(context).size.width * 0.055,
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(7, 1, 0, 5),
                          child: Text(
                            '${widget.dsix.getCurrentPlayer().weight}',
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
                            '${widget.dsix.getCurrentPlayer().race.maxWeight}',
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
          color: widget.dsix.getCurrentPlayer().primaryColor,
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
                        height: MediaQuery.of(context).size.height * 0.28,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: widget.dsix.getCurrentPlayer().primaryColor,
                            width:
                                1.5, //                   <--- border width here
                          ),
                        ),
                        child: GestureDetector(
                            onTap: () async {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return ItemDialog(
                                    menu: 'equipped',
                                    item: widget.dsix
                                        .getCurrentPlayer()
                                        .mainHandSlot,
                                    player: widget.dsix.getCurrentPlayer(),
                                    itemSlot: 'mainHand',
                                  );
                                },
                              ).then((_) => setState(() {
                                    widget.refresh();
                                  }));
                            },
                            onDoubleTap: () {
                              setState(() {
                                _inventoryPageVM.unequip(
                                    widget.dsix.getCurrentPlayer(),
                                    widget.dsix.getCurrentPlayer().mainHandSlot,
                                    'mainHand');
                              });
                            },
                            child: ItemSlot(
                              player: widget.dsix.getCurrentPlayer(),
                              slotType: 'mainHand',
                            )),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width * 0.265,
                        height: MediaQuery.of(context).size.width * 0.265,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: widget.dsix.getCurrentPlayer().primaryColor,
                            width:
                                1.5, //                   <--- border width here
                          ),
                        ),
                        child: GestureDetector(
                            onTap: () async {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return ItemDialog(
                                    menu: 'equipped',
                                    item:
                                        widget.dsix.getCurrentPlayer().handSlot,
                                    player: widget.dsix.getCurrentPlayer(),
                                    itemSlot: 'hands',
                                  );
                                },
                              ).then((_) => setState(() {
                                    widget.refresh();
                                  }));
                            },
                            onDoubleTap: () {
                              setState(() {
                                _inventoryPageVM.unequip(
                                    widget.dsix.getCurrentPlayer(),
                                    widget.dsix.getCurrentPlayer().handSlot,
                                    'hands');
                              });
                            },
                            child: ItemSlot(
                              player: widget.dsix.getCurrentPlayer(),
                              slotType: 'hands',
                            )),
                      ),
                    ],
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Container(
                        width: MediaQuery.of(context).size.width * 0.265,
                        height: MediaQuery.of(context).size.width * 0.265,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: widget.dsix.getCurrentPlayer().primaryColor,
                            width:
                                1.5, //                   <--- border width here
                          ),
                        ),
                        child: GestureDetector(
                            onTap: () async {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return ItemDialog(
                                    menu: 'equipped',
                                    item:
                                        widget.dsix.getCurrentPlayer().headSlot,
                                    player: widget.dsix.getCurrentPlayer(),
                                    itemSlot: 'head',
                                  );
                                },
                              ).then((_) => setState(() {
                                    widget.refresh();
                                  }));
                            },
                            onDoubleTap: () {
                              setState(() {
                                _inventoryPageVM.unequip(
                                    widget.dsix.getCurrentPlayer(),
                                    widget.dsix.getCurrentPlayer().headSlot,
                                    'head');
                              });
                            },
                            child: ItemSlot(
                              player: widget.dsix.getCurrentPlayer(),
                              slotType: 'head',
                            )),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width * 0.265,
                        height: MediaQuery.of(context).size.height * 0.28,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: widget.dsix.getCurrentPlayer().primaryColor,
                            width:
                                1.5, //                   <--- border width here
                          ),
                        ),
                        child: GestureDetector(
                            onTap: () async {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return ItemDialog(
                                    menu: 'equipped',
                                    item:
                                        widget.dsix.getCurrentPlayer().bodySlot,
                                    player: widget.dsix.getCurrentPlayer(),
                                    itemSlot: 'body',
                                  );
                                },
                              ).then((_) => setState(() {
                                    widget.refresh();
                                  }));
                            },
                            onDoubleTap: () {
                              setState(() {
                                _inventoryPageVM.unequip(
                                    widget.dsix.getCurrentPlayer(),
                                    widget.dsix.getCurrentPlayer().bodySlot,
                                    'body');
                              });
                            },
                            child: ItemSlot(
                              player: widget.dsix.getCurrentPlayer(),
                              slotType: 'body',
                            )),
                      ),
                    ],
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Container(
                        width: MediaQuery.of(context).size.width * 0.265,
                        height: MediaQuery.of(context).size.height * 0.28,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: widget.dsix.getCurrentPlayer().primaryColor,
                            width:
                                1.5, //                   <--- border width here
                          ),
                        ),
                        child: GestureDetector(
                            onTap: () async {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return ItemDialog(
                                    menu: 'equipped',
                                    item: widget.dsix
                                        .getCurrentPlayer()
                                        .offHandSlot,
                                    player: widget.dsix.getCurrentPlayer(),
                                    itemSlot: 'offHand',
                                  );
                                },
                              ).then((_) => setState(() {
                                    widget.refresh();
                                  }));
                            },
                            onDoubleTap: () {
                              setState(() {
                                _inventoryPageVM.unequip(
                                    widget.dsix.getCurrentPlayer(),
                                    widget.dsix.getCurrentPlayer().offHandSlot,
                                    'offHand');
                              });
                            },
                            child: ItemSlot(
                              player: widget.dsix.getCurrentPlayer(),
                              slotType: 'offHand',
                            )),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width * 0.265,
                        height: MediaQuery.of(context).size.width * 0.265,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: widget.dsix.getCurrentPlayer().primaryColor,
                            width:
                                1.5, //                   <--- border width here
                          ),
                        ),
                        child: GestureDetector(
                            onTap: () async {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return ItemDialog(
                                    menu: 'equipped',
                                    item:
                                        widget.dsix.getCurrentPlayer().feetSlot,
                                    player: widget.dsix.getCurrentPlayer(),
                                    itemSlot: 'feet',
                                  );
                                },
                              ).then((_) => setState(() {
                                    widget.refresh();
                                  }));
                            },
                            onDoubleTap: () {
                              setState(() {
                                _inventoryPageVM.unequip(
                                    widget.dsix.getCurrentPlayer(),
                                    widget.dsix.getCurrentPlayer().feetSlot,
                                    'feet');
                              });
                            },
                            child: ItemSlot(
                              player: widget.dsix.getCurrentPlayer(),
                              slotType: 'feet',
                            )),
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
          color: widget.dsix.getCurrentPlayer().primaryColor,
        ),
        Expanded(
          flex: 4,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(5, 2, 5, 0),
            child: GridView.count(
              crossAxisCount: 6,
              children: List.generate(widget.dsix.getCurrentPlayer().bag.length,
                  (index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: GestureDetector(
                    onTap: () async {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return ItemDialog(
                            menu: 'bag',
                            itemSlot: 'bag',
                            item: widget.dsix.getCurrentPlayer().bag[index],
                            player: widget.dsix.getCurrentPlayer(),
                            onUse: () async {
                              _inventoryPageVM.useOrEquip(
                                  widget.dsix.getCurrentPlayer(),
                                  widget.dsix.getCurrentPlayer().bag[index]);
                            },
                          );
                        },
                      ).then((_) => setState(() {
                            widget.refresh();
                          }));
                    },
                    // onLongPress: () {
                    //   showAlertDialogDestroyItem(context,
                    //       widget.dsix.gm.getCurrentPlayer().inventory[index]);
                    // },
                    onDoubleTap: () {
                      setState(() {
                        _inventoryPageVM.useOrEquip(
                            widget.dsix.getCurrentPlayer(),
                            widget.dsix.getCurrentPlayer().bag[index]);
                      });
                    },
                    // onDoubleTap: () {
                    //   useOrEquip(
                    //     widget.dsix.gm.getCurrentPlayer().inventory[index],
                    //   );
                    //   widget.refresh();
                    // },
                    child: SvgPicture.asset(
                      'assets/icon/item/${widget.dsix.getCurrentPlayer().bag[index].icon}.svg',
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
