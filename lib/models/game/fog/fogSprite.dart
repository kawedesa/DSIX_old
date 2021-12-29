import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:transparent_pointer/transparent_pointer.dart';
import '../game.dart';
import 'fogArea.dart';

class FogSprite extends StatelessWidget {
  const FogSprite({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final game = Provider.of<Game>(context);
    return Positioned(
      left: game.fog!.dx! - game.fog!.size! / 2,
      top: game.fog!.dy! - game.fog!.size! / 2,
      child: TransparentPointer(
        transparent: true,
        child: CustomPaint(
          painter:
              FogArea(minRange: game.fog!.size!, maxRange: game.map!.size! * 3),
          child: SizedBox(
            width: game.fog!.size!,
            height: game.fog!.size!,
          ),
        ),
      ),
    );
  }
}
