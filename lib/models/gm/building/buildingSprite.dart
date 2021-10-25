// ignore_for_file: must_be_immutable

import 'package:dsixv02app/core/app_colors.dart';
import 'package:flutter/material.dart';

class BuildingSprite extends StatefulWidget {
  BuildingSprite({
    @required this.layers,
    @required this.size,
    this.location,
    this.delete,
  });

  final List<Widget> layers;
  double size;
  Offset location;
  bool drag = true;
  Function() delete;

  @override
  State<BuildingSprite> createState() => _BuildingSpriteState();
}

class _BuildingSpriteState extends State<BuildingSprite> {
  @override
  Widget build(BuildContext context) {
    if (widget.location == null) {
      widget.location = Offset(0, 0);
    }

    return Positioned(
      left: widget.location.dx,
      top: widget.location.dy,
      child: (widget.drag)
          ? GestureDetector(
              onDoubleTap: () {
                setState(() {
                  widget.delete();
                });
              },
              // onDoubleTap: () {
              //   setState(() {
              //     widget.drag = false;
              //   });
              // },
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
                color: AppColors.selected,
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: AppColors.grey_01,
                      width: 0.5, //                   <--- border width here
                    ),
                  ),
                  child: Stack(
                    children: widget.layers,
                  ),
                ),
              ),
            )
          : GestureDetector(
              // onDoubleTap: () {
              //   setState(() {
              //     widget.drag = true;
              //   });
              // },
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
