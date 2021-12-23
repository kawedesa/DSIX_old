import 'package:flutter/services.dart';
import 'package:rive/rive.dart';

class MapPageAnimation {
  Artboard? artboard;

  void loadRiverFile() async {
    final bytes = await rootBundle.load('assets/animation/turn.riv');
    final file = RiveFile.import(bytes);
    artboard = file.mainArtboard;
    offAnimation();
  }

  offAnimation() {
    artboard!.addController(SimpleAnimation('off'));
  }

  playYourTurnAnimation() {
    artboard!.addController(SimpleAnimation('yourTurn'));
  }
}
