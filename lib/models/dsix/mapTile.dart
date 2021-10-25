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
import 'package:flutter/material.dart';

class MapTile extends StatelessWidget {
  const MapTile({
    @required this.layers,
    @required this.size,
  });

  final List<Widget> layers;
  final double size;

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
