// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

class Sprite extends StatefulWidget {
  Sprite({
    @required this.layers,
    @required this.size,
    this.location,
  });

  final List<Widget> layers;
  final double size;
  Offset location;

  @override
  State<Sprite> createState() => _SpriteState();
}

class _SpriteState extends State<Sprite> {
  @override
  Widget build(BuildContext context) {
    if (widget.location == null) {
      widget.location = Offset(0, 0);
    }

    return Positioned(
      left: widget.location.dx,
      top: widget.location.dy,
      child: GestureDetector(
        onPanEnd: (details) {
          setState(() {
            widget.location = Offset(
              (widget.location.dx / 2).roundToDouble() * 2,
              (widget.location.dy / 2).roundToDouble() * 2,
            );
          });
        },
        onPanUpdate: (details) {
          double dx = details.delta.dx;
          double dy = details.delta.dy;
          setState(() {
            widget.location =
                Offset(widget.location.dx + dx, widget.location.dy + dy);
          });
        },
        child: Container(
          width: widget.size,
          height: widget.size,
          child: Stack(
            children: widget.layers,
          ),
        ),
      ),
    );
  }
}

// class Sprite extends StatelessWidget {
//   const Sprite(
//       {@required this.layers,
//       @required this.size,
//       this.location,
//       this.updateLocation});

//   final List<Widget> layers;
//   final double size;
//   final Offset location;
//   final Function(DragUpdateDetails) updateLocation;

//   @override
//   Widget build(BuildContext context) {
//     return Positioned(
//       top: this.location.dy,
//       left: this.location.dx,
//       child: GestureDetector(
//         onPanUpdate: (offset) {
//           updateLocation(offset);
//         },
//         child: Container(
//           width: this.size,
//           height: this.size,
//           child: Stack(
//             children: this.layers,
//           ),
//         ),
//       ),
//     );
//   }
// }
