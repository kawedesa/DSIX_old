import 'package:dsixv02app/models/game/gameMap/heightMap.dart';
import 'package:dsixv02app/models/player/sprite/playerTempLocation.dart';
import 'package:dsixv02app/shared/app_Colors.dart';
import 'package:dsixv02app/shared/widgets/uiColor.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../playerLocation.dart';
import '../user.dart';

// ignore: must_be_immutable
class WalkRange extends StatelessWidget {
  PlayerTempLocation? tempLocation;
  PlayerLocation? oldLocation;
  double? maxWalkRange;
  HeightMap? heightMap;

  WalkRange({
    Key? key,
    @required this.tempLocation,
    @required this.oldLocation,
    @required this.maxWalkRange,
    @required this.heightMap,
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
          return tempLocation!.distanceLeftOver(oldLocation!, maxWalkRange!);

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
        color: (tempLocation!.height == 10)
            ? AppColors.cantPassArea
            : _uiColor
                .setUIColor(user.selectedPlayer!.id, 'shadow')
                .withAlpha(75 - setWalkRange(user.playerMode!)!.floor()),
        border: Border.all(
          color: (tempLocation!.height == 10)
              ? AppColors.cantPassOutline
              : _uiColor.setUIColor(user.selectedPlayer!.id, 'rangeOutline'),
          width: 0.3,
        ),
      ),
    );
  }
}
