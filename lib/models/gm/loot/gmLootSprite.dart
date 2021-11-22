// ignore_for_file: must_be_immutable
import 'package:dsixv02app/core/app_colors.dart';
import 'package:dsixv02app/core/app_images.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class GmLootSprite extends StatefulWidget {
  GmLootSprite({
    @required this.gold,
    @required this.size,
    @required this.location,
    @required this.confirm,
    this.updateLocation,
  });
  int gold;
  final double size;
  Offset location;
  Function() confirm;
  final Function(Offset) updateLocation;

  @override
  State<GmLootSprite> createState() => _GmLootSpriteState();
}

class _GmLootSpriteState extends State<GmLootSprite> {
  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: widget.location.dx,
      top: widget.location.dy,
      child: GestureDetector(
        onTap: () {
          widget.confirm();
        },
        onPanUpdate: (details) {
          setState(() {
            widget.updateLocation(details.delta);
            widget.location = Offset(widget.location.dx + details.delta.dx,
                widget.location.dy + details.delta.dy);
          });
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
