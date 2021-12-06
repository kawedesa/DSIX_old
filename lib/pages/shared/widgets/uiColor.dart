import 'package:dsixv02app/pages/shared/app_Colors.dart';
import 'package:flutter/material.dart';

class UIColor {
  Color setUIColor(String id, String color) {
    switch (id) {
      case 'blue':
        {
          if (color == 'primary') {
            return AppColors.bluePlayerPrimary;
          }
          if (color == 'secondary') {
            return AppColors.bluePlayerSecondary;
          }
        }
        break;
      case 'pink':
        {
          if (color == 'primary') {
            return AppColors.pinkPlayerPrimary;
          }
          if (color == 'secondary') {
            return AppColors.pinkPlayerSecondary;
          }
        }
        break;
      case 'green':
        {
          if (color == 'primary') {
            return AppColors.greenPlayerPrimary;
          }
          if (color == 'secondary') {
            return AppColors.greenPlayerSecondary;
          }
        }
        break;
      case 'yellow':
        {
          if (color == 'primary') {
            return AppColors.yellowPlayerPrimary;
          }
          if (color == 'secondary') {
            return AppColors.yellowPlayerSecondary;
          }
        }
        break;
      case 'purple':
        {
          if (color == 'primary') {
            return AppColors.purplePlayerPrimary;
          }
          if (color == 'secondary') {
            return AppColors.purplePlayerSecondary;
          }
        }
        break;
    }
    return AppColors.white00;
  }
}
