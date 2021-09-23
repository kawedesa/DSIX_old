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
          color: widget.dsix.gm.getCurrentPlayer().playerColor.primaryColor,
        ),
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * 0.678,
                child: GestureDetector(
                  onDoubleTap: () {},
                  onDoubleTapDown: (details) {
                    setState(() {
                      double xTranslation =
                          (interactiveViewerController.value.row0[3] /
                                  interactiveViewerController.value.row0[0])
                              .abs();

                      double yTranslation =
                          (interactiveViewerController.value.row1[3] /
                                  interactiveViewerController.value.row1[1])
                              .abs();

                      Offset spawnLocation = Offset(
                          xTranslation +
                              details.localPosition.dx /
                                  interactiveViewerController.value.row0[0],
                          yTranslation +
                              details.localPosition.dy /
                                  interactiveViewerController.value.row1[1]);

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
                    maxScale: 20,
                    minScale: 0.7,
                    child: Stack(
                      children: [
                        widget.dsix.world.mapTile.mapTile,
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
              ),
            ],
          ),
        )
      ],
    );
  }
}
