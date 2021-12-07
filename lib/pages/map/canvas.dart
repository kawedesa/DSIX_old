import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dsixv02app/models/player.dart';
import 'package:flutter/material.dart';
import 'widget/enemySprite.dart';

class AppCanvas {
  List<EnemySprite> enemy = [];
  final db = FirebaseFirestore.instance;
  TransformationController canvasController;

  double minZoom = 4;
  double maxZoom = 15;

  void createCanvasController(context, double dx, double dy) {
    if (canvasController != null) {
      return;
    }
    double dxCanvas = dx * minZoom - MediaQuery.of(context).size.width / 2;
    double dyCanvas =
        dy * minZoom - MediaQuery.of(context).size.height * 0.8 / 2;

    if (dxCanvas < 0) {
      dxCanvas = 0;
    }
    if (dxCanvas > 640 * minZoom - MediaQuery.of(context).size.width) {
      dxCanvas = 640 * minZoom - MediaQuery.of(context).size.width;
    }
    if (dyCanvas < 0) {
      dyCanvas = 0;
    }
    if (dyCanvas > 640 * minZoom - MediaQuery.of(context).size.height * 0.9) {
      dyCanvas = 640 * minZoom - MediaQuery.of(context).size.height * 0.9;
    }

    canvasController = TransformationController(Matrix4(minZoom, 0, 0, 0, 0,
        minZoom, 0, 0, 0, 0, minZoom, 0, -dxCanvas, -dyCanvas, 0, 1));
  }

  void updateCanvasController(context, double dx, double dy) {
    double dxCanvas = dx * minZoom - MediaQuery.of(context).size.width / 2;
    double dyCanvas =
        dy * minZoom - MediaQuery.of(context).size.height * 0.8 / 2;

    if (dxCanvas < 0) {
      dxCanvas = 0;
    }
    if (dxCanvas > 640 * minZoom - MediaQuery.of(context).size.width) {
      dxCanvas = 640 * minZoom - MediaQuery.of(context).size.width;
    }
    if (dyCanvas < 0) {
      dyCanvas = 0;
    }
    if (dyCanvas > 640 * minZoom - MediaQuery.of(context).size.height * 0.9) {
      dyCanvas = 640 * minZoom - MediaQuery.of(context).size.height * 0.9;
    }

    canvasController = TransformationController(Matrix4(minZoom, 0, 0, 0, 0,
        minZoom, 0, 0, 0, 0, minZoom, 0, -dxCanvas, -dyCanvas, 0, 1));
  }

  void goToPlayer(context, List<Player> players, String playerID) {
    players.forEach((player) {
      if (player.id == playerID) {
        updateCanvasController(context, player.dx, player.dy);
      }
    });
  }

  void updateEnemyPlayersInSight(List<Player> players, Player selectedPlayer) {
    this.enemy = [];
    players.forEach((target) {
      if (target == selectedPlayer) {
        return;
      }

      if (checkIfPlayerCanSeeTheTarget(selectedPlayer, target.dx, target.dy)) {
        enemy.add(EnemySprite(
          playerID: target.id,
          dx: target.dx,
          dy: target.dy,
          race: target.race,
          vision: target.vision,
        ));
      }
    });
  }

  bool checkIfPlayerCanSeeTheTarget(
      Player player, double dxTarget, double dyTarget) {
    Offset targetOffset = Offset(dxTarget, dyTarget);
    Offset selectedPlayerOffset = Offset(player.dx, player.dy);
    double distance = (targetOffset - selectedPlayerOffset).distance;

    if (distance <= player.vision / 2) {
      return true;
    } else {
      return false;
    }
  }
}
