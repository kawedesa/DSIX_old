import 'package:dsixv02app/core/app_colors.dart';
import 'package:flutter/material.dart';

class AppTextStyles {
//Button

  static final neutralButtonStyle = TextStyle(
    fontSize: 15,
    fontWeight: FontWeight.bold,
    letterSpacing: 1.5,
    fontFamily: 'Calibri',
    color: AppColors.neutral03,
  );

  static final whiteButtonStyle = TextStyle(
    fontSize: 15,
    fontWeight: FontWeight.bold,
    letterSpacing: 1.5,
    fontFamily: 'Calibri',
    color: AppColors.white01,
  );

//Title
  static final neutralTitle = TextStyle(
    fontSize: 30,
    height: 1,
    letterSpacing: 1.2,
    fontFamily: 'Santana',
    color: AppColors.neutral02,
  );

  //SubTitle

  static final subTitle = TextStyle(
    letterSpacing: 3,
    fontSize: 18,
    fontFamily: 'Headline',
    color: AppColors.white01,
  );

//Description Dialog

  static final dialogTitleStyle = TextStyle(
    fontFamily: 'Santana',
    height: 1,
    fontSize: 25,
    color: AppColors.white01,
    fontWeight: FontWeight.bold,
    letterSpacing: 3,
  );

  static final dialogDescriptionStyle = TextStyle(
    height: 1.25,
    fontSize: 19,
    fontFamily: 'Calibri',
    color: AppColors.white01,
  );

  static final textFieldStyle = TextStyle(
    height: 1.5,
    fontSize: 25,
    fontWeight: FontWeight.bold,
    letterSpacing: 1.5,
    fontFamily: 'Calibri',
    color: AppColors.white01,
  );

  //Health Dialog

  static final healthAndGoldDialogStyle = TextStyle(
    height: 1.25,
    fontSize: 60,
    fontFamily: 'Calibri',
    color: Colors.white,
  );

  //Amount Dialog

  static final amountDialogStyle = TextStyle(
    height: 1.25,
    fontSize: 60,
    fontFamily: 'Calibri',
    color: Colors.white,
  );

//Buildind Dialog
  static final buildingDialogStatStyle = TextStyle(
    fontFamily: 'Santana',
    height: 1,
    fontSize: 20,
    color: AppColors.white01,
    fontWeight: FontWeight.bold,
    letterSpacing: 3,
  );

  //Menu Item Stats

  static final menuItemStatStyle = TextStyle(
    fontFamily: 'Santana',
    height: 1,
    fontSize: 25,
    color: AppColors.white01,
    fontWeight: FontWeight.bold,
    letterSpacing: 3,
  );

//Appbar

  static final appBarItem = TextStyle(
    fontFamily: 'Santana',
    height: 1,
    fontSize: 30,
    color: AppColors.white01,
    letterSpacing: 1.2,
  );
}
