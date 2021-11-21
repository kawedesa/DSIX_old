// ignore_for_file: must_be_immutable
import 'package:dsixv02app/core/app_colors.dart';
import 'package:dsixv02app/core/app_images.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class Loot extends StatefulWidget {
  Loot({
    @required this.value,
    @required this.size,
    @required this.location,
    @required this.openLoot,
  });
  int value;
  final double size;
  Offset location;
  Function() openLoot;

  @override
  State<Loot> createState() => _LootSpriteState();
}

class _LootSpriteState extends State<Loot> {
  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: widget.location.dx,
      top: widget.location.dy,
      child: GestureDetector(
        onTap: () {
          widget.openLoot();
        },
        child: Container(
          width: widget.size,
          height: widget.size,
          child: Stack(children: [
            SvgPicture.asset(
              AppImages.loot,
              color: AppColors.loot,
              width: double.infinity,
              height: double.infinity,
            ),
          ]),
        ),
      ),
    );
  }
}
