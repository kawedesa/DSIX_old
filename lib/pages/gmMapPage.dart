import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:dsixv02app/models/dsix/dsix.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:dsixv02app/models/gm/draw/drawing_page.dart';

class GmMapPage extends StatefulWidget {
  final Function(String) alert;
  final Function() refresh;
  final Dsix dsix;

  GmMapPage({Key key, this.dsix, this.refresh, this.alert}) : super(key: key);

  static const String routeName = "/gmMapPage";

  @override
  _GmMapPageState createState() => new _GmMapPageState();
}

class _GmMapPageState extends State<GmMapPage> {
  TransformationController interactiveViewerController =
      TransformationController();

  @override
  void initState() {
    super.initState();
    interactiveViewerController.value.multiply(
        Matrix4(0.73, 0, 0, 0, 0, 0.73, 0, 0, 0, 0, 0.73, 0, 0, 0, 0, 1));

    interactiveViewerController.value
        .add(Matrix4(0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -20, 0, 0, 0));
  }

  Widget buildStrokeToolbar() {
    return Positioned(
      top: 300,
      right: 20.0,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [],
      ),
    );
  }

  Widget buildStrokeButton(double strokeWidth) {
    return GestureDetector(
      onTap: () {
        setState(() {
          widget.dsix.gm.drawingCanvas.selectedWidth = strokeWidth;
        });
      },
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: Container(
          width: strokeWidth * 2,
          height: strokeWidth * 2,
          decoration: BoxDecoration(
              color: widget.dsix.gm.drawingCanvas.selectedColor,
              borderRadius: BorderRadius.circular(50.0)),
        ),
      ),
    );
  }

  Widget buildClearButton() {
    return GestureDetector(
      onTap: () {
        setState(() {
          widget.dsix.gm.drawingCanvas = DrawingPage(
            canvasSize: 640,
            selectedColor: Colors.black,
            selectedWidth: 5.0,
            lines: [],
            line: null,
          );
        });
      },
      child: CircleAvatar(
        backgroundColor: Colors.grey[700],
        child: Icon(
          Icons.create,
          size: 20.0,
          color: Colors.white,
        ),
      ),
    );
  }

  Widget buildColorToolbar() {
    return Positioned(
      top: 40.0,
      right: 10.0,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          buildClearButton(),

          Divider(
            height: 20.0,
          ),
          // buildColorButton(Colors.red),
          buildColorButton(Colors.blueAccent),
          buildColorButton(Colors.deepOrange),
          // buildColorButton(Colors.green),
          // buildColorButton(Colors.lightBlue),
          buildColorButton(Colors.black),
          buildColorButton(Colors.white),
          Divider(
            height: 20.0,
          ),
          buildStrokeButton(5.0),
          buildStrokeButton(10.0),
          buildStrokeButton(15.0),
        ],
      ),
    );
  }

  Widget buildColorButton(Color color) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: FloatingActionButton(
        mini: true,
        backgroundColor: color,
        child: Container(),
        onPressed: () {
          setState(() {
            widget.dsix.gm.drawingCanvas.selectedColor = color;
          });
        },
      ),
    );
  }

  Widget buildCharacterToolbar() {
    return Positioned(
      top: 40.0,
      left: 10.0,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          buildCharacterButton(Colors.blueAccent),

          // buildColorButton(Colors.red),
          buildColorButton(Colors.blueAccent),
          buildColorButton(Colors.deepOrange),
        ],
      ),
    );
  }

  Widget buildCharacterButton(Color color) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: FloatingActionButton(
        mini: true,
        backgroundColor: color,
        child: Container(),
        onPressed: () {
          setState(() {
            widget.dsix.gm.drawingCanvas.selectedColor = color;
          });
        },
      ),
    );
  }

  //

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Container(
          height: MediaQuery.of(context).size.height * 0.1,
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(7, 0, 0, 0),
                child: IconButton(
                    icon: Icon(
                      Icons.alarm,
                      color: Colors.grey[400],
                      size: 30,
                    ),
                    onPressed: () {
                      setState(() {
                        widget.dsix.gm.addGmTurn();
                      });
                    }),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                  child: ListView.separated(
                    shrinkWrap: true,
                    physics: ScrollPhysics(),
                    scrollDirection: Axis.horizontal,
                    padding: const EdgeInsets.fromLTRB(13, 0, 0, 0),
                    itemCount: widget.dsix.gm.turnOrder.length,
                    itemBuilder: (BuildContext context, int index) {
                      return GestureDetector(
                        onLongPress: () {
                          setState(() {
                            widget.dsix.gm.removeTurn(index);
                          });
                        },
                        onDoubleTap: () {
                          setState(() {
                            widget.dsix.gm.nextTurn();
                          });
                        },
                        onTap: () {
                          setState(() {
                            widget.dsix.gm.chooseTurn(index);
                          });
                        },
                        child: Container(
                          height: 35,
                          width: 35,
                          // color: Colors.amber,
                          child: SvgPicture.asset(
                            'assets/player/race/${widget.dsix.gm.turnOrder[index].icon}.svg',
                            color: widget.dsix.gm.turnOrder[index].primaryColor,
                          ),
                        ),
                      );
                    },
                    separatorBuilder: (BuildContext context, int index) {
                      return SizedBox(
                        width: 5,
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
        Divider(
          height: 0,
          thickness: 2,
          color: Colors.grey[900],
        ),
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * 0.678,
                child: Stack(
                  children: [
                    GestureDetector(
                      onDoubleTap: () {},
                      onDoubleTapDown: (details) {
                        setState(() {
                          // double xTranslation =
                          //     (interactiveViewerController.value.row0[3] /
                          //             interactiveViewerController.value.row0[0])
                          //         .abs();

                          // double yTranslation =
                          //     (interactiveViewerController.value.row1[3] /
                          //             interactiveViewerController.value.row1[1])
                          //         .abs();

                          // Offset spawnLocation = Offset(
                          //     xTranslation +
                          //         details.localPosition.dx /
                          //             interactiveViewerController.value.row0[0],
                          //     yTranslation +
                          //         details.localPosition.dy /
                          //             interactiveViewerController.value.row1[1]);

                          //SPAWN ON DOUBLE TAP <---- COME BACK HERE

                          // widget.dsix.gm.newCharacter(spawnLocation);
                        });
                      },
                      child: InteractiveViewer(
                        transformationController: interactiveViewerController,
                        onInteractionStart: (details) {},
                        onInteractionUpdate: (details) {},
                        onInteractionEnd: (details) {},
                        constrained: false,
                        panEnabled: true,
                        maxScale: 20,
                        minScale: 0.7,
                        child: Stack(
                          children: [
                            widget.dsix.world.mapTile.mapTile,
                            widget.dsix.gm.drawingCanvas,
                            Container(
                              width: widget.dsix.world.mapSize,
                              height: widget.dsix.world.mapSize,
                              child: Stack(
                                children: widget.dsix.gm.displayCharacters,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    buildStrokeToolbar(),
                    buildColorToolbar(),
                    buildCharacterToolbar(),
                  ],
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}
