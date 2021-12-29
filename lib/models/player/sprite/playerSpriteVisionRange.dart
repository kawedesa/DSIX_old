import 'package:dsixv02app/shared/widgets/uiColor.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../user.dart';

// ignore: must_be_immutable
class PlayerSpriteVisionRange extends StatelessWidget {
  PlayerSpriteVisionRange({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    UIColor _uiColor = UIColor();

    double? setVisionRange(String? mode) {
      switch (mode) {
        case 'walk':
          return user.selectedPlayer!.vision!.getRange();

        case 'wait':
          return user.selectedPlayer!.vision!.getRange();

        case 'menu':
          return 6;

        case 'attack':
          return 0.0;
      }

      return 0.0;
    }

    return AnimatedContainer(
      curve: Curves.fastLinearToSlowEaseIn,
      duration: Duration(milliseconds: 700),
      width: setVisionRange(user.playerMode),
      height: setVisionRange(user.playerMode),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          color: _uiColor.setUIColor(user.selectedPlayer!.id, 'rangeOutline'),
          width: 0.3,
        ),
      ),
    );
  }
}
