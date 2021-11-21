import 'package:dsixv02app/core/app_colors.dart';
import 'package:dsixv02app/models/gm/map/mapTile.dart';
import 'package:dsixv02app/models/gm/character/availableCharacters.dart';
import 'package:flutter_svg/svg.dart';

class AvailableMaps {
  static final crossroads = MapTile(
      name: 'crossroads',
      availableCharacters: [
        AvailableCharacters.zombie,
        AvailableCharacters.skeleton,
        AvailableCharacters.skeletonMage,
      ],
      layers: [
        SvgPicture.asset(
          'assets/image/map/crossroads/grass00.svg',
          color: AppColors.crossroadsGrass00,
          width: double.infinity,
          height: double.infinity,
        ),
        SvgPicture.asset(
          'assets/image/map/crossroads/grass01.svg',
          color: AppColors.crossroadsGrass01,
          width: double.infinity,
          height: double.infinity,
        ),
        SvgPicture.asset(
          'assets/image/map/crossroads/hill00.svg',
          color: AppColors.crossroadsHill00,
          width: double.infinity,
          height: double.infinity,
        ),
        SvgPicture.asset(
          'assets/image/map/crossroads/hill01.svg',
          color: AppColors.crossroadsHill01,
          width: double.infinity,
          height: double.infinity,
        ),
        SvgPicture.asset(
          'assets/image/map/crossroads/river00.svg',
          color: AppColors.crossroadsRiver00,
          width: double.infinity,
          height: double.infinity,
        ),
        SvgPicture.asset(
          'assets/image/map/crossroads/river01.svg',
          color: AppColors.crossroadsRiver01,
          width: double.infinity,
          height: double.infinity,
        ),
        SvgPicture.asset(
          'assets/image/map/crossroads/structure00.svg',
          color: AppColors.crossroadsStructure00,
          width: double.infinity,
          height: double.infinity,
        ),
        SvgPicture.asset(
          'assets/image/map/crossroads/structure01.svg',
          color: AppColors.crossroadsStructure01,
          width: double.infinity,
          height: double.infinity,
        ),
        SvgPicture.asset(
          'assets/image/map/crossroads/structure02.svg',
          color: AppColors.crossroadsStructure02,
          width: double.infinity,
          height: double.infinity,
        ),
        SvgPicture.asset(
          'assets/image/map/crossroads/structure03.svg',
          color: AppColors.crossroadsStructure03,
          width: double.infinity,
          height: double.infinity,
        ),
        SvgPicture.asset(
          'assets/image/map/crossroads/tree00.svg',
          color: AppColors.crossroadsTree00,
          width: double.infinity,
          height: double.infinity,
        ),
        SvgPicture.asset(
          'assets/image/map/crossroads/tree01.svg',
          color: AppColors.crossroadsTree01,
          width: double.infinity,
          height: double.infinity,
        ),
        SvgPicture.asset(
          'assets/image/map/crossroads/tree02.svg',
          color: AppColors.crossroadsTree02,
          width: double.infinity,
          height: double.infinity,
        ),
      ],
      size: 640);
}
