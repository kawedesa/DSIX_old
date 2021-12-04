import 'package:dsixv02app/core/widgets/characterSpriteImage.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'app_Colors.dart';

class AppCharacters {
  static final orc = CharacterSpriteImage(
    name: 'orc',
    size: 17,
    layers: [
      SvgPicture.asset(
        'assets/image/sprite/orc/shadow00.svg',
        color: AppColors.characterShadow00,
        width: double.infinity,
        height: double.infinity,
      ),
      SvgPicture.asset(
        'assets/image/sprite/orc/armor00.svg',
        color: AppColors.orcArmor00,
        width: double.infinity,
        height: double.infinity,
      ),
      SvgPicture.asset(
        'assets/image/sprite/orc/armor01.svg',
        color: AppColors.orcArmor01,
        width: double.infinity,
        height: double.infinity,
      ),
      SvgPicture.asset(
        'assets/image/sprite/orc/skin00.svg',
        color: AppColors.orcSkin00,
        width: double.infinity,
        height: double.infinity,
      ),
      SvgPicture.asset(
        'assets/image/sprite/orc/skin01.svg',
        color: AppColors.orcSkin01,
        width: double.infinity,
        height: double.infinity,
      ),
      SvgPicture.asset(
        'assets/image/sprite/orc/detail00.svg',
        color: AppColors.orcDetail00,
        width: double.infinity,
        height: double.infinity,
      ),
      SvgPicture.asset(
        'assets/image/sprite/orc/detail01.svg',
        color: AppColors.orcDetail01,
        width: double.infinity,
        height: double.infinity,
      ),
    ],
  );

  static final dwarf = CharacterSpriteImage(
    name: 'dwarf',
    size: 15,
    layers: [
      SvgPicture.asset(
        'assets/image/sprite/dwarf/shadow00.svg',
        color: AppColors.characterShadow00,
        width: double.infinity,
        height: double.infinity,
      ),
      SvgPicture.asset(
        'assets/image/sprite/dwarf/armor00.svg',
        color: AppColors.dwarfArmor00,
        width: double.infinity,
        height: double.infinity,
      ),
      SvgPicture.asset(
        'assets/image/sprite/dwarf/armor01.svg',
        color: AppColors.dwarfArmor01,
        width: double.infinity,
        height: double.infinity,
      ),
      SvgPicture.asset(
        'assets/image/sprite/dwarf/skin00.svg',
        color: AppColors.dwarfSkin00,
        width: double.infinity,
        height: double.infinity,
      ),
      SvgPicture.asset(
        'assets/image/sprite/dwarf/skin01.svg',
        color: AppColors.dwarfSkin01,
        width: double.infinity,
        height: double.infinity,
      ),
      SvgPicture.asset(
        'assets/image/sprite/dwarf/detail00.svg',
        color: AppColors.dwarfDetail00,
        width: double.infinity,
        height: double.infinity,
      ),
      SvgPicture.asset(
        'assets/image/sprite/dwarf/detail01.svg',
        color: AppColors.dwarfDetail01,
        width: double.infinity,
        height: double.infinity,
      ),
      SvgPicture.asset(
        'assets/image/sprite/dwarf/beard00.svg',
        color: AppColors.dwarfBeard00,
        width: double.infinity,
        height: double.infinity,
      ),
    ],
  );
}
