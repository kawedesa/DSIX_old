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
              return AppColors.bluePlayerSecondary.withAlpha(75);

            case 'rangeOutline':
              return AppColors.bluePlayerPrimary.withAlpha(150);
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
              return AppColors.pinkPlayerSecondary.withAlpha(75);

            case 'rangeOutline':
              return AppColors.pinkPlayerPrimary.withAlpha(150);
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
              return AppColors.greenPlayerSecondary.withAlpha(75);

            case 'rangeOutline':
              return AppColors.greenPlayerPrimary.withAlpha(150);
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
              return AppColors.yellowPlayerSecondary.withAlpha(75);

            case 'rangeOutline':
              return AppColors.yellowPlayerPrimary.withAlpha(150);
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
              return AppColors.purplePlayerSecondary.withAlpha(75);

            case 'rangeOutline':
              return AppColors.purplePlayerPrimary.withAlpha(150);
          }
        }
        break;
    }
    return AppColors.white00;
  }
}
