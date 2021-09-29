import 'package:dsixv02app/models/gm/draw/drawing_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:dsixv02app/models/dsix/dsix.dart';
import 'package:flutter_svg/flutter_svg.dart';

class PlayerMapPage extends StatefulWidget {
  final Function() refresh;
  final Function(String) alert;
  final Dsix dsix;

  PlayerMapPage({Key key, this.dsix, this.refresh, this.alert})
      : super(key: key);

  static const String routeName = "/playerMapPage";

  @override
  _PlayerMapPageState createState() => new _PlayerMapPageState();
}

class _PlayerMapPageState extends State<PlayerMapPage> {
  TransformationController interactiveViewerController =
      TransformationController();

  @override
  void initState() {
    super.initState();

    //SCALE
    interactiveViewerController.value.multiply(
        Matrix4(2.5, 0, 0, 0, 0, 2.5, 0, 0, 0, 0, 2.5, 0, 0, 0, 0, 1));
    //POSITION

    widget.dsix.gm.displayCharacters.forEach((element) {
      if (element.color ==
          widget.dsix.gm.getCurrentPlayer().playerColor.primaryColor) {
        interactiveViewerController.value.add(Matrix4(
            0,
            0,
            0,
            0,
            0,
            0,
            0,
            0,
            0,
            0,
            0,
            0,
            -element.location.dx * 2.5 + 200,
            -element.location.dy * 2.5 + 200,
            0,
            0));
      }
    });
  }

  void goToPlayer(Color color) {
    widget.dsix.gm.displayCharacters.forEach((element) {
      if (element.color == color) {
        interactiveViewerController.value
            .multiply(Matrix4(0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0));

        interactiveViewerController.value.add(Matrix4(
            2.5,
            0,
            0,
            0,
            0,
            2.5,
            0,
            0,
            0,
            0,
            2.5,
            0,
            -element.location.dx * 2.5 + 200,
            -element.location.dy * 2.5 + 200,
            0,
            1));
      }
    });
  }

  Widget buildColorToolbar() {
    return Positioned(
      top: 40.0,
      right: 10.0,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          buildColorButton(Colors.black),
          buildColorButton(Colors.white),
          buildColorButton(Colors.blueAccent),
          buildColorButton(Colors.deepOrange),
        ],
      ),
    );
  }

  Widget buildColorButton(Color color) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 4, 0, 4),
      child: Container(
        width: 40,
        height: 40,
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
      ),
    );
  }

  Widget buildClearToolbar() {
    return Positioned(
      bottom: 30,
      right: 10.0,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          buildClearButton(),
        ],
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
      child: Padding(
        padding: const EdgeInsets.fromLTRB(0, 4, 0, 4),
        child: CircleAvatar(
          backgroundColor: Colors.grey[900],
          child: Icon(
            Icons.delete,
            size: 20.0,
            color: Colors.grey[300],
          ),
        ),
      ),
    );
  }

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
                      color: widget.dsix.gm
                          .getCurrentPlayer()
                          .playerColor
                          .primaryColor,
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
                            widget.dsix.gm.chooseTurn(index);
                          });
                        },
                        onTap: () {
                          setState(() {
                            goToPlayer(
                                widget.dsix.gm.turnOrder[index].primaryColor);
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
          color: widget.dsix.gm.getCurrentPlayer().playerColor.primaryColor,
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
                      child: InteractiveViewer(
                        transformationController: interactiveViewerController,
                        onInteractionStart: (details) {},
                        onInteractionUpdate: (details) {},
                        onInteractionEnd: (details) {},
                        constrained: false,
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
                    buildColorToolbar(),
                    buildClearToolbar(),
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
