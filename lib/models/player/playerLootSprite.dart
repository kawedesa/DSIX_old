// ignore_for_file: must_be_immutable
import 'package:dsixv02app/core/app_colors.dart';
import 'package:dsixv02app/core/app_images.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class PlayerLootSprite extends StatefulWidget {
  PlayerLootSprite(
      {@required this.gold,
      @required this.size,
      @required this.location,
      @required this.open,
      @required this.type,
      @required this.opened});
  int gold;
  final double size;
  Offset location;
  Function() open;
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
      case 'chest':
        this.image = (widget.opened)
            ? SvgPicture.asset(
                AppImages.loot,
                color: AppColors.lootOpened,
                width: double.infinity,
                height: double.infinity,
              )
            : SvgPicture.asset(
                AppImages.loot,
                color: AppColors.loot,
                width: double.infinity,
                height: double.infinity,
              );
        break;
      case 'corpse':
        this.image = (widget.opened)
            ? SvgPicture.asset(
                AppImages.grave,
                color: AppColors.lootOpened,
                width: double.infinity,
                height: double.infinity,
              )
            : SvgPicture.asset(
                AppImages.grave,
                color: AppColors.loot,
                width: double.infinity,
                height: double.infinity,
              );
        break;
    }

    return Positioned(
      left: widget.location.dx,
      top: widget.location.dy,
      child: GestureDetector(
        onTap: () {
          setState(() {
            widget.open();
          });
        },
        child: Container(
          width: widget.size,
          height: widget.size,
          child: Stack(children: [
            this.image,
          ]),
        ),
      ),
    );
  }
}
