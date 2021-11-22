import 'package:dsixv02app/core/app_colors.dart';
import 'package:dsixv02app/core/app_icon.dart';
import 'package:dsixv02app/core/app_images.dart';
import 'package:dsixv02app/models/dsix/sprite.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'character.dart';

class AvailableCharacters {
  static final zombie = Character(
    icon: AppIcon(icon: AppImages.zombie, color: AppColors.enemy),
    name: 'zombie',
    xp: 25,
    size: 17,
    location: Offset(0, 0),
  );
  static final skeleton = Character(
    icon: AppIcon(icon: AppImages.skeleton, color: AppColors.enemy),
    name: 'skeleton',
    xp: 25,
    size: 15,
    location: Offset(0, 0),
  );
  static final skeletonMage = Character(
    icon: AppIcon(icon: AppImages.skeletonMage, color: AppColors.enemy),
    name: 'skeleton mage',
    xp: 25,
    size: 15,
    location: Offset(0, 0),
  );
}
