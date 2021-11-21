import 'package:dsixv02app/core/app_colors.dart';
import 'package:dsixv02app/core/app_images.dart';
import 'package:dsixv02app/models/dsix/sprite.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'character.dart';

class AvailableCharacters {
  static final zombie = Character(
    icon: 'zombie',
    name: 'zombie',
    xp: 25,
    sprite: Sprite(
      layers: [
        SvgPicture.asset(
          AppImages.zombie,
          color: AppColors.enemy,
          width: double.infinity,
          height: double.infinity,
        ),
      ],
      size: 15,
      location: Offset(0, 0),
    ),
  );
  static final skeleton = Character(
    icon: 'skeleton',
    name: 'skeleton',
    xp: 25,
    sprite: Sprite(
      layers: [
        SvgPicture.asset(
          AppImages.skeleton,
          color: AppColors.enemy,
          width: double.infinity,
          height: double.infinity,
        ),
      ],
      size: 15,
      location: Offset(0, 0),
    ),
  );
  static final skeletonMage = Character(
    icon: 'skeletonMage',
    name: 'skeleton mage',
    xp: 50,
    sprite: Sprite(
      layers: [
        SvgPicture.asset(
          AppImages.skeletonMage,
          color: AppColors.enemy,
          width: double.infinity,
          height: double.infinity,
        ),
      ],
      size: 15,
      location: Offset(0, 0),
    ),
  );
}
