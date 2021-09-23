import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Sprite extends StatefulWidget {
  final double canvasSize;
  String icon;
  Color color;
  double size;

  Offset location;

  Sprite({
    Key key,
    this.icon,
    this.color,
    this.size,
    this.canvasSize,
    this.location,
  }) : super(key: key);

  @override
  _SpriteState createState() => _SpriteState();
}

class _SpriteState extends State<Sprite> {
  void deleteMe() {
    widget.size = 0;
  }

  @override
  Widget build(BuildContext context) {
    if (widget.location.dx > widget.canvasSize - widget.size) {
      widget.location =
          Offset(widget.canvasSize - widget.size, widget.location.dy);
    }
    if (widget.location.dx < 0) {
      widget.location = Offset(0, widget.location.dy);
    }
    if (widget.location.dy > widget.canvasSize - widget.size) {
      widget.location =
          Offset(widget.location.dx, widget.canvasSize - widget.size);
    }
    if (widget.location.dy < 0) {
      widget.location = Offset(widget.location.dx, 0);
    }

    return Stack(
      children: <Widget>[
        Positioned(
          left: widget.location.dx,
          top: widget.location.dy,
          child: GestureDetector(
            onLongPress: () {
              setState(() {
                deleteMe();
              });
            },
            onPanUpdate: (details) {
              setState(() {
                widget.location = Offset(widget.location.dx + details.delta.dx,
                    widget.location.dy + details.delta.dy);
              });
            },
            child: Container(
              width: widget.size,
              height: widget.size,
              child: SvgPicture.asset(
                'assets/races/${widget.icon}.svg',
                color: widget.color,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
