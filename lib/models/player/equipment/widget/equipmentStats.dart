import 'package:dsixv02app/shared/app_Colors.dart';
import 'package:dsixv02app/shared/app_Icons.dart';
import 'package:dsixv02app/shared/widgets/uiColor.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

// ignore: must_be_immutable
class EquipmentStats extends StatelessWidget {
  String? playerID;
  int? pDamage;
  int? mDamage;
  int? pArmor;
  int? mArmor;
  int? currentWeight;
  int? maxWeight;
  EquipmentStats({
    Key? key,
    @required this.playerID,
    @required this.pDamage,
    @required this.mDamage,
    @required this.pArmor,
    @required this.mArmor,
    @required this.currentWeight,
    @required this.maxWeight,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    UIColor _uiColor = UIColor();

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            SvgPicture.asset(
              AppIcons.pDamage,
              color: _uiColor.setUIColor(playerID, 'primary'),
              width: MediaQuery.of(context).size.height * 0.035,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 2),
              child: Text(
                '$pDamage',
                style: TextStyle(
                  fontFamily: 'Santana',
                  height: 1,
                  fontSize: 25,
                  color: AppColors.white00,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 3,
                ),
              ),
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            SvgPicture.asset(
              AppIcons.mDamage,
              color: _uiColor.setUIColor(playerID, 'primary'),
              width: MediaQuery.of(context).size.height * 0.035,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 2),
              child: Text(
                '$mDamage',
                style: TextStyle(
                  fontFamily: 'Santana',
                  height: 1,
                  fontSize: 25,
                  color: AppColors.white00,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 3,
                ),
              ),
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            SvgPicture.asset(
              AppIcons.pArmor,
              color: _uiColor.setUIColor(playerID, 'primary'),
              width: MediaQuery.of(context).size.height * 0.035,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 2),
              child: Text(
                '$pArmor',
                style: TextStyle(
                  fontFamily: 'Santana',
                  height: 1,
                  fontSize: 25,
                  color: AppColors.white00,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 3,
                ),
              ),
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            SvgPicture.asset(
              AppIcons.mArmor,
              color: _uiColor.setUIColor(playerID, 'primary'),
              width: MediaQuery.of(context).size.height * 0.035,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 2),
              child: Text(
                '$mArmor',
                style: TextStyle(
                  fontFamily: 'Santana',
                  height: 1,
                  fontSize: 25,
                  color: AppColors.white00,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 3,
                ),
              ),
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            SvgPicture.asset(
              AppIcons.weight,
              color: _uiColor.setUIColor(playerID, 'primary'),
              width: MediaQuery.of(context).size.height * 0.037,
            ),
            Text(
              '$currentWeight/$maxWeight',
              style: TextStyle(
                fontFamily: 'Santana',
                height: 1,
                fontSize: 23,
                color: AppColors.white00,
                fontWeight: FontWeight.bold,
                letterSpacing: 3,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
