// ignore_for_file: must_be_immutable

import 'package:dsixv02app/core/app_colors.dart';
import 'package:flutter/material.dart';

class CharacterSprite extends StatefulWidget {
  CharacterSprite({
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
  State<CharacterSprite> createState() => _CharacterSpriteState();
}

class _CharacterSpriteState extends State<CharacterSprite> {
  @override
  Widget build(BuildContext context) {
    if (widget.location == null) {
      widget.location = Offset(0, 0);
    }

    return (widget.drag)
        ? Positioned(
            left: widget.location.dx,
            top: widget.location.dy,
            child: GestureDetector(
              // onDoubleTap: () {
              //   setState(() {
              //     widget.delete();
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
            ),
          )
        : Positioned(
            left: widget.location.dx,
            top: widget.location.dy,
            child: GestureDetector(
              // onDoubleTap: () {
              //   setState(() {
              //     widget.delete();
              //   });
              // },

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
            ),
          );
  }
}
