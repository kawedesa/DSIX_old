import 'package:dsixv02app/models/game/gameMap/gameMap.dart';
import 'package:dsixv02app/models/game/gameMap/heightMap.dart';
import 'package:dsixv02app/models/game/gameMap/totalArea.dart';

class AppMaps {
  static final ruins = GameMap(
    name: 'ruins',
    size: 320,
    tallGrass: TotalArea(area: [
      //Start with the triangle shape in the middle and start adding the grass areas clockwise
      Area(
        index: 0,
        area: [
          Vertex(dx: 96, dy: 120),
          Vertex(dx: 125, dy: 100),
          Vertex(dx: 140, dy: 100),
          Vertex(dx: 160, dy: 120),
        ],
      ),
      Area(
        index: 1,
        area: [
          Vertex(dx: 264, dy: 84),
          Vertex(dx: 264, dy: 72),
          Vertex(dx: 212, dy: 72),
          Vertex(dx: 208, dy: 80),
          Vertex(dx: 212, dy: 84),
        ],
      ),
      Area(index: 2, area: [
        Vertex(dx: 228, dy: 196),
        Vertex(dx: 232, dy: 192),
        Vertex(dx: 232, dy: 184),
        Vertex(dx: 208, dy: 184),
        Vertex(dx: 208, dy: 196),
      ]),
      Area(
        index: 3,
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
        index: 4,
        area: [
          Vertex(dx: 104, dy: 248),
          Vertex(dx: 108, dy: 240),
          Vertex(dx: 148, dy: 240),
          Vertex(dx: 148, dy: 252),
          Vertex(dx: 108, dy: 252),
        ],
      ),
      Area(
        index: 5,
        area: [
          Vertex(dx: 68, dy: 292),
          Vertex(dx: 108, dy: 292),
          Vertex(dx: 136, dy: 320),
          Vertex(dx: 68, dy: 320),
        ],
      ),
      Area(
        index: 6,
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
        index: 7,
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
    heightMap: HeightMap(layers: [
      HeightMapLayer(
        index: 0,
        layer: TotalArea(area: [
          Area(
            index: 0,
            area: [
              Vertex(dx: 0, dy: 0),
              Vertex(dx: 320, dy: 0),
              Vertex(dx: 320, dy: 12),
              Vertex(dx: 208, dy: 12),
              Vertex(dx: 196, dy: 24),
              Vertex(dx: 196, dy: 112),
              Vertex(dx: 188, dy: 112),
              Vertex(dx: 180, dy: 120),
              Vertex(dx: 88, dy: 120),
              Vertex(dx: 72, dy: 136),
              Vertex(dx: 0, dy: 136),
            ],
          ),
          Area(
            index: 1,
            area: [
              Vertex(dx: 320, dy: 12),
              Vertex(dx: 316, dy: 12),
              Vertex(dx: 316, dy: 164),
              Vertex(dx: 264, dy: 164),
              Vertex(dx: 264, dy: 72),
              Vertex(dx: 196, dy: 72),
              Vertex(dx: 196, dy: 112),
              Vertex(dx: 220, dy: 112),
              Vertex(dx: 220, dy: 184),
              Vertex(dx: 208, dy: 184),
              Vertex(dx: 208, dy: 320),
              Vertex(dx: 320, dy: 320),
            ],
          ),
          Area(
            index: 2,
            area: [
              Vertex(dx: 0, dy: 136),
              Vertex(dx: 72, dy: 136),
              Vertex(dx: 72, dy: 184),
              Vertex(dx: 88, dy: 184),
              Vertex(dx: 88, dy: 240),
              Vertex(dx: 148, dy: 240),
              Vertex(dx: 148, dy: 256),
              Vertex(dx: 208, dy: 256),
              Vertex(dx: 208, dy: 320),
              Vertex(dx: 0, dy: 320),
            ],
          ),
        ]),
      ),
      HeightMapLayer(
        index: 1,
        layer: TotalArea(area: [
          Area(
            index: 0,
            area: [
              Vertex(dx: 268, dy: 136),
              Vertex(dx: 268, dy: 156),
              Vertex(dx: 264, dy: 156),
              Vertex(dx: 264, dy: 164),
              Vertex(dx: 316, dy: 164),
              Vertex(dx: 316, dy: 156),
              Vertex(dx: 312, dy: 156),
              Vertex(dx: 312, dy: 136),
            ],
          ),
          Area(
            index: 1,
            area: [
              Vertex(dx: 196, dy: 72),
              Vertex(dx: 208, dy: 56),
              Vertex(dx: 208, dy: 12),
              Vertex(dx: 196, dy: 24),
            ],
          ),
          Area(
            index: 2,
            area: [
              Vertex(dx: 88, dy: 120),
              Vertex(dx: 72, dy: 136),
              Vertex(dx: 72, dy: 184),
              Vertex(dx: 76, dy: 184),
              Vertex(dx: 76, dy: 180),
              Vertex(dx: 88, dy: 168),
            ],
          ),
          Area(
            index: 3,
            area: [
              Vertex(dx: 208, dy: 248),
              Vertex(dx: 204, dy: 248),
              Vertex(dx: 204, dy: 220),
              Vertex(dx: 152, dy: 220),
              Vertex(dx: 152, dy: 248),
              Vertex(dx: 148, dy: 248),
              Vertex(dx: 148, dy: 256),
              Vertex(dx: 208, dy: 256),
            ],
          ),
        ]),
      ),
      HeightMapLayer(
        index: 2,
        layer: TotalArea(area: [
          Area(
            index: 0,
            area: [
              Vertex(dx: 208, dy: 56),
              Vertex(dx: 208, dy: 12),
              Vertex(dx: 316, dy: 12),
              Vertex(dx: 316, dy: 156),
              Vertex(dx: 312, dy: 156),
              Vertex(dx: 312, dy: 136),
              Vertex(dx: 268, dy: 136),
              Vertex(dx: 268, dy: 156),
              Vertex(dx: 264, dy: 156),
              Vertex(dx: 264, dy: 136),
              Vertex(dx: 264, dy: 56),
            ],
          ),
          Area(
            index: 1,
            area: [
              Vertex(dx: 152, dy: 220),
              Vertex(dx: 152, dy: 248),
              Vertex(dx: 148, dy: 248),
              Vertex(dx: 148, dy: 220),
              Vertex(dx: 88, dy: 220),
              Vertex(dx: 88, dy: 120),
              Vertex(dx: 180, dy: 120),
              Vertex(dx: 180, dy: 152),
              Vertex(dx: 208, dy: 152),
              Vertex(dx: 208, dy: 248),
              Vertex(dx: 204, dy: 248),
              Vertex(dx: 204, dy: 220),
            ],
          ),
        ]),
      ),
      HeightMapLayer(
        index: 3,
        layer: TotalArea(area: [
          Area(
            index: 0,
            area: [
              Vertex(dx: 220, dy: 144),
              Vertex(dx: 220, dy: 112),
              Vertex(dx: 188, dy: 112),
              Vertex(dx: 180, dy: 120),
              Vertex(dx: 180, dy: 152),
              Vertex(dx: 188, dy: 152),
              Vertex(dx: 188, dy: 148),
              Vertex(dx: 192, dy: 144),
            ],
          ),
        ]),
      ),
      HeightMapLayer(
        index: 10,
        layer: TotalArea(area: [
          Area(
            index: 0,
            area: [
              Vertex(dx: 220, dy: 144),
              Vertex(dx: 220, dy: 184),
              Vertex(dx: 208, dy: 184),
              Vertex(dx: 208, dy: 152),
              Vertex(dx: 188, dy: 152),
              Vertex(dx: 188, dy: 148),
              Vertex(dx: 192, dy: 144),
            ],
          ),
          Area(
            index: 1,
            area: [
              Vertex(dx: 264, dy: 72),
              Vertex(dx: 196, dy: 72),
              Vertex(dx: 208, dy: 56),
              Vertex(dx: 264, dy: 56),
            ],
          ),
          Area(
            index: 2,
            area: [
              Vertex(dx: 148, dy: 240),
              Vertex(dx: 148, dy: 220),
              Vertex(dx: 88, dy: 220),
              Vertex(dx: 88, dy: 240),
            ],
          ),
          Area(
            index: 3,
            area: [
              Vertex(dx: 88, dy: 184),
              Vertex(dx: 76, dy: 184),
              Vertex(dx: 76, dy: 180),
              Vertex(dx: 88, dy: 168),
            ],
          ),
        ]),
      ),
    ]),
  );
}
