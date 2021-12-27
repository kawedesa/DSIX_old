import 'package:dsixv02app/shared/app_Colors.dart';
import 'package:flutter/material.dart';

class UIColor {
  Color setUIColor(String? id, String color) {
    switch (id) {
      case 'blue':
        {
          switch (color) {
            case 'primary':
              return AppColors.bluePlayerPrimary;

            case 'secondary':
              return AppColors.bluePlayerSecondary;

            case 'tertiary':
              return AppColors.bluePlayerTertiary;

            case 'shadow':
              return AppColors.bluePlayerShadow;

            case 'rangeOutline':
              return AppColors.bluePlayerRange;
          }
        }
        break;
      case 'pink':
        {
          switch (color) {
            case 'primary':
              return AppColors.pinkPlayerPrimary;

            case 'secondary':
              return AppColors.pinkPlayerSecondary;

            case 'tertiary':
              return AppColors.pinkPlayerTertiary;

            case 'shadow':
              return AppColors.pinkPlayerShadow;

            case 'rangeOutline':
              return AppColors.pinkPlayerRange;
          }
        }
        break;
      case 'green':
        {
          switch (color) {
            case 'primary':
              return AppColors.greenPlayerPrimary;

            case 'secondary':
              return AppColors.greenPlayerSecondary;

            case 'tertiary':
              return AppColors.greenPlayerTertiary;

            case 'shadow':
              return AppColors.greenPlayerShadow;

            case 'rangeOutline':
              return AppColors.greenPlayerRange;
          }
        }
        break;
      case 'yellow':
        {
          switch (color) {
            case 'primary':
              return AppColors.yellowPlayerPrimary;

            case 'secondary':
              return AppColors.yellowPlayerSecondary;

            case 'tertiary':
              return AppColors.yellowPlayerTertiary;

            case 'shadow':
              return AppColors.yellowPlayerShadow;

            case 'rangeOutline':
              return AppColors.yellowPlayerRange;
          }
        }
        break;
      case 'purple':
        {
          switch (color) {
            case 'primary':
              return AppColors.purplePlayerPrimary;

            case 'secondary':
              return AppColors.purplePlayerSecondary;

            case 'tertiary':
              return AppColors.purplePlayerTertiary;

            case 'shadow':
              return AppColors.purplePlayerShadow;

            case 'rangeOutline':
              return AppColors.purplePlayerRange;
          }
        }
        break;
    }
    return AppColors.white00;
  }
}
