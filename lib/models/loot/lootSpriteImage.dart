import 'package:dsixv02app/shared/app_Colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

// ignore: must_be_immutable
class LootSpriteImage extends StatelessWidget {
  bool isClosed;

  LootSpriteImage({
    @required this.isClosed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 15,
      height: 15,
      child: Stack(
        alignment: Alignment.topLeft,
        children: (isClosed)
            ? [
                SvgPicture.asset(
                  'assets/image/sprite/chest/closedChestInside00.svg',
                  color: AppColors.chestInside00,
                  width: double.infinity,
                  height: double.infinity,
                ),
                SvgPicture.asset(
                  'assets/image/sprite/chest/closedChestMetal00.svg',
                  color: AppColors.chestMetal00,
                  width: double.infinity,
                  height: double.infinity,
                ),
                SvgPicture.asset(
                  'assets/image/sprite/chest/closedChestMetal01.svg',
                  color: AppColors.chestMetal01,
                  width: double.infinity,
                  height: double.infinity,
                ),
                SvgPicture.asset(
                  'assets/image/sprite/chest/closedChestWood00.svg',
                  color: AppColors.chestWood00,
                  width: double.infinity,
                  height: double.infinity,
                ),
                SvgPicture.asset(
                  'assets/image/sprite/chest/closedChestWood01.svg',
                  color: AppColors.chestWood01,
                  width: double.infinity,
                  height: double.infinity,
                ),
              ]
            : [
                SvgPicture.asset(
                  'assets/image/sprite/chest/openChestInside00.svg',
                  color: AppColors.chestInside00,
                  width: double.infinity,
                  height: double.infinity,
                ),
                SvgPicture.asset(
                  'assets/image/sprite/chest/openChestMetal00.svg',
                  color: AppColors.chestMetal00,
                  width: double.infinity,
                  height: double.infinity,
                ),
                SvgPicture.asset(
                  'assets/image/sprite/chest/openChestMetal01.svg',
                  color: AppColors.chestMetal01,
                  width: double.infinity,
                  height: double.infinity,
                ),
                SvgPicture.asset(
                  'assets/image/sprite/chest/openChestWood00.svg',
                  color: AppColors.chestWood00,
                  width: double.infinity,
                  height: double.infinity,
                ),
                SvgPicture.asset(
                  'assets/image/sprite/chest/openChestWood01.svg',
                  color: AppColors.chestWood01,
                  width: double.infinity,
                  height: double.infinity,
                ),
              ],
      ),
    );
  }
}
