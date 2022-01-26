import 'package:dsixv02app/shared/app_Colors.dart';
import 'package:dsixv02app/shared/app_Icons.dart';
import 'package:dsixv02app/shared/widgets/uiColor.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../player.dart';

// ignore: must_be_immutable
class EquipmentStats extends StatelessWidget {
  Player? player;
  EquipmentStats({
    Key? key,
    @required this.player,
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
              color: _uiColor.setUIColor(player!.id, 'primary'),
              width: MediaQuery.of(context).size.height * 0.035,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 2),
              child: Text(
                '${player!.equipment!.damage!.pDamage}',
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
              color: _uiColor.setUIColor(player!.id, 'primary'),
              width: MediaQuery.of(context).size.height * 0.035,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 2),
              child: Text(
                '${player!.equipment!.damage!.mDamage}',
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
              color: _uiColor.setUIColor(player!.id, 'primary'),
              width: MediaQuery.of(context).size.height * 0.035,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 2),
              child: Text(
                '${player!.equipment!.armor!.pArmor}',
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
              color: _uiColor.setUIColor(player!.id, 'primary'),
              width: MediaQuery.of(context).size.height * 0.035,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 2),
              child: Text(
                '${player!.equipment!.armor!.mArmor}',
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
              color: _uiColor.setUIColor(player!.id, 'primary'),
              width: MediaQuery.of(context).size.height * 0.037,
            ),
            Text(
              '${player!.equipment!.weight!.current}/${player!.equipment!.weight!.max}',
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
