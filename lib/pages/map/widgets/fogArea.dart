import 'package:dsixv02app/shared/app_Colors.dart';
import 'package:flutter/material.dart';

class FogArea extends CustomPainter {
  double? minRange;
  double? maxRange;

  FogArea({double? minRange, double? maxRange}) {
    this.minRange = minRange;
    this.maxRange = maxRange;
  }

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(minRange! / 2, minRange! / 2);

    final fillColor = Paint()..color = AppColors.fogArea;

    canvas.drawPath(
      Path.combine(
        PathOperation.difference,
        Path()
          ..addOval(
              Rect.fromCircle(center: center, radius: maxRange! / 2 + 0.02)),
        Path()
          ..addOval(
              Rect.fromCircle(center: center, radius: minRange! / 2 + 0.01))
          ..close(),
      ),
      fillColor,
    );

    final strokeColor = Paint()
      ..color = AppColors.fogArea
      ..strokeWidth = 0.5
      ..style = PaintingStyle.stroke;

    canvas.drawPath(
      Path.combine(
        PathOperation.difference,
        Path()
          ..addOval(
              Rect.fromCircle(center: center, radius: maxRange! / 2 + 0.02)),
        Path()
          ..addOval(
              Rect.fromCircle(center: center, radius: minRange! / 2 + 0.01))
          ..close(),
      ),
      strokeColor,
    );
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
