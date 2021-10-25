import 'package:dsixv02app/core/app_colors.dart';
import 'package:dsixv02app/core/app_images.dart';
import 'package:dsixv02app/models/gm/character/characterSprite.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'character.dart';

class AvailableCharacters {
  static final zombie = Character(
    icon: 'zombie',
    name: 'zombie',
    xp: 25,
    sprite: CharacterSprite(layers: [
      SvgPicture.asset(
        AppImages.zombie,
        color: AppColors.character,
        width: double.infinity,
        height: double.infinity,
      ),
    ], size: 12),
  );
  static final skeleton = Character(
    icon: 'skeleton',
    name: 'skeleton',
    xp: 25,
    sprite: CharacterSprite(layers: [
      SvgPicture.asset(
        AppImages.skeleton,
        color: AppColors.character,
        width: double.infinity,
        height: double.infinity,
      ),
    ], size: 10),
  );
  static final skeletonMage = Character(
    icon: 'skeletonMage',
    name: 'skeleton mage',
    xp: 50,
    sprite: CharacterSprite(layers: [
      SvgPicture.asset(
        AppImages.skeletonMage,
        color: AppColors.character,
        width: double.infinity,
        height: double.infinity,
      ),
    ], size: 10),
  );
}
