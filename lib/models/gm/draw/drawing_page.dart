import 'dart:async';

import 'drawn_line.dart';
import 'sketcher.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class DrawingPage extends StatefulWidget {
  final double canvasSize;
  Color selectedColor;
  double selectedWidth;
  List<DrawnLine> lines;
  DrawnLine line;

  DrawingPage({
    Key key,
    this.canvasSize,
    this.selectedColor,
    this.selectedWidth,
    this.lines,
    this.line,
  }) : super(key: key);

  @override
  _DrawingPageState createState() => _DrawingPageState();
}

class _DrawingPageState extends State<DrawingPage> {
  GlobalKey _globalKey = new GlobalKey();

  StreamController<List<DrawnLine>> linesStreamController =
      StreamController<List<DrawnLine>>.broadcast();
  StreamController<DrawnLine> currentLineStreamController =
      StreamController<DrawnLine>.broadcast();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.canvasSize,
      height: widget.canvasSize,
      child: Stack(
        children: [
          buildAllPaths(context),
          buildCurrentPath(context),
        ],
      ),
    );
  }

  Widget buildCurrentPath(BuildContext context) {
    return GestureDetector(
      onLongPressStart: onPanStart,
      onLongPressMoveUpdate: onPanUpdate,
      onLongPressEnd: onPanEnd,
      child: RepaintBoundary(
        child: Container(
          width: widget.canvasSize,
          height: widget.canvasSize,
          padding: EdgeInsets.all(4.0),
          color: Colors.transparent,
          alignment: Alignment.topLeft,
          child: StreamBuilder<DrawnLine>(
            stream: currentLineStreamController.stream,
            builder: (context, snapshot) {
              return CustomPaint(
                painter: Sketcher(
                  lines: [widget.line],
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  Widget buildAllPaths(BuildContext context) {
    return RepaintBoundary(
      key: _globalKey,
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        color: Colors.transparent,
        padding: EdgeInsets.all(4.0),
        alignment: Alignment.topLeft,
        child: StreamBuilder<List<DrawnLine>>(
          stream: linesStreamController.stream,
          builder: (context, snapshot) {
            return CustomPaint(
              painter: Sketcher(
                lines: widget.lines,
              ),
            );
          },
        ),
      ),
    );
  }

  void onPanStart(LongPressStartDetails details) {
    RenderBox box = context.findRenderObject();
    Offset point = box.globalToLocal(details.globalPosition);
    widget.line =
        DrawnLine([point], widget.selectedColor, widget.selectedWidth);
  }

  void onPanUpdate(LongPressMoveUpdateDetails details) {
    RenderBox box = context.findRenderObject();
    Offset point = box.globalToLocal(details.globalPosition);

    List<Offset> path = List.from(widget.line.path)..add(point);
    widget.line = DrawnLine(path, widget.selectedColor, widget.selectedWidth);
    currentLineStreamController.add(widget.line);
  }

  void onPanEnd(LongPressEndDetails details) {
    widget.lines = List.from(widget.lines)..add(widget.line);

    linesStreamController.add(widget.lines);
  }
}
