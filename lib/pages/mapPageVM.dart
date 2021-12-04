import 'package:flutter/material.dart';

class MapPageVM {
  TransformationController canvasController;
  double minZoom = 4;
  double maxZoom = 15;

  void setCanvasController(context, double dx, double dy) {
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
}
