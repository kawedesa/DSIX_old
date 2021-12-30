import 'package:dsixv02app/models/game/game.dart';
import 'package:dsixv02app/models/game/gameMap/totalArea.dart';
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
        // TempArea(
        //   totalArea: heightMap.layers![0].layer,
        // ),
      ],
    );
  }
}

//THIS IS USED IN CASE I NEED TO DRAW ON THE MAP

// ignore: must_be_immutable
class TempArea extends StatelessWidget {
  TotalArea? totalArea;

  TempArea({Key? key, @required this.totalArea}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: TallGrassTEMPPaintArea(tallGrass: totalArea!.area),
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



  //BKP COLLIDER FOLLOW STAIRS

  // HeightMap heightMap = HeightMap(layers: [
  //     HeightMapLayer(
  //       index: 0,
  //       layer: TotalArea(area: [
  //         Area(
  //           area: [
  //             Vertex(dx: 0, dy: 0),
  //             Vertex(dx: 320, dy: 0),
  //             Vertex(dx: 320, dy: 12),
  //             Vertex(dx: 208, dy: 12),
  //             Vertex(dx: 208, dy: 16),
  //             Vertex(dx: 204, dy: 16),
  //             Vertex(dx: 204, dy: 20),
  //             Vertex(dx: 200, dy: 20),
  //             Vertex(dx: 200, dy: 24),
  //             Vertex(dx: 196, dy: 24),
  //             Vertex(dx: 196, dy: 112),
  //             Vertex(dx: 188, dy: 112),
  //             // Vertex(dx: 188, dy: 116),
  //             // Vertex(dx: 184, dy: 116),
  //             Vertex(dx: 180, dy: 120),
  //             Vertex(dx: 88, dy: 120),
  //             // Vertex(dx: 88, dy: 124),
  //             // Vertex(dx: 84, dy: 124),
  //             // Vertex(dx: 84, dy: 128),
  //             // Vertex(dx: 80, dy: 128),
  //             // Vertex(dx: 80, dy: 132),
  //             // Vertex(dx: 76, dy: 132),
  //             Vertex(dx: 72, dy: 136),
  //             Vertex(dx: 0, dy: 136),
  //           ],
  //         ),
  //         Area(
  //           area: [
  //             Vertex(dx: 320, dy: 12),
  //             Vertex(dx: 316, dy: 12),
  //             Vertex(dx: 316, dy: 164),
  //             Vertex(dx: 264, dy: 164),
  //             Vertex(dx: 264, dy: 72),
  //             Vertex(dx: 196, dy: 72),
  //             Vertex(dx: 196, dy: 112),
  //             Vertex(dx: 220, dy: 112),
  //             Vertex(dx: 220, dy: 184),
  //             Vertex(dx: 208, dy: 184),
  //             Vertex(dx: 208, dy: 320),
  //             Vertex(dx: 320, dy: 320),
  //           ],
  //         ),
  //         Area(
  //           area: [
  //             Vertex(dx: 0, dy: 136),
  //             Vertex(dx: 72, dy: 136),
  //             Vertex(dx: 72, dy: 184),
  //             Vertex(dx: 88, dy: 184),
  //             Vertex(dx: 88, dy: 240),
  //             Vertex(dx: 148, dy: 240),
  //             Vertex(dx: 148, dy: 256),
  //             Vertex(dx: 208, dy: 256),
  //             Vertex(dx: 208, dy: 320),
  //             Vertex(dx: 0, dy: 320),
  //           ],
  //         ),
  //       ]),
  //     ),
  //     HeightMapLayer(
  //       index: 1,
  //       layer: TotalArea(area: [
  //         Area(
  //           area: [
  //             Vertex(dx: 268, dy: 136),
  //             Vertex(dx: 268, dy: 156),
  //             Vertex(dx: 264, dy: 156),
  //             Vertex(dx: 264, dy: 164),
  //             Vertex(dx: 316, dy: 164),
  //             Vertex(dx: 316, dy: 156),
  //             Vertex(dx: 312, dy: 156),
  //             Vertex(dx: 312, dy: 136),
  //           ],
  //         ),
  //         Area(
  //           area: [
  //             Vertex(dx: 196, dy: 72),
  //             Vertex(dx: 200, dy: 72),
  //             Vertex(dx: 200, dy: 64),
  //             Vertex(dx: 204, dy: 64),
  //             Vertex(dx: 204, dy: 60),
  //             Vertex(dx: 208, dy: 60),
  //             Vertex(dx: 208, dy: 16),
  //             Vertex(dx: 204, dy: 16),
  //             Vertex(dx: 204, dy: 20),
  //             Vertex(dx: 200, dy: 20),
  //             Vertex(dx: 200, dy: 24),
  //             Vertex(dx: 196, dy: 24),
  //           ],
  //         ),
  //         Area(
  //           area: [
  //             Vertex(dx: 88, dy: 124),
  //             Vertex(dx: 84, dy: 124),
  //             Vertex(dx: 84, dy: 128),
  //             Vertex(dx: 80, dy: 128),
  //             Vertex(dx: 80, dy: 132),
  //             Vertex(dx: 76, dy: 132),
  //             Vertex(dx: 76, dy: 136),
  //             Vertex(dx: 72, dy: 136),
  //             Vertex(dx: 72, dy: 184),
  //             Vertex(dx: 76, dy: 184),
  //             Vertex(dx: 76, dy: 176),
  //             Vertex(dx: 80, dy: 176),
  //             Vertex(dx: 80, dy: 172),
  //             Vertex(dx: 84, dy: 172),
  //             Vertex(dx: 84, dy: 168),
  //             Vertex(dx: 88, dy: 168),
  //           ],
  //         ),
  //         Area(
  //           area: [
  //             Vertex(dx: 208, dy: 248),
  //             Vertex(dx: 204, dy: 248),
  //             Vertex(dx: 204, dy: 220),
  //             Vertex(dx: 152, dy: 220),
  //             Vertex(dx: 152, dy: 248),
  //             Vertex(dx: 148, dy: 248),
  //             Vertex(dx: 148, dy: 256),
  //             Vertex(dx: 208, dy: 256),
  //           ],
  //         ),
  //       ]),
  //     ),
  //     HeightMapLayer(
  //       index: 2,
  //       layer: TotalArea(area: [
  //         Area(
  //           area: [
  //             Vertex(dx: 208, dy: 56),
  //             Vertex(dx: 208, dy: 12),
  //             Vertex(dx: 316, dy: 12),
  //             Vertex(dx: 316, dy: 156),
  //             Vertex(dx: 312, dy: 156),
  //             Vertex(dx: 312, dy: 136),
  //             Vertex(dx: 268, dy: 136),
  //             Vertex(dx: 268, dy: 156),
  //             Vertex(dx: 264, dy: 156),
  //             Vertex(dx: 264, dy: 136),
  //             Vertex(dx: 264, dy: 56),
  //           ],
  //         ),
  //         Area(
  //           area: [
  //             Vertex(dx: 152, dy: 220),
  //             Vertex(dx: 152, dy: 248),
  //             Vertex(dx: 148, dy: 248),
  //             Vertex(dx: 148, dy: 220),
  //             Vertex(dx: 88, dy: 220),
  //             Vertex(dx: 88, dy: 120),
  //             Vertex(dx: 184, dy: 120),
  //             Vertex(dx: 184, dy: 152),
  //             Vertex(dx: 208, dy: 152),
  //             Vertex(dx: 208, dy: 248),
  //             Vertex(dx: 204, dy: 248),
  //             Vertex(dx: 204, dy: 220),
  //           ],
  //         ),
  //       ]),
  //     ),
  //     HeightMapLayer(
  //       index: 3,
  //       layer: TotalArea(area: [
  //         Area(
  //           area: [
  //             Vertex(dx: 220, dy: 144),
  //             Vertex(dx: 220, dy: 112),
  //             Vertex(dx: 196, dy: 112),
  //             Vertex(dx: 188, dy: 112),
  //             Vertex(dx: 188, dy: 116),
  //             Vertex(dx: 184, dy: 116),
  //             Vertex(dx: 184, dy: 152),
  //             Vertex(dx: 188, dy: 152),
  //             Vertex(dx: 188, dy: 144),
  //           ],
  //         ),
  //       ]),
  //     ),
  //     HeightMapLayer(
  //       index: 10,
  //       layer: TotalArea(area: [
  //         Area(
  //           area: [
  //             Vertex(dx: 220, dy: 144),
  //             Vertex(dx: 220, dy: 184),
  //             Vertex(dx: 208, dy: 184),
  //             Vertex(dx: 208, dy: 152),
  //             Vertex(dx: 188, dy: 152),
  //             Vertex(dx: 188, dy: 144),
  //           ],
  //         ),
  //         Area(
  //           area: [
  //             Vertex(dx: 264, dy: 72),
  //             Vertex(dx: 200, dy: 72),
  //             Vertex(dx: 200, dy: 64),
  //             Vertex(dx: 204, dy: 64),
  //             Vertex(dx: 204, dy: 60),
  //             Vertex(dx: 208, dy: 60),
  //             Vertex(dx: 208, dy: 56),
  //             Vertex(dx: 264, dy: 56),
  //           ],
  //         ),
  //         Area(
  //           area: [
  //             Vertex(dx: 148, dy: 240),
  //             Vertex(dx: 148, dy: 220),
  //             Vertex(dx: 88, dy: 220),
  //             Vertex(dx: 88, dy: 240),
  //           ],
  //         ),
  //         Area(
  //           area: [
  //             Vertex(dx: 88, dy: 184),
  //             Vertex(dx: 76, dy: 184),
  //             Vertex(dx: 76, dy: 176),
  //             Vertex(dx: 80, dy: 176),
  //             Vertex(dx: 80, dy: 172),
  //             Vertex(dx: 84, dy: 172),
  //             Vertex(dx: 84, dy: 168),
  //             Vertex(dx: 88, dy: 168),
  //           ],
  //         ),
  //       ]),
  //     ),
  //   ]);