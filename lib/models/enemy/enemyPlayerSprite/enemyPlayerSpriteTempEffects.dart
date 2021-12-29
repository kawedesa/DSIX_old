import 'package:dsixv02app/shared/app_Icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:transparent_pointer/transparent_pointer.dart';

// ignore: must_be_immutable
class EnemySpriteTempEffects extends StatelessWidget {
  int? tempArmor;
  EnemySpriteTempEffects({Key? key, @required this.tempArmor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TransparentPointer(
      transparent: true,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 26),
        child: AnimatedContainer(
          duration: Duration(milliseconds: 250),
          width: (tempArmor! > 0) ? 3 : 0,
          height: (tempArmor! > 0) ? 3 : 0,
          child: SvgPicture.asset(
            AppIcons.tempArmor,
            color: Color.fromRGBO(250, 50, 10, 1),
          ),
        ),
      ),
    );
  }
}
