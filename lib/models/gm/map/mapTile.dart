// import 'package:flutter/material.dart';

// class Sprite extends StatefulWidget {
//   const Sprite({@required this.layers, @required this.size});

//   final List<Widget> layers;
//   final double size;

//   @override
//   State<Sprite> createState() => _SpriteState();
// }

// class _SpriteState extends State<Sprite> {
//   Offset location;

//   @override
//   Widget build(BuildContext context) {
//     if (this.location == null) {
//       this.location = Offset(320, 320);
//     }
//     return Positioned(
//       top: this.location.dy,
//       left: this.location.dx,
//       child: GestureDetector(
//         onPanUpdate: (offset) {
//           setState(() {
//             location = Offset(
//                 location.dx + offset.delta.dx, location.dy + offset.delta.dy);
//           });
//         },
//         child: Container(
//           width: widget.size,
//           height: widget.size,
//           child: Stack(
//             children: widget.layers,
//           ),
//         ),
//       ),
//     );
//   }
// }
import 'package:dsixv02app/models/gm/character/character.dart';
import 'package:flutter/material.dart';

class MapTile extends StatelessWidget {
  const MapTile({
    @required this.name,
    @required this.layers,
    @required this.availableCharacters,
    @required this.size,
  });

  final String name;
  final List<Widget> layers;
  final List<Character> availableCharacters;
  final double size;

  MapTile copy() {
    MapTile newMapTile = MapTile(
        name: this.name,
        layers: this.layers,
        availableCharacters: this.availableCharacters,
        size: this.size);

    return newMapTile;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: this.size,
      height: this.size,
      child: Stack(
        children: this.layers,
      ),
    );
  }
}
