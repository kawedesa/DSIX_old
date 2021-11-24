import 'package:flutter/material.dart';

class AppColors {
//UI
  static final logoColor = Colors.grey[500];

  static final nextButtonColor = Colors.lightGreenAccent;

  static final white01 = Colors.white;
  static final black01 = Colors.black;

  static final neutral00 = Colors.grey[900];
  static final neutral01 = Colors.grey[800];
  static final neutral02 = Colors.grey[700];
  static final neutral03 = Colors.grey[600];
  static final neutral04 = Colors.grey[500];
  static final neutral05 = Colors.grey[400];
  static final neutral06 = Colors.grey[300];
  static final neutral07 = Colors.grey[200];
  static final neutral08 = Colors.grey[100];

  static final separator = Color.fromRGBO(41, 32, 29, 0.2);
  static final separatorBlack = Color.fromRGBO(41, 32, 29, 0.8);

//Players

//Action
  static final success = Colors.green;
  static final fail = Colors.red;

//Pink

  static final pinkPrimaryColor = Colors.pinkAccent;
  static final pinkSecondaryColor = Colors.pink[100];
  static final pinkTertiaryColor = Colors.pink[800];

  static final pinkSprite = Color.fromRGBO(176, 47, 103, 1);

//Blue

  static final bluePrimaryColor = Colors.indigoAccent;
  static final blueSecondaryColor = Colors.indigo[100];
  static final blueTertiaryColor = Colors.indigo[800];

  static final blueSprite = Color.fromRGBO(16, 102, 121, 1);

//Green

  static final greenPrimaryColor = Colors.teal;
  static final greenSecondaryColor = Colors.teal[100];
  static final greenTertiaryColor = Colors.teal[800];

  static final greenSprite = Color.fromRGBO(73, 133, 22, 1);

//Yellow

  static final yellowPrimaryColor = Colors.orange;
  static final yellowSecondaryColor = Colors.orange[100];
  static final yellowTertiaryColor = Colors.orange[800];

  static final yellowSprite = Color.fromRGBO(187, 136, 0, 1);

//Purple

  static final purplePrimaryColor = Colors.purple;
  static final purpleSecondaryColor = Colors.purple[100];
  static final purpleTertiaryColor = Colors.purple[800];

  static final purpleSprite = Color.fromRGBO(118, 53, 144, 1);

//Gm

  static final gmPrimaryColor = Colors.grey[900];
  static final gmSecondaryColor = Colors.grey[100];
  static final gmTertiaryColor = Colors.grey[600];

//Sprite Color

  static final attackRange = Color.fromRGBO(250, 5, 5, 0.1);

  static final walkRange = Color.fromRGBO(41, 32, 29, 0.1);
  static final walkRangeActive = Color.fromRGBO(41, 32, 29, 0.2);
  static final rangeOutline = Color.fromRGBO(238, 225, 217, 0.3);

  static final selected = Color.fromRGBO(238, 225, 217, 0.3);
  static final selectedBorder = Color.fromRGBO(192, 184, 172, 1);

  static final objective = Color.fromRGBO(139, 101, 2, 1);
  static final neutral = Colors.red;
  static final enemy = Color.fromRGBO(200, 5, 5, 1);
  static final ally = Color.fromRGBO(38, 83, 35, 1);

  //Loot and Chest

  static final chestRange = Color.fromRGBO(41, 32, 29, 0.1);

  static final goldChest = Color.fromRGBO(230, 170, 70, 1);
  static final goldChestOpened = Color.fromRGBO(100, 80, 60, 1);

  static final itemChest = Color.fromRGBO(70, 170, 230, 1);
  static final itemChestOpened = Color.fromRGBO(80, 120, 160, 1);

  static final grave = Color.fromRGBO(200, 230, 200, 1);
  static final graveOpened = Color.fromRGBO(100, 120, 100, 1);

  static final loot = Color.fromRGBO(230, 170, 70, 1);
  static final lootOpened = Color.fromRGBO(120, 100, 80, 1);

//Map

//Crossroads

  static final crossroadsGrass00 = Color.fromRGBO(97, 103, 72, 1);
  static final crossroadsGrass01 = Color.fromRGBO(158, 151, 64, 1);
  static final crossroadsHill00 = Color.fromRGBO(61, 64, 60, 1);
  static final crossroadsHill01 = Color.fromRGBO(73, 81, 80, 1);
  static final crossroadsRiver00 = Color.fromRGBO(87, 109, 100, 1);
  static final crossroadsRiver01 = Color.fromRGBO(114, 155, 142, 1);
  static final crossroadsStructure00 = Color.fromRGBO(113, 114, 114, 1);
  static final crossroadsStructure01 = Color.fromRGBO(132, 134, 122, 1);
  static final crossroadsStructure02 = Color.fromRGBO(174, 166, 124, 1);
  static final crossroadsStructure03 = Color.fromRGBO(196, 187, 142, 1);
  static final crossroadsTree00 = Color.fromRGBO(59, 40, 28, 1);
  static final crossroadsTree01 = Color.fromRGBO(134, 87, 58, 1);
  static final crossroadsTree02 = Color.fromRGBO(158, 122, 66, 1);

// //Cave
//   static final cave_00 = Color.fromRGBO(6, 6, 6, 1);

// //Path
//   static final path_01 = Color.fromRGBO(204, 150, 89, 1);

// //Sand
//   static final sand_01 = Color.fromRGBO(232, 217, 152, 1);

// //Water
//   static final water_00 = Color.fromRGBO(61, 161, 210, 1);
//   static final water_01 = Color.fromRGBO(77, 184, 232, 1);

// //Grass
//   static final grass_00 = Color.fromRGBO(83, 143, 64, 1);
//   static final grass_01 = Color.fromRGBO(145, 201, 89, 1);

// // Tree
//   static final tree_01 = Color.fromRGBO(47, 81, 38, 1);

// //Mountain
//   static final mountain_00 = Color.fromRGBO(127, 66, 35, 1);
//   static final mountain_01 = Color.fromRGBO(170, 99, 65, 1);
//   static final mountain_02 = Color.fromRGBO(200, 120, 85, 1);
//   static final mountain_03 = Color.fromRGBO(230, 140, 101, 1);
//   static final mountain_04 = Color.fromRGBO(239, 143, 109, 1);

// //Buildings

//   static final black_00 = Color.fromRGBO(41, 32, 29, 1);
//   static final black_01 = Color.fromRGBO(79, 65, 57, 1);

//   static final grey_00 = Color.fromRGBO(164, 158, 150, 1);

//   static final yellow_00 = Color.fromRGBO(236, 184, 30, 1);
//   static final yellow_01 = Color.fromRGBO(254, 203, 73, 1);

//   static final object_00 = Color.fromRGBO(186, 133, 138, 1);
//   static final object_01 = Color.fromRGBO(226, 168, 176, 1);

//   static final white_00 = Color.fromRGBO(238, 225, 217, 1);

}
