// ignore_for_file: must_be_immutable
import 'package:flutter/material.dart';

class EnemySprite extends StatefulWidget {
  EnemySprite({
    this.image,
    @required this.size,
    @required this.location,
  });

  List<Widget> image;
  final double size;
  Offset location;

  @override
  State<EnemySprite> createState() => _EnemySpriteState();
}

class _EnemySpriteState extends State<EnemySprite> {
  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: widget.location.dx,
      top: widget.location.dy,
      child: GestureDetector(
        child: Container(
          width: widget.size,
          height: widget.size,
          child: Stack(
            children: widget.image,
          ),
        ),
      ),
    );
  }
}
