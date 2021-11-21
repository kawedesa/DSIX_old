import 'package:dsixv02app/core/app_colors.dart';
import 'package:dsixv02app/core/app_images.dart';

import 'package:dsixv02app/pages/gm/map/gmMapPageVM.dart';
import 'package:dsixv02app/pages/gm/map/instructionMenu.dart';
import 'package:dsixv02app/widgets/description.dart';
import 'package:dsixv02app/widgets/dialogs/buildingDialog.dart';
import 'package:dsixv02app/widgets/subTitle.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:dsixv02app/models/dsix/dsix.dart';
import 'package:flutter_svg/flutter_svg.dart';
// import 'package:dsixv02app/models/gm/draw/drawing_page.dart';

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
  GmMapPageVM _gmMapPageVM = GmMapPageVM();
  void refreshMap() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        (widget.dsix.gm.turnOrder.isNotEmpty)
            ? Container(
                height: MediaQuery.of(context).size.height * 0.1,
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(7, 0, 0, 0),
                      child: GestureDetector(
                        onLongPress: () {
                          setState(() {
                            widget.dsix.gm.turnOrder.shuffle();
                          });
                        },
                        child: IconButton(
                            icon: Icon(
                              Icons.alarm,
                              color: Colors.grey[400],
                              size: 30,
                            ),
                            onPressed: () {
                              setState(() {
                                // widget.dsix.gm.addGmTurn();
                              });
                            }),
                      ),
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
                                  // widget.dsix.gm.removeTurn(index);
                                });
                              },
                              onDoubleTap: () {
                                setState(() {
                                  // widget.dsix.gm.chooseTurn(index);
                                });
                              },
                              onTap: () {
                                // setState(() {
                                //   goToPlayer(
                                //       widget.dsix.gm.turnOrder[index].primaryColor);
                                // });
                              },
                              child: Container(
                                  width: 40,
                                  child: widget.dsix.gm.turnOrder[index]),
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
              )
            : Container(),
        Divider(
          height: 0,
          thickness: 2,
          color: Colors.grey[700],
        ),
        Expanded(
          child: Container(
            width: MediaQuery.of(context).size.width,
            child: Stack(
              children: [
                InteractiveViewer(
                  transformationController: widget.dsix.gm.navigation,
                  constrained: false,
                  panEnabled: true,
                  maxScale: 20,
                  minScale: 0.7,
                  child: Stack(
                    children: widget.dsix.gm.canvas,
                  ),
                ),
                Positioned(
                  right: 25,
                  top: MediaQuery.of(context).size.height * 0.05,
                  child: (widget.dsix.gm.turnOrder.isNotEmpty)
                      ? Container()
                      : Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.fromLTRB(0, 0, 0, 15),
                              child: Container(
                                width: 40,
                                height: 40,
                                child: FloatingActionButton(
                                  mini: true,
                                  backgroundColor: Colors.green,
                                  child: Container(),
                                  onPressed: () {
                                    setState(() {
                                      _gmMapPageVM.spawnPlayersInRandomLocation(
                                          widget.dsix.players,
                                          widget.dsix.gm,
                                          context);
                                      _gmMapPageVM.startGame(widget.dsix.gm);
                                    });
                                  },
                                ),
                              ),
                            ),
                          ],
                        ),
                ),
                Positioned(
                  right: 25,
                  top: MediaQuery.of(context).size.height * 0.3,
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 0, 0, 15),
                        child: Container(
                          width: 40,
                          height: 40,
                          child: FloatingActionButton(
                            mini: true,
                            backgroundColor: Colors.red,
                            child: Container(),
                            onPressed: () {
                              Scaffold.of(context).openEndDrawer();
                            },
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 0, 0, 15),
                        child: Container(
                          width: 40,
                          height: 40,
                          child: FloatingActionButton(
                            mini: true,
                            backgroundColor: Colors.yellow,
                            child: Container(),
                            onPressed: () {
                              setState(() {
                                _gmMapPageVM.addLoot(widget.dsix.gm, context);
                              });
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Positioned(
                  right: 25,
                  bottom: MediaQuery.of(context).size.height * 0.05,
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 0, 0, 15),
                        child: Container(
                          width: 40,
                          height: 40,
                          child: FloatingActionButton(
                            mini: true,
                            backgroundColor: Colors.grey,
                            child: Container(),
                            onPressed: () {},
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        )
      ],
    );
  }
}
