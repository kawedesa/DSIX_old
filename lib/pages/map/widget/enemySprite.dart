import 'package:dotted_border/dotted_border.dart';
import 'package:dsixv02app/pages/shared/widgets/uiColor.dart';
import 'package:flutter/material.dart';
import 'spriteImage.dart';

// ignore: must_be_immutable
class EnemySprite extends StatelessWidget {
  String playerID;
  double dx;
  double dy;
  String race;
  double vision;
  EnemySprite(
      {Key key, this.playerID, this.dx, this.dy, this.race, this.vision})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    UIColor _uiColor = UIColor();
    return Positioned(
      left: dx - vision / 2,
      top: dy - vision / 2,
      child: SizedBox(
        width: vision,
        height: vision,
        child: Stack(
          children: [
            DottedBorder(
              dashPattern: [2, 2],
              borderType: BorderType.Circle,
              color:
                  _uiColor.setUIColor(playerID, 'rangeOutline').withAlpha(150),
              strokeWidth: 0.3,
              child: SizedBox(
                width: vision,
                height: vision,
              ),
            ),
            Align(
              alignment: Alignment.center,
              child: Container(
                width: 8,
                height: 8,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: _uiColor.setUIColor(playerID, 'shadow'),
                  border: Border.all(
                    color: _uiColor.setUIColor(playerID, 'rangeOutline'),
                    width: 0.3,
                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment.center,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: GestureDetector(child: SpriteImage(image: this.race)),
              ),
            )
          ],
        ),
      ),
    );
  }
}
