import 'dart:async';
// import 'dart:typed_data';
// import 'dart:ui' as ui;

import 'drawn_line.dart';
import 'sketcher.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
// import 'package:flutter/services.dart';

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

  // Future<void> save() async {
  //   try {
  //     RenderRepaintBoundary boundary = _globalKey.currentContext.findRenderObject() as RenderRepaintBoundary;
  //     ui.Image image = await boundary.toImage();
  //     ByteData byteData = await image.toByteData(format: ui.ImageByteFormat.png);
  //     Uint8List pngBytes = byteData.buffer.asUint8List();
  //     var saved = await ImageGallerySaver.saveImage(
  //       pngBytes,
  //       quality: 100,
  //       name: DateTime.now().toIso8601String() + ".png",
  //       isReturnImagePathOfIOS: true,
  //     );
  //     print(saved);
  //   } catch (e) {
  //     print(e);
  //   }
  // }

  // Future<void> clear() async {
  //   setState(() {
  //     lines = [];
  //     line = null;
  //   });
  // }

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

  // Widget buildStrokeToolbar() {
  //   return Positioned(
  //     top: 40,
  //     right: 80.0,
  //     child: Row(
  //       crossAxisAlignment: CrossAxisAlignment.center,
  //       mainAxisAlignment: MainAxisAlignment.start,
  //       children: [
  //         buildStrokeButton(5.0),
  //         buildStrokeButton(10.0),
  //         buildStrokeButton(15.0),
  //       ],
  //     ),
  //   );
  // }

  // Widget buildStrokeButton(double strokeWidth) {
  //   return GestureDetector(
  //     onTap: () {
  //       setState(() {
  //         widget.selectedWidth = strokeWidth;
  //       });
  //     },
  //     child: Padding(
  //       padding: const EdgeInsets.all(4.0),
  //       child: Container(
  //         width: strokeWidth * 2,
  //         height: strokeWidth * 2,
  //         decoration: BoxDecoration(
  //             color: widget.selectedColor, borderRadius: BorderRadius.circular(50.0)),
  //       ),
  //     ),
  //   );
  // }

  // Widget buildColorToolbar() {
  //   return Positioned(
  //     top: 40.0,
  //     right: 10.0,
  //     child: Column(
  //       crossAxisAlignment: CrossAxisAlignment.center,
  //       mainAxisAlignment: MainAxisAlignment.start,
  //       children: [
  //         buildClearButton(),
  //         // Divider(
  //         //   height: 10.0,
  //         // ),
  //         // buildSaveButton(),
  //         Divider(
  //           height: 20.0,
  //         ),
  //         // buildColorButton(Colors.red),
  //         buildColorButton(Colors.blueAccent),
  //         buildColorButton(Colors.deepOrange),
  //         // buildColorButton(Colors.green),
  //         // buildColorButton(Colors.lightBlue),
  //         buildColorButton(Colors.black),
  //         buildColorButton(Colors.white),
  //       ],
  //     ),
  //   );
  // }

  // Widget buildColorButton(Color color) {
  //   return Padding(
  //     padding: const EdgeInsets.all(4.0),
  //     child: FloatingActionButton(
  //       mini: true,
  //       backgroundColor: color,
  //       child: Container(),
  //       onPressed: () {
  //         setState(() {
  //           widget.selectedColor = color;
  //         });
  //       },
  //     ),
  //   );
  // }

  // Widget buildSaveButton() {
  //   return GestureDetector(
  //     onTap: save,
  //     child: CircleAvatar(
  //       child: Icon(
  //         Icons.save,
  //         size: 20.0,
  //         color: Colors.white,
  //       ),
  //     ),
  //   );
  // }

  // void drawMode() {
  //   if (widget.drawMode) {
  //     widget.drawMode = false;
  //   } else {
  //     widget.drawMode = true;
  //   }
  //   print(widget.drawMode);
  // }

  // Widget buildClearButton() {
  //   return GestureDetector(
  //     onLongPress: clear,
  //     // onTap: () {
  //     //   drawMode();
  //     // },
  //     // onTap: clear,
  //     child: CircleAvatar(
  //       child: Icon(
  //         Icons.create,
  //         size: 20.0,
  //         color: Colors.white,
  //       ),
  //     ),
  //   );
  // }
}
