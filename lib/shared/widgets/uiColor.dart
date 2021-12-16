import 'package:dsixv02app/shared/app_Colors.dart';
import 'package:flutter/material.dart';

class UIColor {
  Color setUIColor(String id, String color) {
    switch (id) {
      case 'blue':
        {
          switch (color) {
            case 'primary':
              return AppColors.bluePlayerPrimary;
              break;
            case 'secondary':
              return AppColors.bluePlayerSecondary;
              break;
            case 'tertiary':
              return AppColors.bluePlayerTertiary;
              break;
            case 'shadow':
              return AppColors.bluePlayerSecondary.withAlpha(75);
              break;
            case 'rangeOutline':
              return AppColors.bluePlayerPrimary.withAlpha(150);
              break;
          }
        }
        break;
      case 'pink':
        {
          switch (color) {
            case 'primary':
              return AppColors.pinkPlayerPrimary;
              break;
            case 'secondary':
              return AppColors.pinkPlayerSecondary;
              break;
            case 'tertiary':
              return AppColors.pinkPlayerTertiary;
              break;
            case 'shadow':
              return AppColors.pinkPlayerSecondary.withAlpha(75);
              break;

            case 'rangeOutline':
              return AppColors.pinkPlayerPrimary.withAlpha(150);
              break;
          }
        }
        break;
      case 'green':
        {
          switch (color) {
            case 'primary':
              return AppColors.greenPlayerPrimary;
              break;
            case 'secondary':
              return AppColors.greenPlayerSecondary;
              break;
            case 'tertiary':
              return AppColors.greenPlayerTertiary;
              break;
            case 'shadow':
              return AppColors.greenPlayerSecondary.withAlpha(75);
              break;
            case 'rangeOutline':
              return AppColors.greenPlayerPrimary.withAlpha(150);
              break;
          }
        }
        break;
      case 'yellow':
        {
          switch (color) {
            case 'primary':
              return AppColors.yellowPlayerPrimary;
              break;
            case 'secondary':
              return AppColors.yellowPlayerSecondary;
              break;
            case 'tertiary':
              return AppColors.yellowPlayerTertiary;
              break;
            case 'shadow':
              return AppColors.yellowPlayerSecondary.withAlpha(75);
              break;
            case 'rangeOutline':
              return AppColors.yellowPlayerPrimary.withAlpha(150);
              break;
          }
        }
        break;
      case 'purple':
        {
          switch (color) {
            case 'primary':
              return AppColors.purplePlayerPrimary;
              break;
            case 'secondary':
              return AppColors.purplePlayerSecondary;
              break;
            case 'tertiary':
              return AppColors.purplePlayerTertiary;
              break;
            case 'shadow':
              return AppColors.purplePlayerSecondary.withAlpha(75);
              break;
            case 'rangeOutline':
              return AppColors.purplePlayerPrimary.withAlpha(150);
              break;
          }
        }
        break;
    }
    return AppColors.white00;
  }
}
