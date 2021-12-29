import 'package:dsixv02app/shared/widgets/uiColor.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../user.dart';

// ignore: must_be_immutable
class WalkRange extends StatelessWidget {
  double? walkRange;
  WalkRange({
    Key? key,
    @required this.walkRange,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    UIColor _uiColor = UIColor();
    double? setWalkRange(String mode) {
      if (user.selectedPlayer!.life!.isDead()) {
        return 0.0;
      }

      switch (mode) {
        case 'walk':
          return walkRange!;

        case 'wait':
          return 6;

        case 'menu':
          return 6;

        case 'attack':
          return 0.0;
      }
    }

    return AnimatedContainer(
      curve: Curves.fastLinearToSlowEaseIn,
      duration: Duration(milliseconds: 250),
      width: setWalkRange(user.playerMode!),
      height: setWalkRange(user.playerMode!),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: _uiColor
            .setUIColor(user.selectedPlayerID, 'shadow')
            .withAlpha(75 - walkRange!.floor()),
        border: Border.all(
          color: _uiColor.setUIColor(user.selectedPlayerID, 'rangeOutline'),
          width: 0.3,
        ),
      ),
    );
  }
}
