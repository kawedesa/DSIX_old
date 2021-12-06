import 'package:dotted_border/dotted_border.dart';
import 'package:dsixv02app/pages/shared/app_Colors.dart';
import 'package:flutter/material.dart';
import 'spriteImage.dart';

// ignore: must_be_immutable
class EnemySprite extends StatelessWidget {
  double dx;
  double dy;
  String race;
  double vision;
  EnemySprite({Key key, this.dx, this.dy, this.race, this.vision})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: dx - vision / 2,
      top: dy - vision / 2,
      child: SizedBox(
        width: vision,
        height: vision,
        child: Stack(
          children: [
            DottedBorder(
              dashPattern: [2, 4],
              borderType: BorderType.Circle,
              color: AppColors.enemyRange00.withAlpha(75),
              strokeWidth: 0.5,
              child: SizedBox(
                width: vision,
                height: vision,
              ),
            ),
            Align(
              alignment: Alignment.center,
              child: Padding(
                padding: const EdgeInsets.only(top: 13),
                child: Container(
                  width: 10,
                  height: 10,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColors.enemyShadow00,
                    border: Border.all(
                      color: AppColors.enemyRange00.withAlpha(75),
                      width: 0.5,
                    ),
                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment.center,
              child: GestureDetector(child: SpriteImage(image: this.race)),
            )
          ],
        ),
      ),
    );
  }
}
