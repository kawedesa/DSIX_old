import 'package:dsixv02app/core/app_colors.dart';
import 'package:dsixv02app/core/app_images.dart';

import 'package:dsixv02app/models/player/player.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ItemSlot extends StatelessWidget {
  const ItemSlot({
    @required this.slotType,
    @required this.player,
  });

  final String slotType;
  final Player player;

  @override
  Widget build(BuildContext context) {
    String _icon;
    String _item;
    switch (this.slotType) {
      case 'head':
        _icon = AppImages.headSlot;
        _item = this.player.headSlot.icon;
        break;
      case 'body':
        _icon = AppImages.bodySlot;
        _item = this.player.bodySlot.icon;
        break;
      case 'hands':
        _icon = AppImages.handSlot;
        _item = this.player.handSlot.icon;
        break;
      case 'feet':
        _icon = AppImages.feetSlot;
        _item = this.player.feetSlot.icon;
        break;
      case 'mainHand':
        _icon = AppImages.mainHandSlot;
        _item = this.player.mainHandSlot.icon;
        break;
      case 'offHand':
        _icon = AppImages.offHandSlot;
        _item = this.player.offHandSlot.icon;
        break;
    }

    return Padding(
      padding: const EdgeInsets.all(10),
      child: (_item == '')
          ? SvgPicture.asset(
              _icon,
              color: this.player.primaryColor,
            )
          : SvgPicture.asset(
              'assets/icon/item/$_item.svg',
              color: AppColors.white01,
            ),
    );
  }
}
