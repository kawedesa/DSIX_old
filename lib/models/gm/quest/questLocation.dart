import 'dart:math';
import 'package:dsixv02app/core/app_colors.dart';
import 'package:dsixv02app/models/dsix/mapTile.dart';
import 'package:flutter_svg/svg.dart';

class QuestLocation {
  String location;
  MapTile map;

  void newRandomMap() {
    int seed;
    MapTile newMap;
    //Roll Environment
    seed = Random().nextInt(this.availableLocations.length);

    //Choose environment
    String randomEnvironment = this.availableLocations[seed];
    this.location = randomEnvironment;

    switch (randomEnvironment) {
      case 'mountain':
        seed = Random().nextInt(this.mountain.length);
        newMap = this.mountain[seed];

        break;
      case 'island':
        seed = Random().nextInt(this.island.length);
        newMap = this.island[seed];
        break;
    }
    this.map = newMap;
  }

  List<String> availableLocations = [
    'mountain',
    'island',
  ];
  List<MapTile> mountain = [
    //Mountain 01
    MapTile(
      size: 640,
      layers: [
        SvgPicture.asset(
          'assets/image/map/mountain/01_grass_00.svg',
          color: AppColors.grass_00,
          width: double.infinity,
          height: double.infinity,
        ),
        SvgPicture.asset(
          'assets/image/map/mountain/01_grass_01.svg',
          color: AppColors.grass_01,
          width: double.infinity,
          height: double.infinity,
        ),
        SvgPicture.asset(
          'assets/image/map/mountain/01_tree_01.svg',
          color: AppColors.tree_01,
          width: double.infinity,
          height: double.infinity,
        ),
        SvgPicture.asset(
          'assets/image/map/mountain/01_path_01.svg',
          color: AppColors.path_01,
          width: double.infinity,
          height: double.infinity,
        ),
        SvgPicture.asset(
          'assets/image/map/mountain/01_cave_00.svg',
          color: AppColors.cave_00,
          width: double.infinity,
          height: double.infinity,
        ),
        SvgPicture.asset(
          'assets/image/map/mountain/01_water_01.svg',
          color: AppColors.water_01,
          width: double.infinity,
          height: double.infinity,
        ),
        SvgPicture.asset(
          'assets/image/map/mountain/01_mountain_00.svg',
          color: AppColors.mountain_00,
          width: double.infinity,
          height: double.infinity,
        ),
        SvgPicture.asset(
          'assets/image/map/mountain/01_mountain_01.svg',
          color: AppColors.mountain_01,
          width: double.infinity,
          height: double.infinity,
        ),
        SvgPicture.asset(
          'assets/image/map/mountain/01_mountain_02.svg',
          color: AppColors.mountain_02,
          width: double.infinity,
          height: double.infinity,
        ),
        SvgPicture.asset(
          'assets/image/map/mountain/01_mountain_03.svg',
          color: AppColors.mountain_03,
          width: double.infinity,
          height: double.infinity,
        ),
        SvgPicture.asset(
          'assets/image/map/mountain/01_mountain_04.svg',
          color: AppColors.mountain_04,
          width: double.infinity,
          height: double.infinity,
        ),
      ],
    ),
  ];
  List<MapTile> island = [
    //Island 01
    MapTile(
      size: 640,
      layers: [
        SvgPicture.asset(
          'assets/image/map/island/01_grass_00.svg',
          color: AppColors.grass_00,
        ),
        SvgPicture.asset(
          'assets/image/map/island/01_grass_01.svg',
          color: AppColors.grass_01,
        ),
        SvgPicture.asset(
          'assets/image/map/island/01_tree_01.svg',
          color: AppColors.tree_01,
        ),
        SvgPicture.asset(
          'assets/image/map/island/01_sand_01.svg',
          color: AppColors.sand_01,
        ),
        SvgPicture.asset(
          'assets/image/map/island/01_cave_00.svg',
          color: AppColors.cave_00,
        ),
        SvgPicture.asset(
          'assets/image/map/island/01_water_00.svg',
          color: AppColors.water_00,
        ),
        SvgPicture.asset(
          'assets/image/map/island/01_water_01.svg',
          color: AppColors.water_01,
        ),
        SvgPicture.asset(
          'assets/image/map/island/01_mountain_00.svg',
          color: AppColors.mountain_00,
        ),
        SvgPicture.asset(
          'assets/image/map/island/01_mountain_01.svg',
          color: AppColors.mountain_01,
        ),
        SvgPicture.asset(
          'assets/image/map/island/01_mountain_02.svg',
          color: AppColors.mountain_02,
        ),
        SvgPicture.asset(
          'assets/image/map/island/01_mountain_03.svg',
          color: AppColors.mountain_03,
        ),
      ],
    ),
  ];
}
