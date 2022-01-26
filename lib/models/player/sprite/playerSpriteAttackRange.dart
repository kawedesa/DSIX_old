import 'package:dsixv02app/shared/app_Colors.dart';
import 'package:flutter/material.dart';
import '../player.dart';

// ignore: must_be_immutable
class AttackRange extends StatelessWidget {
  Player? player;
  AttackRange({
    Key? key,
    @required this.player,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double minRange =
        player!.equipment!.attackRange!.setMinRange(player!.mode!);
    double maxRange = player!.equipment!.attackRange!
        .setMaxRange(player!.mode!, player!.vision!.vision!);

    return CustomPaint(
      painter: AttackArea(
        minRange: minRange,
        maxRange: maxRange,
      ),
      child: SizedBox(
        width: maxRange,
        height: maxRange,
      ),
    );
  }
}

class AttackArea extends CustomPainter {
  double? minRange;
  double? maxRange;

  AttackArea({double? minRange, double? maxRange}) {
    this.minRange = minRange;
    this.maxRange = maxRange;
  }

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(maxRange! / 2, maxRange! / 2);

    final fillColor = Paint()..color = AppColors.attackRangeArea;

    canvas.drawPath(
      Path.combine(
        PathOperation.difference,
        Path()..addOval(Rect.fromCircle(center: center, radius: maxRange! / 2)),
        Path()
          ..addOval(Rect.fromCircle(center: center, radius: minRange! / 2))
          ..close(),
      ),
      fillColor,
    );

    final strokeColor = Paint()
      ..color = AppColors.attackRangeOutline
      ..strokeWidth = 0.5
      ..style = PaintingStyle.stroke;

    canvas.drawPath(
      Path.combine(
        PathOperation.difference,
        Path()..addOval(Rect.fromCircle(center: center, radius: maxRange! / 2)),
        Path()
          ..addOval(Rect.fromCircle(center: center, radius: minRange! / 2))
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
