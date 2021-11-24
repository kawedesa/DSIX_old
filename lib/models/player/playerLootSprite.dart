// ignore_for_file: must_be_immutable
import 'package:dsixv02app/core/app_colors.dart';
import 'package:dsixv02app/core/app_images.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class PlayerLootSprite extends StatefulWidget {
  PlayerLootSprite(
      {@required this.size,
      @required this.location,
      @required this.openAction,
      @required this.type,
      @required this.opened});

  final double size;
  Offset location;
  Function() openAction;
  String type;
  bool opened;

  @override
  State<PlayerLootSprite> createState() => _PlayerLootSpriteState();
}

class _PlayerLootSpriteState extends State<PlayerLootSprite> {
  Widget image = Container();

  @override
  Widget build(BuildContext context) {
    switch (widget.type) {
      case 'item':
        this.image = SvgPicture.asset(
          AppImages.loot,
          color:
              (widget.opened) ? AppColors.itemChestOpened : AppColors.itemChest,
          width: double.infinity,
          height: double.infinity,
        );
        break;
      case 'gold':
        this.image = SvgPicture.asset(
          AppImages.loot,
          color:
              (widget.opened) ? AppColors.goldChestOpened : AppColors.goldChest,
          width: double.infinity,
          height: double.infinity,
        );
        break;
      case 'grave':
        this.image = SvgPicture.asset(
          AppImages.grave,
          color: (widget.opened) ? AppColors.graveOpened : AppColors.grave,
          width: double.infinity,
          height: double.infinity,
        );
        break;
    }

    return Positioned(
      left: widget.location.dx - 2,
      top: widget.location.dy - 2,
      child: GestureDetector(
        onTap: () {
          setState(() {
            if (widget.opened == false) {
              widget.openAction();
            }
          });
        },
        child: Container(
          width: widget.size + 15,
          height: widget.size + 15,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(
              color: AppColors.rangeOutline,
              width: 0.5,
            ),
            color: AppColors.chestRange,
          ),
          child: Center(
            child: Container(
              width: widget.size,
              height: widget.size,
              child: Stack(children: [
                this.image,
              ]),
            ),
          ),
        ),
      ),
    );
  }
}
