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

import 'playerMapPageVM.dart';
// import 'package:dsixv02app/models/gm/draw/drawing_page.dart';

class PlayerMapPage extends StatefulWidget {
  final Function(String) alert;
  final Function() refresh;
  final Dsix dsix;

  PlayerMapPage({Key key, this.dsix, this.refresh, this.alert})
      : super(key: key);

  static const String routeName = "/playerMapPage";

  @override
  _PlayerMapPageState createState() => new _PlayerMapPageState();
}

class _PlayerMapPageState extends State<PlayerMapPage> {
  PlayerMapPageVM _playerMapPageVM = PlayerMapPageVM();
  void refresh() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    _playerMapPageVM.setCanvas(
        context, widget.dsix.getCurrentPlayer(), widget.dsix.gm, this.refresh);

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
                            // widget.dsix.gm.shuffleTurn();
                          });
                        },
                        child: IconButton(
                            icon: Icon(
                              Icons.alarm,
                              color:
                                  widget.dsix.getCurrentPlayer().primaryColor,
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
          color: widget.dsix.getCurrentPlayer().primaryColor,
        ),
        Expanded(
          child: Container(
            width: MediaQuery.of(context).size.width,
            child: Stack(
              children: [
                InteractiveViewer(
                  transformationController:
                      widget.dsix.getCurrentPlayer().navigation,
                  constrained: false,
                  panEnabled: true,
                  maxScale: 2,
                  minScale: 2,
                  child: Stack(
                    children: widget.dsix.getCurrentPlayer().canvas,
                  ),
                ),
              ],
            ),
          ),
        )
      ],
    );
  }
}
