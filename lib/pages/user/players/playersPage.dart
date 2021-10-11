import 'package:dsixv02app/core/app_colors.dart';
import 'package:dsixv02app/core/app_text_styles.dart';
import 'package:dsixv02app/widgets/buttons/button.dart';
import 'package:dsixv02app/widgets/dialogs/confirmDialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:dsixv02app/models/dsix/dsix.dart';
import 'playersPageVM.dart';

class PlayersPage extends StatefulWidget {
  final Dsix dsix;

  const PlayersPage({Key key, this.dsix}) : super(key: key);

  static const String routeName = "/playersPage";

  @override
  _PlayersPageState createState() => new _PlayersPageState();
}

class _PlayersPageState extends State<PlayersPage> {
  PlayersPageVM playersPageVM = PlayersPageVM();

  Widget build(BuildContext context) {
    return new Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        titleSpacing: 0,
        backgroundColor: AppColors.neutral00,
        centerTitle: true,
        title: new Text(
          'choose your player'.toUpperCase(),
          textAlign: TextAlign.center,
          style: AppTextStyles.neutralTitle,
        ),
      ),
      body: new SafeArea(
        child: Center(
          child: Container(
            width: MediaQuery.of(context).size.width * 0.65,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ListView.builder(
                  shrinkWrap: true,
                  padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                  itemCount: widget.dsix.players.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Padding(
                      padding: const EdgeInsets.fromLTRB(0, 0, 0, 5),
                      child: Button(
                        buttonText: '${widget.dsix.players[index].name}',
                        buttonIcon: 'right',
                        buttonTextColor:
                            widget.dsix.players[index].primaryColor,
                        buttonColor: widget.dsix.players[index].primaryColor,
                        onLongPressAction: () async {
                          widget.dsix.setCurrentPlayer(index);

                          if (widget.dsix.getCurrentPlayer().playerCreated) {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return ConfirmDialog(
                                    player: widget.dsix.getCurrentPlayer(),
                                    color: widget.dsix
                                        .getCurrentPlayer()
                                        .primaryColor,
                                    confirm: () async {
                                      playersPageVM.deletePlayer(
                                          widget.dsix, index);
                                    });
                              },
                            ).then((_) => setState(() {}));
                          } else {
                            setState(() {
                              playersPageVM.createRandomPlayer(
                                  widget.dsix.getCurrentPlayer(), index);
                            });
                          }
                        },
                        onTapAction: () async {
                          widget.dsix.setCurrentPlayer(index);

                          setState(() {
                            playersPageVM.checkCharacter(
                                context, widget.dsix, index);
                          });
                        },
                      ),
                    );
                  },
                ),
                Button(
                  buttonText: 'gm',
                  buttonIcon: 'right',
                ),

                // GestureDetector(
                //   onLongPress: () {
                //     setState(() {
                //       showAlertDialogDeleteStory(context);
                //     });
                //   },
                //   onTap: () {
                //     Navigator.of(context).push(_createRouteGmUI());
                //   },
                //   child: Container(
                //     height: MediaQuery.of(context).size.height * 0.1,
                //     width: MediaQuery.of(context).size.width * 0.65,
                //     decoration: BoxDecoration(
                //       border: Border.all(
                //         color: Colors.grey[600],
                //         width: 2.5, //                   <--- border width here
                //       ),
                //     ),
                //     child: Stack(
                //       alignment: AlignmentDirectional.centerEnd,
                //       children: [
                //         Column(
                //           mainAxisAlignment: MainAxisAlignment.center,
                //           crossAxisAlignment: CrossAxisAlignment.start,
                //           children: <Widget>[
                //             Padding(
                //               padding: const EdgeInsets.fromLTRB(0, 0, 15, 0),
                //               child: Icon(
                //                 Icons.keyboard_arrow_right,
                //                 color: Colors.grey[600],
                //                 size: 30,
                //               ),
                //             ),
                //           ],
                //         ),
                //         Padding(
                //           padding: const EdgeInsets.fromLTRB(0, 8, 0, 8),
                //           child: Center(
                //             child: Text(
                //               'GM',
                //               style: TextStyle(
                //                 fontSize: 15,
                //                 fontWeight: FontWeight.bold,
                //                 letterSpacing: 1.5,
                //                 fontFamily: 'Calibri',
                //                 color: Colors.grey[600],
                //               ),
                //             ),
                //           ),
                //         ),
                //       ],
                //     ),
                //   ),
                // ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
