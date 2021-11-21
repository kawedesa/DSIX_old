// import 'dart:math';
// import 'package:dsixv02app/core/app_colors.dart';
// import 'package:dsixv02app/models/gm/map/mapTile.dart';
// import 'package:flutter_svg/svg.dart';

// class QuestLocation {
//   MapTile location;

//   void newRandomMap() {
//     int seed;
//     //Roll Environment
//     seed = Random().nextInt(this.availableMaps.length);

//     this.location = availableMaps[seed];
//   }

//   List<MapTile> availableMaps = [
//     MapTile(
//         name: 'crossroads',
//         layers: [
//           SvgPicture.asset(
//             'assets/image/map/crossroads/grass00.svg',
//             color: AppColors.crossroadsGrass00,
//             width: double.infinity,
//             height: double.infinity,
//           ),
//           SvgPicture.asset(
//             'assets/image/map/crossroads/grass01.svg',
//             color: AppColors.crossroadsGrass01,
//             width: double.infinity,
//             height: double.infinity,
//           ),
//           SvgPicture.asset(
//             'assets/image/map/crossroads/hill00.svg',
//             color: AppColors.crossroadsHill00,
//             width: double.infinity,
//             height: double.infinity,
//           ),
//           SvgPicture.asset(
//             'assets/image/map/crossroads/hill01.svg',
//             color: AppColors.crossroadsHill01,
//             width: double.infinity,
//             height: double.infinity,
//           ),
//           SvgPicture.asset(
//             'assets/image/map/crossroads/river00.svg',
//             color: AppColors.crossroadsRiver00,
//             width: double.infinity,
//             height: double.infinity,
//           ),
//           SvgPicture.asset(
//             'assets/image/map/crossroads/river01.svg',
//             color: AppColors.crossroadsRiver01,
//             width: double.infinity,
//             height: double.infinity,
//           ),
//           SvgPicture.asset(
//             'assets/image/map/crossroads/structure00.svg',
//             color: AppColors.crossroadsStructure00,
//             width: double.infinity,
//             height: double.infinity,
//           ),
//           SvgPicture.asset(
//             'assets/image/map/crossroads/structure01.svg',
//             color: AppColors.crossroadsStructure01,
//             width: double.infinity,
//             height: double.infinity,
//           ),
//           SvgPicture.asset(
//             'assets/image/map/crossroads/structure02.svg',
//             color: AppColors.crossroadsStructure02,
//             width: double.infinity,
//             height: double.infinity,
//           ),
//           SvgPicture.asset(
//             'assets/image/map/crossroads/structure03.svg',
//             color: AppColors.crossroadsStructure03,
//             width: double.infinity,
//             height: double.infinity,
//           ),
//           SvgPicture.asset(
//             'assets/image/map/crossroads/tree00.svg',
//             color: AppColors.crossroadsTree00,
//             width: double.infinity,
//             height: double.infinity,
//           ),
//           SvgPicture.asset(
//             'assets/image/map/crossroads/tree01.svg',
//             color: AppColors.crossroadsTree01,
//             width: double.infinity,
//             height: double.infinity,
//           ),
//           SvgPicture.asset(
//             'assets/image/map/crossroads/tree02.svg',
//             color: AppColors.crossroadsTree02,
//             width: double.infinity,
//             height: double.infinity,
//           ),
//         ],
//         size: 640)
//   ];

//   // List<MapTile> mountain = [
//   //   //Mountain 01
//   //   MapTile(
//   //     size: 640,
//   //     layers: [
//   //       SvgPicture.asset(
//   //         'assets/image/map/mountain/01_grass_00.svg',
//   //         color: AppColors.grass_00,
//   //         width: double.infinity,
//   //         height: double.infinity,
//   //       ),
//   //       SvgPicture.asset(
//   //         'assets/image/map/mountain/01_grass_01.svg',
//   //         color: AppColors.grass_01,
//   //         width: double.infinity,
//   //         height: double.infinity,
//   //       ),
//   //       SvgPicture.asset(
//   //         'assets/image/map/mountain/01_tree_01.svg',
//   //         color: AppColors.tree_01,
//   //         width: double.infinity,
//   //         height: double.infinity,
//   //       ),
//   //       SvgPicture.asset(
//   //         'assets/image/map/mountain/01_path_01.svg',
//   //         color: AppColors.path_01,
//   //         width: double.infinity,
//   //         height: double.infinity,
//   //       ),
//   //       SvgPicture.asset(
//   //         'assets/image/map/mountain/01_cave_00.svg',
//   //         color: AppColors.cave_00,
//   //         width: double.infinity,
//   //         height: double.infinity,
//   //       ),
//   //       SvgPicture.asset(
//   //         'assets/image/map/mountain/01_water_01.svg',
//   //         color: AppColors.water_01,
//   //         width: double.infinity,
//   //         height: double.infinity,
//   //       ),
//   //       SvgPicture.asset(
//   //         'assets/image/map/mountain/01_mountain_00.svg',
//   //         color: AppColors.mountain_00,
//   //         width: double.infinity,
//   //         height: double.infinity,
//   //       ),
//   //       SvgPicture.asset(
//   //         'assets/image/map/mountain/01_mountain_01.svg',
//   //         color: AppColors.mountain_01,
//   //         width: double.infinity,
//   //         height: double.infinity,
//   //       ),
//   //       SvgPicture.asset(
//   //         'assets/image/map/mountain/01_mountain_02.svg',
//   //         color: AppColors.mountain_02,
//   //         width: double.infinity,
//   //         height: double.infinity,
//   //       ),
//   //       SvgPicture.asset(
//   //         'assets/image/map/mountain/01_mountain_03.svg',
//   //         color: AppColors.mountain_03,
//   //         width: double.infinity,
//   //         height: double.infinity,
//   //       ),
//   //       SvgPicture.asset(
//   //         'assets/image/map/mountain/01_mountain_04.svg',
//   //         color: AppColors.mountain_04,
//   //         width: double.infinity,
//   //         height: double.infinity,
//   //       ),
//   //     ],
//   //   ),
//   // ];
//   // List<MapTile> island = [
//   //   //Island 01
//   //   MapTile(
//   //     size: 640,
//   //     layers: [
//   //       SvgPicture.asset(
//   //         'assets/image/map/island/01_grass_00.svg',
//   //         color: AppColors.grass_00,
//   //       ),
//   //       SvgPicture.asset(
//   //         'assets/image/map/island/01_grass_01.svg',
//   //         color: AppColors.grass_01,
//   //       ),
//   //       SvgPicture.asset(
//   //         'assets/image/map/island/01_tree_01.svg',
//   //         color: AppColors.tree_01,
//   //       ),
//   //       SvgPicture.asset(
//   //         'assets/image/map/island/01_sand_01.svg',
//   //         color: AppColors.sand_01,
//   //       ),
//   //       SvgPicture.asset(
//   //         'assets/image/map/island/01_cave_00.svg',
//   //         color: AppColors.cave_00,
//   //       ),
//   //       SvgPicture.asset(
//   //         'assets/image/map/island/01_water_00.svg',
//   //         color: AppColors.water_00,
//   //       ),
//   //       SvgPicture.asset(
//   //         'assets/image/map/island/01_water_01.svg',
//   //         color: AppColors.water_01,
//   //       ),
//   //       SvgPicture.asset(
//   //         'assets/image/map/island/01_mountain_00.svg',
//   //         color: AppColors.mountain_00,
//   //       ),
//   //       SvgPicture.asset(
//   //         'assets/image/map/island/01_mountain_01.svg',
//   //         color: AppColors.mountain_01,
//   //       ),
//   //       SvgPicture.asset(
//   //         'assets/image/map/island/01_mountain_02.svg',
//   //         color: AppColors.mountain_02,
//   //       ),
//   //       SvgPicture.asset(
//   //         'assets/image/map/island/01_mountain_03.svg',
//   //         color: AppColors.mountain_03,
//   //       ),
//   //     ],
//   //   ),
//   // ];
// }
