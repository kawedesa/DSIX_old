import 'package:dsixv02app/models/game/game.dart';
import 'package:dsixv02app/models/game/gameController.dart';
import 'package:dsixv02app/models/player/player.dart';
import 'package:dsixv02app/models/player/playerLocation.dart';
import 'package:dsixv02app/models/turn/turnController.dart';
import 'package:flutter/material.dart';
import 'widgets/endGameButton.dart';

class MapPageVM {
  TransformationController? canvasController;
  double minZoom = 3.5;
  double maxZoom = 15;

  void createCanvasController(
      context, double mapSize, PlayerLocation? location) {
    if (canvasController != null) {
      return;
    }
    updateCanvasController(context, mapSize, location);
  }

  void updateCanvasController(
      context, double? mapSize, PlayerLocation? location) {
    double dxCanvas =
        location!.dx! * minZoom - MediaQuery.of(context).size.width / 2;
    double dyCanvas =
        location.dy! * minZoom - MediaQuery.of(context).size.height * 0.8 / 2;

    if (dxCanvas < 0) {
      dxCanvas = 0;
    }
    if (dxCanvas > mapSize! * minZoom - MediaQuery.of(context).size.width) {
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
    updateCanvasController(context, mapSize, player.location);
  }

  void newRound(Game game, GameController gameController,
      TurnController turnController, List<Player> players) async {
    turnController.newTurnOrder(game.id!, players);
    gameController.newRound(game);
    await Future.delayed(Duration(seconds: 1));
  }

  List<Widget> temporaryUI = [];

  void createEndGameButton(bool isDead) {
    this.temporaryUI = [];
    this.temporaryUI.add(EndGameButton(isDead: isDead));
  }
}
