import 'package:dotted_border/dotted_border.dart';
import 'package:dsixv02app/shared/widgets/uiColor.dart';
import 'package:flutter/material.dart';
import 'package:transparent_pointer/transparent_pointer.dart';

// ignore: must_be_immutable
class EnemyPlayerSpriteVisionRange extends StatelessWidget {
  String? enemyID;
  double? visionRange;
  bool? isDead;
  EnemyPlayerSpriteVisionRange(
      {Key? key,
      @required this.enemyID,
      @required this.visionRange,
      @required this.isDead})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    UIColor _uiColor = UIColor();

    double? setVisionRange() {
      switch (isDead) {
        case false:
          return visionRange;

        case true:
          return 0;
      }
    }

    return TransparentPointer(
      transparent: true,
      child: AnimatedContainer(
        curve: Curves.fastLinearToSlowEaseIn,
        duration: Duration(milliseconds: 700),
        width: setVisionRange(),
        height: setVisionRange(),
        child: DottedBorder(
          dashPattern: [2, 2],
          borderType: BorderType.Circle,
          color: _uiColor.setUIColor(enemyID, 'rangeOutline').withAlpha(150),
          strokeWidth: 0.3,
          child: SizedBox(
            width: visionRange,
            height: visionRange,
          ),
        ),
      ),
    );
  }
}
