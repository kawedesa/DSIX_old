import 'package:dsixv02app/shared/widgets/uiColor.dart';
import 'package:flutter/material.dart';
import 'package:transparent_pointer/transparent_pointer.dart';

// ignore: must_be_immutable
class EnemyPlayerSpriteShadow extends StatelessWidget {
  String? enemyID;
  bool? isDead;
  EnemyPlayerSpriteShadow({
    Key? key,
    @required this.enemyID,
    @required this.isDead,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    UIColor _uiColor = UIColor();

    return TransparentPointer(
      transparent: true,
      child: Container(
        width: (isDead!) ? 0 : 6,
        height: (isDead!) ? 0 : 6,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: _uiColor.setUIColor(enemyID, 'shadow'),
          border: Border.all(
            color: _uiColor.setUIColor(enemyID, 'rangeOutline'),
            width: 0.3,
          ),
        ),
      ),
    );
  }
}
