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

  Widget gameCreationAction(int step) {
    switch (step) {
      case 0:
        return InstructionMenu(
          instruction: (widget.dsix.gm.buildings.isEmpty)
              ? _gmMapPageVM.instructions[0]
              : _gmMapPageVM.instructions[1],
          subTitle: 'xp left: ${widget.dsix.gm.currentXp}',
          ready: (widget.dsix.gm.currentXp > 0) ? false : true,
          nextStep: () {
            setState(() {
              widget.dsix.gm.spawnCharacters();
            });
          },
          action: () async {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return BuildingDialog(
                    gm: widget.dsix.gm,
                    refresh: () async {
                      refreshMap();
                    });
              },
            ).then((_) => setState(() {}));
          },
        );
        break;
      case 1:
        return InstructionMenu(
          instruction: _gmMapPageVM.instructions[2],
          ready: true,
          nextStep: () {
            setState(() {});
          },
        );
        break;
      case 3:
        break;
      case 4:
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    _gmMapPageVM.interactiveViewerController = TransformationController(Matrix4(
        3,
        0,
        0,
        0,
        0,
        3,
        0,
        0,
        0,
        0,
        3,
        0,
        -widget.dsix.gm.startLocation.dx,
        -widget.dsix.gm.startLocation.dy,
        0,
        1));

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        // (widget.dsix.gm.gameCreationStep > 5)
        //     ? Container(
        //         height: MediaQuery.of(context).size.height * 0.1,
        //         // child: Row(
        //         //   children: [
        //         //     Padding(
        //         //       padding: const EdgeInsets.fromLTRB(7, 0, 0, 0),
        //         //       child: GestureDetector(
        //         //         onLongPress: () {
        //         //           setState(() {
        //         //             widget.dsix.gm.shuffleTurn();
        //         //           });
        //         //         },
        //         //         child: IconButton(
        //         //             icon: Icon(
        //         //               Icons.alarm,
        //         //               color: Colors.grey[400],
        //         //               size: 30,
        //         //             ),
        //         //             onPressed: () {
        //         //               setState(() {
        //         //                 widget.dsix.gm.addGmTurn();
        //         //               });
        //         //             }),
        //         //       ),
        //         //     ),
        //         //     Expanded(
        //         //       child: Padding(
        //         //         padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
        //         //         child: ListView.separated(
        //         //           shrinkWrap: true,
        //         //           physics: ScrollPhysics(),
        //         //           scrollDirection: Axis.horizontal,
        //         //           padding: const EdgeInsets.fromLTRB(13, 0, 0, 0),
        //         //           itemCount: widget.dsix.gm.turnOrder.length,
        //         //           itemBuilder: (BuildContext context, int index) {
        //         //             return GestureDetector(
        //         //               onLongPress: () {
        //         //                 setState(() {
        //         //                   widget.dsix.gm.removeTurn(index);
        //         //                 });
        //         //               },
        //         //               onDoubleTap: () {
        //         //                 setState(() {
        //         //                   widget.dsix.gm.chooseTurn(index);
        //         //                 });
        //         //               },
        //         //               onTap: () {
        //         //                 setState(() {
        //         //                   goToPlayer(
        //         //                       widget.dsix.gm.turnOrder[index].primaryColor);
        //         //                 });
        //         //               },
        //         //               child: Container(
        //         //                 height: 35,
        //         //                 width: 35,
        //         //                 // color: Colors.amber,
        //         //                 child: SvgPicture.asset(
        //         //                   'assets/player/race/${widget.dsix.gm.turnOrder[index].icon}.svg',
        //         //                   color: widget.dsix.gm.turnOrder[index].primaryColor,
        //         //                 ),
        //         //               ),
        //         //             );
        //         //           },
        //         //           separatorBuilder: (BuildContext context, int index) {
        //         //             return SizedBox(
        //         //               width: 5,
        //         //             );
        //         //           },
        //         //         ),
        //         //       ),
        //         //     ),
        //         //   ],
        //         // ),
        //       )
        //     : Container(),
        // Divider(
        //   height: 0,
        //   thickness: 2,
        //   color: Colors.grey[700],
        // ),
        Expanded(
          child: Container(
            width: MediaQuery.of(context).size.width,
            child: Stack(
              children: [
                InteractiveViewer(
                  transformationController:
                      _gmMapPageVM.interactiveViewerController,
                  constrained: false,
                  panEnabled: true,
                  maxScale: 20,
                  minScale: 0.7,
                  child: Stack(
                    children: widget.dsix.gm.canvas,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 25),
                  child: Container(
                    width: double.infinity,
                    child: gameCreationAction(widget.dsix.gm.gameCreationStep),
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
