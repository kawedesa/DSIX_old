import 'package:dsixv02app/core/app_colors.dart';

import 'package:dsixv02app/models/dsix/item.dart';
import 'package:dsixv02app/models/player/player.dart';
import 'package:dsixv02app/widgets/buttons/dialogButton.dart';
import 'package:dsixv02app/widgets/dialogs/dialogTitle.dart';
import 'package:dsixv02app/widgets/itemStatsBar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ItemDialog extends StatelessWidget {
  const ItemDialog({
    @required this.item,
    @required this.player,
    @required this.menu,
    this.itemSlot,
    this.onUse,
  });

  final String menu;
  final Item item;
  final Player player;
  final String itemSlot;
  final Function() onUse;

  @override
  Widget build(BuildContext context) {
    Widget _dialogButtons;
    String _buttonText;
    switch (menu) {
      case 'shop':
        _dialogButtons = Builder(builder: (BuildContext context) {
          return DialogButton(
            buttonText: item.value.toString(),
            buttonColor: player.primaryColor,
            buttonTextColor: AppColors.white01,
            buttonIcon: 'gold',
            onTapAction: () {
              player.buyItem(item);
              Navigator.pop(context);
            },
          );
        });

        break;
      case 'bag':
        if (item.name == 'MAGIC RUNE') {
          _buttonText = 'enchant';
        } else if (item.name == 'AMMO') {
          _buttonText = 'restock';
        } else if (item.inventorySpace == 'consumable') {
          _buttonText = 'use';
        } else {
          _buttonText = 'equipped';
        }

        _dialogButtons = Builder(builder: (BuildContext context) {
          return Column(
            children: [
              DialogButton(
                buttonText: _buttonText,
                buttonColor: player.primaryColor,
                buttonTextColor: AppColors.white01,
                buttonIcon: 'up',
                onTapAction: () {
                  onUse();
                  Navigator.pop(context);
                },
              ),
              DialogButton(
                buttonText: 'give',
                buttonColor: player.primaryColor,
                buttonTextColor: AppColors.white01,
                buttonIcon: 'right',
                onTapAction: () {
                  // player.buyItem(item);
                  Navigator.pop(context);
                },
              ),
              DialogButton(
                buttonText: 'sell',
                buttonColor: player.primaryColor,
                buttonTextColor: AppColors.white01,
                buttonIcon: 'gold',
                onTapAction: () {
                  player.sellItem(item, itemSlot);
                  Navigator.pop(context);
                },
              ),
            ],
          );
        });

        break;
      case 'equipped':
        _dialogButtons = Builder(builder: (BuildContext context) {
          return Column(
            children: [
              DialogButton(
                buttonText: 'unequip',
                buttonColor: player.primaryColor,
                buttonTextColor: AppColors.white01,
                buttonIcon: 'down',
                onTapAction: () {
                  player.unequipItem(item, itemSlot);
                  Navigator.pop(context);
                },
              ),
              DialogButton(
                buttonText: 'give',
                buttonColor: player.primaryColor,
                buttonTextColor: AppColors.white01,
                buttonIcon: 'right',
                onTapAction: () {
                  // player.buyItem(item);
                  Navigator.pop(context);
                },
              ),
              DialogButton(
                buttonText: 'sell',
                buttonColor: player.primaryColor,
                buttonTextColor: AppColors.white01,
                buttonIcon: 'gold',
                onTapAction: () {
                  player.sellItem(item, itemSlot);
                  Navigator.pop(context);
                },
              ),
            ],
          );
        });

        break;
    }

    return AlertDialog(
      contentPadding: EdgeInsets.fromLTRB(0, 0, 0, 0),
      content: Container(
        color: AppColors.black01,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              decoration: BoxDecoration(
                border: Border.all(
                  color: this.player.primaryColor,
                  width: 2.5, //                   <--- border width here
                ),
              ),
              width: MediaQuery.of(context).size.width * 0.7,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  DialogTitle(
                    title: this.item.name,
                    color: player.primaryColor,
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.4,
                    width: double.infinity,
                    child: Stack(children: <Widget>[
                      (item.uses > 1)
                          ? Padding(
                              padding: const EdgeInsets.all(15),
                              child: Container(
                                width: 25,
                                child: GridView.count(
                                  crossAxisCount: 1,
                                  children: List.generate(item.uses, (index) {
                                    return Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 0),
                                      child: SvgPicture.asset(
                                        'assets/icon/item/ammo.svg',
                                        color: this.player.primaryColor,
                                      ),
                                    );
                                  }),
                                ),
                              ),
                            )
                          : Container(),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(25, 20, 25, 20),
                        child: SvgPicture.asset(
                          'assets/icon/item/${item.icon}.svg',
                          color: Colors.white,
                        ),
                      ),
                    ]),
                  ),
                  Divider(
                    thickness: 2,
                    color: this.player.primaryColor,
                  ),
                  ItemStatsBar(
                    item: item,
                    color: player.primaryColor,
                  ),
                  Divider(
                    thickness: 2,
                    height: 0,
                    color: this.player.primaryColor,
                  ),
                  _dialogButtons
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
