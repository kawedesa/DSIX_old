// import 'package:dsixv02app/core/app_colors.dart';
// import 'package:dsixv02app/models/gm/building/building.dart';
// import 'package:dsixv02app/models/gm/sprite/availableCharacters.dart';
// import 'package:flutter_svg/flutter_svg.dart';

// import 'buildingSprite.dart';

// class AvailableBuildings {
//   List<Building> altar = [
//     altarS01,
//     altarM01,
//     altarL01,
//   ];
//   List<Building> outpost = [
//     outpostS01,
//     outpostM01,
//     outpostL01,
//   ];

// //Altar

//   static final altarS01 = Building(
//     xp: 50,
//     availableCharacters: [
//       AvailableCharacters.skeleton,
//       AvailableCharacters.zombie,
//     ],
//     sprite: BuildingSprite(
//       size: 32,
//       layers: [
//         SvgPicture.asset(
//           'assets/image/building/altar/S_01_black_00.svg',
//           color: AppColors.black_00,
//           width: double.infinity,
//           height: double.infinity,
//         ),
//         SvgPicture.asset(
//           'assets/image/building/altar/S_01_black_01.svg',
//           color: AppColors.black_01,
//           width: double.infinity,
//           height: double.infinity,
//         ),
//         SvgPicture.asset(
//           'assets/image/building/altar/S_01_grey_00.svg',
//           color: AppColors.grey_00,
//           width: double.infinity,
//           height: double.infinity,
//         ),
//         SvgPicture.asset(
//           'assets/image/building/altar/S_01_grey_01.svg',
//           color: AppColors.grey_01,
//           width: double.infinity,
//           height: double.infinity,
//         ),
//         SvgPicture.asset(
//           'assets/image/building/altar/S_01_yellow_00.svg',
//           color: AppColors.yellow_00,
//           width: double.infinity,
//           height: double.infinity,
//         ),
//         SvgPicture.asset(
//           'assets/image/building/altar/S_01_yellow_01.svg',
//           color: AppColors.yellow_01,
//           width: double.infinity,
//           height: double.infinity,
//         ),
//       ],
//     ),
//   );

//   static final altarM01 = Building(
//     xp: 300,
//     availableCharacters: [
//       AvailableCharacters.zombie,
//       AvailableCharacters.skeleton,
//       AvailableCharacters.skeletonMage,
//     ],
//     sprite: BuildingSprite(
//       size: 64,
//       layers: [
//         SvgPicture.asset(
//           'assets/image/building/altar/M_01_black_00.svg',
//           color: AppColors.black_00,
//           width: double.infinity,
//           height: double.infinity,
//         ),
//         SvgPicture.asset(
//           'assets/image/building/altar/M_01_black_01.svg',
//           color: AppColors.black_01,
//           width: double.infinity,
//           height: double.infinity,
//         ),
//         SvgPicture.asset(
//           'assets/image/building/altar/M_01_grey_00.svg',
//           color: AppColors.grey_00,
//           width: double.infinity,
//           height: double.infinity,
//         ),
//         SvgPicture.asset(
//           'assets/image/building/altar/M_01_grey_01.svg',
//           color: AppColors.grey_01,
//           width: double.infinity,
//           height: double.infinity,
//         ),
//         SvgPicture.asset(
//           'assets/image/building/altar/M_01_white_00.svg',
//           color: AppColors.white_00,
//           width: double.infinity,
//           height: double.infinity,
//         ),
//       ],
//     ),
//   );

//   static final altarL01 = Building(
//     xp: 500,
//     availableCharacters: [
//       AvailableCharacters.zombie,
//       AvailableCharacters.skeleton,
//       AvailableCharacters.skeletonMage,
//     ],
//     sprite: BuildingSprite(
//       size: 128,
//       layers: [
//         SvgPicture.asset(
//           'assets/image/building/altar/L_01_black_00.svg',
//           color: AppColors.black_00,
//           width: double.infinity,
//           height: double.infinity,
//         ),
//         SvgPicture.asset(
//           'assets/image/building/altar/L_01_black_01.svg',
//           color: AppColors.black_01,
//           width: double.infinity,
//           height: double.infinity,
//         ),
//         SvgPicture.asset(
//           'assets/image/building/altar/L_01_grey_00.svg',
//           color: AppColors.grey_00,
//           width: double.infinity,
//           height: double.infinity,
//         ),
//         SvgPicture.asset(
//           'assets/image/building/altar/L_01_grey_01.svg',
//           color: AppColors.grey_01,
//           width: double.infinity,
//           height: double.infinity,
//         ),
//         SvgPicture.asset(
//           'assets/image/building/altar/L_01_white_00.svg',
//           color: AppColors.white_00,
//           width: double.infinity,
//           height: double.infinity,
//         ),
//         SvgPicture.asset(
//           'assets/image/building/altar/L_01_yellow_00.svg',
//           color: AppColors.yellow_00,
//           width: double.infinity,
//           height: double.infinity,
//         ),
//         SvgPicture.asset(
//           'assets/image/building/altar/L_01_yellow_01.svg',
//           color: AppColors.yellow_01,
//           width: double.infinity,
//           height: double.infinity,
//         ),
//       ],
//     ),
//   );

// //Outpost

//   static final outpostS01 = Building(
//     xp: 50,
//     availableCharacters: [
//       AvailableCharacters.zombie,
//       AvailableCharacters.skeleton,
//       AvailableCharacters.skeletonMage,
//     ],
//     sprite: BuildingSprite(
//       size: 32,
//       layers: [
//         SvgPicture.asset(
//           'assets/image/building/outpost/S_01_black_00.svg',
//           color: AppColors.black_00,
//           width: double.infinity,
//           height: double.infinity,
//         ),
//         SvgPicture.asset(
//           'assets/image/building/outpost/S_01_grey_00.svg',
//           color: AppColors.grey_00,
//           width: double.infinity,
//           height: double.infinity,
//         ),
//         SvgPicture.asset(
//           'assets/image/building/outpost/S_01_grey_01.svg',
//           color: AppColors.grey_01,
//           width: double.infinity,
//           height: double.infinity,
//         ),
//         SvgPicture.asset(
//           'assets/image/building/outpost/S_01_object_00.svg',
//           color: AppColors.object_00,
//           width: double.infinity,
//           height: double.infinity,
//         ),
//         SvgPicture.asset(
//           'assets/image/building/outpost/S_01_object_01.svg',
//           color: AppColors.object_01,
//           width: double.infinity,
//           height: double.infinity,
//         ),
//       ],
//     ),
//   );

//   static final outpostM01 = Building(
//     xp: 300,
//     availableCharacters: [
//       AvailableCharacters.zombie,
//       AvailableCharacters.skeleton,
//       AvailableCharacters.skeletonMage,
//     ],
//     sprite: BuildingSprite(
//       size: 64,
//       layers: [
//         SvgPicture.asset(
//           'assets/image/building/outpost/M_01_black_00.svg',
//           color: AppColors.black_00,
//           width: double.infinity,
//           height: double.infinity,
//         ),
//         SvgPicture.asset(
//           'assets/image/building/outpost/M_01_black_01.svg',
//           color: AppColors.black_01,
//           width: double.infinity,
//           height: double.infinity,
//         ),
//         SvgPicture.asset(
//           'assets/image/building/outpost/M_01_grey_00.svg',
//           color: AppColors.grey_00,
//           width: double.infinity,
//           height: double.infinity,
//         ),
//         SvgPicture.asset(
//           'assets/image/building/outpost/M_01_grey_01.svg',
//           color: AppColors.grey_01,
//           width: double.infinity,
//           height: double.infinity,
//         ),
//         SvgPicture.asset(
//           'assets/image/building/outpost/M_01_object_00.svg',
//           color: AppColors.object_00,
//           width: double.infinity,
//           height: double.infinity,
//         ),
//         SvgPicture.asset(
//           'assets/image/building/outpost/M_01_object_01.svg',
//           color: AppColors.object_01,
//           width: double.infinity,
//           height: double.infinity,
//         ),
//         SvgPicture.asset(
//           'assets/image/building/outpost/M_01_yellow_00.svg',
//           color: AppColors.yellow_00,
//           width: double.infinity,
//           height: double.infinity,
//         ),
//         SvgPicture.asset(
//           'assets/image/building/outpost/M_01_yellow_01.svg',
//           color: AppColors.yellow_01,
//           width: double.infinity,
//           height: double.infinity,
//         ),
//       ],
//     ),
//   );

//   static final outpostL01 = Building(
//     xp: 500,
//     availableCharacters: [
//       AvailableCharacters.zombie,
//       AvailableCharacters.skeleton,
//       AvailableCharacters.skeletonMage,
//     ],
//     sprite: BuildingSprite(
//       size: 128,
//       layers: [
//         SvgPicture.asset(
//           'assets/image/building/outpost/L_01_black_00.svg',
//           color: AppColors.black_00,
//           width: double.infinity,
//           height: double.infinity,
//         ),
//         SvgPicture.asset(
//           'assets/image/building/outpost/L_01_black_01.svg',
//           color: AppColors.black_01,
//           width: double.infinity,
//           height: double.infinity,
//         ),
//         SvgPicture.asset(
//           'assets/image/building/outpost/L_01_grey_00.svg',
//           color: AppColors.grey_00,
//           width: double.infinity,
//           height: double.infinity,
//         ),
//         SvgPicture.asset(
//           'assets/image/building/outpost/L_01_grey_01.svg',
//           color: AppColors.grey_01,
//           width: double.infinity,
//           height: double.infinity,
//         ),
//         SvgPicture.asset(
//           'assets/image/building/outpost/L_01_object_00.svg',
//           color: AppColors.object_00,
//           width: double.infinity,
//           height: double.infinity,
//         ),
//         SvgPicture.asset(
//           'assets/image/building/outpost/L_01_object_01.svg',
//           color: AppColors.object_01,
//           width: double.infinity,
//           height: double.infinity,
//         ),
//         SvgPicture.asset(
//           'assets/image/building/outpost/L_01_yellow_00.svg',
//           color: AppColors.yellow_00,
//           width: double.infinity,
//           height: double.infinity,
//         ),
//         SvgPicture.asset(
//           'assets/image/building/outpost/L_01_yellow_01.svg',
//           color: AppColors.yellow_01,
//           width: double.infinity,
//           height: double.infinity,
//         ),
//       ],
//     ),
//   );
// }
