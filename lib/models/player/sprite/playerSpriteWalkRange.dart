import 'package:dsixv02app/models/game/gameMap/heightMap.dart';
import 'package:dsixv02app/models/player/playerTempLocation.dart';
import 'package:dsixv02app/shared/app_Colors.dart';
import 'package:dsixv02app/shared/widgets/uiColor.dart';
import 'package:flutter/material.dart';
import '../player.dart';
import '../playerLocation.dart';

// ignore: must_be_immutable
class WalkRange extends StatelessWidget {
  PlayerTempLocation? tempLocation;
  PlayerLocation? oldLocation;
  double? maxWalkRange;
  HeightMap? heightMap;
  Player? player;

  WalkRange({
    Key? key,
    @required this.tempLocation,
    @required this.oldLocation,
    @required this.maxWalkRange,
    @required this.heightMap,
    @required this.player,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    UIColor _uiColor = UIColor();

    double? setWalkRange(String mode) {
      switch (mode) {
        case 'walk':
          return tempLocation!.distanceLeftOver(maxWalkRange!);

        case 'wait':
          return 6;

        case 'menu':
          return 6;

        case 'attack':
          return 0.0;

        case 'dead':
          return 0.0;
      }
    }

    return AnimatedContainer(
      curve: Curves.fastLinearToSlowEaseIn,
      duration: Duration(milliseconds: 250),
      width: setWalkRange(player!.mode!),
      height: setWalkRange(player!.mode!),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: (tempLocation!.height == 10)
            ? AppColors.cantPassArea
            : _uiColor
                .setUIColor(player!.id, 'shadow')
                .withAlpha(75 - setWalkRange(player!.mode!)!.floor()),
        border: Border.all(
          color: (tempLocation!.height == 10)
              ? AppColors.cantPassOutline
              : _uiColor.setUIColor(player!.id, 'rangeOutline'),
          width: 0.3,
        ),
      ),
    );
  }
}
