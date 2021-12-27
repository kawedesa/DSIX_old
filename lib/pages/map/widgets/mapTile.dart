import 'package:dsixv02app/models/game/game.dart';
import 'package:dsixv02app/shared/app_Colors.dart';
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
      children: [
        Stack(
          children: layers,
        ),
        TallGrassTEMP(tallgrass: game.map!.tallGrass),
      ],
    );
  }
}

// ignore: must_be_immutable
class TallGrassTEMP extends StatelessWidget {
  TallGrassArea? tallgrass;

  TallGrassTEMP({Key? key, @required this.tallgrass}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // List<Area> totalArea = [
    //   Area(
    //     area: [
    //       Vertex(dx: 100, dy: 120),
    //       Vertex(dx: 125, dy: 90),
    //       Vertex(dx: 150, dy: 120),
    //     ],
    //   ),
    //   Area(
    //     area: [
    //       Vertex(dx: 264, dy: 80),
    //       Vertex(dx: 264, dy: 70),
    //       Vertex(dx: 210, dy: 70),
    //       Vertex(dx: 210, dy: 80),
    //     ],
    //   ),
    //   Area(area: [
    //     Vertex(dx: 230, dy: 200),
    //     Vertex(dx: 230, dy: 184),
    //     Vertex(dx: 208, dy: 184),
    //     Vertex(dx: 208, dy: 200),
    //   ]),
    //   Area(
    //     area: [
    //       Vertex(dx: 320, dy: 193),
    //       Vertex(dx: 275, dy: 213),
    //       Vertex(dx: 275, dy: 278),
    //       Vertex(dx: 235, dy: 278),
    //       Vertex(dx: 215, dy: 320),
    //       Vertex(dx: 320, dy: 320),
    //     ],
    //   ),
    //   Area(
    //     area: [
    //       Vertex(dx: 128, dy: 240),
    //       Vertex(dx: 148, dy: 240),
    //       Vertex(dx: 148, dy: 250),
    //       Vertex(dx: 128, dy: 250),
    //     ],
    //   ),
    //   Area(
    //     area: [
    //       Vertex(dx: 68, dy: 290),
    //       Vertex(dx: 110, dy: 290),
    //       Vertex(dx: 110, dy: 320),
    //       Vertex(dx: 68, dy: 320),
    //     ],
    //   ),
    //   Area(
    //     area: [
    //       Vertex(dx: 45, dy: 220),
    //       Vertex(dx: 0, dy: 200),
    //       Vertex(dx: 0, dy: 320),
    //       Vertex(dx: 45, dy: 320),
    //     ],
    //   ),
    //   Area(
    //     area: [
    //       Vertex(dx: 45, dy: 100),
    //       Vertex(dx: 0, dy: 80),
    //       Vertex(dx: 0, dy: 170),
    //       Vertex(dx: 45, dy: 150),
    //     ],
    //   ),
    // ];

    return CustomPaint(
      painter: TallGrassTEMPPaintArea(tallGrass: tallgrass!.totalArea),
    );
  }
}

class TallGrassTEMPPaintArea extends CustomPainter {
  List<Area>? tallGrass;

  TallGrassTEMPPaintArea({
    List<Area>? tallGrass,
  }) {
    this.tallGrass = tallGrass;
  }

  @override
  void paint(Canvas canvas, Size size) {
    final fillColor = Paint()..color = AppColors.fogArea;
    tallGrass!.forEach((area) {
      canvas.drawPath(
        Path()..addPolygon(area.toPoly(), true),
        fillColor,
      );
    });
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
