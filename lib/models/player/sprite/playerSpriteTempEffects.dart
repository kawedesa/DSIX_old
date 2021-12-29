import 'package:dsixv02app/shared/app_Colors.dart';
import 'package:dsixv02app/shared/app_Icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:transparent_pointer/transparent_pointer.dart';

// ignore: must_be_immutable
class PlayerSpriteTempEffects extends StatelessWidget {
  int? tempArmor;
  PlayerSpriteTempEffects({Key? key, @required this.tempArmor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TransparentPointer(
      transparent: true,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 28),
        child: AnimatedContainer(
          duration: Duration(milliseconds: 250),
          width: (tempArmor! > 0) ? 5 : 0,
          height: (tempArmor! > 0) ? 5 : 0,
          child: Stack(children: [
            SvgPicture.asset(
              AppIcons.tempArmor,
              color: AppColors.goodEffectImage,
            ),
            Align(
              alignment: Alignment.center,
              child: FittedBox(
                  child: Padding(
                padding: const EdgeInsets.fromLTRB(0, 1, 0, 3),
                child: Text(
                  '$tempArmor',
                  style: TextStyle(
                    letterSpacing: 1,
                    fontFamily: 'Santana',
                    color: AppColors.goodEffectText,
                  ),
                ),
              )),
            ),
          ]),
        ),
      ),
    );
  }
}
