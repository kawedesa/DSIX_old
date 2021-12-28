import 'package:dsixv02app/models/game/game.dart';
import 'package:dsixv02app/shared/app_Images.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class MapTile extends StatelessWidget {
  MapTile({Key? key});
  @override
  Widget build(BuildContext context) {
    final game = Provider.of<Game>(context);
    List<Widget>? layers = [];

    switch (game.map!.name) {
      case 'ruins':
        layers = AppImages.ruins;
        break;
    }

    return Stack(
      children: layers,
    );
  }
}





//THIS IS USED IN CASE I NEED TO SEE THE TALL GRASS AREA

// // ignore: must_be_immutable
// class TallGrassTEMP extends StatelessWidget {
//   TallGrassArea? tallgrass;

//   TallGrassTEMP({Key? key, @required this.tallgrass}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return CustomPaint(
//       painter: TallGrassTEMPPaintArea(tallGrass: tallgrass!.totalArea),
//     );
//   }
// }

// class TallGrassTEMPPaintArea extends CustomPainter {
//   List<Area>? tallGrass;

//   TallGrassTEMPPaintArea({
//     List<Area>? tallGrass,
//   }) {
//     this.tallGrass = tallGrass;
//   }

//   @override
//   void paint(Canvas canvas, Size size) {
//     final fillColor = Paint()..color = AppColors.fogArea;
//     tallGrass!.forEach((area) {
//       canvas.drawPath(
//         Path()..addPolygon(area.toPoly(), true),
//         fillColor,
//       );
//     });
//   }

//   @override
//   bool shouldRepaint(CustomPainter oldDelegate) {
//     return false;
//   }
// }
