import 'package:dsixv02app/shared/widgets/uiColor.dart';
import 'package:flutter/material.dart';
import '../player.dart';

// ignore: must_be_immutable
class PlayerSpriteVisionRange extends StatelessWidget {
  Player? player;
  PlayerSpriteVisionRange({
    Key? key,
    @required this.player,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    UIColor _uiColor = UIColor();

    return AnimatedContainer(
      curve: Curves.fastLinearToSlowEaseIn,
      duration: Duration(milliseconds: 700),
      width: player!.vision!.setVisionRange('walk'),
      height: player!.vision!.setVisionRange('walk'),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          color: _uiColor.setUIColor(player!.id, 'rangeOutline'),
          width: 0.3,
        ),
      ),
    );
  }
}
