import 'package:dsixv02app/models/player/player.dart';
import 'package:dsixv02app/pages/map/endGameButton.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:rive/rive.dart';

class MapPageVM {
  TransformationController canvasController;
  List<Widget> temporaryUI = [];

  double minZoom = 4.5;
  double maxZoom = 15;

  void createCanvasController(context, double mapSize, double dx, double dy) {
    if (canvasController != null) {
      return;
    }
    updateCanvasController(context, mapSize, dx, dy);
  }

  void updateCanvasController(context, double mapSize, double dx, double dy) {
    double dxCanvas = dx * minZoom - MediaQuery.of(context).size.width / 2;
    double dyCanvas =
        dy * minZoom - MediaQuery.of(context).size.height * 0.8 / 2;

    if (dxCanvas < 0) {
      dxCanvas = 0;
    }
    if (dxCanvas > mapSize * minZoom - MediaQuery.of(context).size.width) {
      dxCanvas = mapSize * minZoom - MediaQuery.of(context).size.width;
    }
    if (dyCanvas < 0) {
      dyCanvas = 0;
    }
    if (dyCanvas >
        mapSize * minZoom - MediaQuery.of(context).size.height * 0.9) {
      dyCanvas = mapSize * minZoom - MediaQuery.of(context).size.height * 0.9;
    }

    canvasController = TransformationController(Matrix4(minZoom, 0, 0, 0, 0,
        minZoom, 0, 0, 0, 0, minZoom, 0, -dxCanvas, -dyCanvas, 0, 1));
  }

  void goToPlayer(context, double mapSize, Player player) {
    updateCanvasController(context, mapSize, player.dx, player.dy);
  }

  void createEndGameButton(bool isDead) {
    this.temporaryUI = [];
    this.temporaryUI.add(EndGameButton(isDead: isDead));
  }

  Artboard artboard;

  void loadRiverFile() async {
    final bytes = await rootBundle.load('assets/animation/turn.riv');
    final file = RiveFile.import(bytes);
    artboard = file.mainArtboard;
    offAnimation();
  }

  offAnimation() {
    artboard.addController(SimpleAnimation('off'));
  }

  playYourTurnAnimation() {
    artboard.addController(OneShotAnimation('yourTurn'));
  }
}

// ignore: must_be_immutable
class EffectSprite extends StatelessWidget {
  Offset location;
  EffectSprite({Key key, this.location}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: location.dx,
      top: location.dy,
      child: Container(
        width: 20,
        height: 20,
        color: Colors.amber,
      ),
    );
  }
}
