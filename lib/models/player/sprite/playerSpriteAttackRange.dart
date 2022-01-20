import 'package:dsixv02app/shared/app_Colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../user.dart';

// ignore: must_be_immutable
class AttackRange extends StatelessWidget {
  AttackRange({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    double setMaxAttackRange(String mode) {
      switch (mode) {
        case 'walk':
          return 0;

        case 'wait':
          return 0;

        case 'menu':
          return 0;

        case 'attack':
          if (user.selectedPlayer!.equipment!.attackRange!.max! >
              user.selectedPlayer!.vision!.getRange()) {
            return user.selectedPlayer!.vision!.getRange();
          } else {
            return user.selectedPlayer!.equipment!.attackRange!.max!;
          }
      }

      return 0.0;
    }

    double setMinAttackRange(String mode) {
      switch (mode) {
        case 'walk':
          return 0;

        case 'wait':
          return 0;

        case 'menu':
          return 0;

        case 'attack':
          return user.selectedPlayer!.equipment!.attackRange!.min!;
      }

      return 0.0;
    }

    return CustomPaint(
      painter: AttackArea(
        minRange: setMinAttackRange(user.playerMode!),
        maxRange: setMaxAttackRange(user.playerMode!),
      ),
      child: SizedBox(
        width: setMaxAttackRange(user.playerMode!),
        height: setMaxAttackRange(user.playerMode!),
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
      ..color = AppColors.attackRangeOutline
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
