import 'package:dsixv02app/models/game/gameMap/gameMap.dart';
import 'package:dsixv02app/models/game/gameMap/tallGrassArea.dart';

class AppMaps {
  static final ruins = GameMap(
    name: 'ruins',
    size: 320,
    tallGrass: TallGrassArea(totalArea: [
      //Start with the triangle shape in the middle and start adding the grass areas clockwise
      Area(
        area: [
          Vertex(dx: 96, dy: 120),
          Vertex(dx: 125, dy: 100),
          Vertex(dx: 140, dy: 100),
          Vertex(dx: 160, dy: 120),
        ],
      ),
      Area(
        area: [
          Vertex(dx: 264, dy: 84),
          Vertex(dx: 264, dy: 72),
          Vertex(dx: 212, dy: 72),
          Vertex(dx: 208, dy: 80),
          Vertex(dx: 212, dy: 84),
        ],
      ),
      Area(area: [
        Vertex(dx: 228, dy: 196),
        Vertex(dx: 232, dy: 192),
        Vertex(dx: 232, dy: 184),
        Vertex(dx: 208, dy: 184),
        Vertex(dx: 208, dy: 196),
      ]),
      Area(
        area: [
          Vertex(dx: 320, dy: 186),
          Vertex(dx: 296, dy: 196),
          Vertex(dx: 284, dy: 212),
          Vertex(dx: 284, dy: 220),
          Vertex(dx: 272, dy: 232),
          Vertex(dx: 272, dy: 250),
          Vertex(dx: 280, dy: 256),
          Vertex(dx: 268, dy: 268),
          Vertex(dx: 236, dy: 280),
          Vertex(dx: 215, dy: 320),
          Vertex(dx: 320, dy: 320),
        ],
      ),
      Area(
        area: [
          Vertex(dx: 104, dy: 248),
          Vertex(dx: 108, dy: 240),
          Vertex(dx: 148, dy: 240),
          Vertex(dx: 148, dy: 252),
          Vertex(dx: 108, dy: 252),
        ],
      ),
      Area(
        area: [
          Vertex(dx: 68, dy: 292),
          Vertex(dx: 108, dy: 292),
          Vertex(dx: 136, dy: 320),
          Vertex(dx: 68, dy: 320),
        ],
      ),
      Area(
        area: [
          Vertex(dx: 44, dy: 240),
          Vertex(dx: 40, dy: 232),
          Vertex(dx: 24, dy: 216),
          Vertex(dx: 0, dy: 216),
          Vertex(dx: 0, dy: 320),
          Vertex(dx: 44, dy: 320),
        ],
      ),
      Area(
        area: [
          Vertex(dx: 32, dy: 136),
          Vertex(dx: 56, dy: 136),
          Vertex(dx: 40, dy: 120),
          Vertex(dx: 48, dy: 112),
          Vertex(dx: 40, dy: 104),
          Vertex(dx: 36, dy: 96),
          Vertex(dx: 0, dy: 96),
          Vertex(dx: 0, dy: 168),
          Vertex(dx: 24, dy: 168),
          Vertex(dx: 44, dy: 148),
        ],
      ),
    ]),
  );
}
