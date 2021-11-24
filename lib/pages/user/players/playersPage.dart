import 'package:dsixv02app/core/app_colors.dart';
import 'package:dsixv02app/widgets/buttons/button.dart';
import 'package:dsixv02app/widgets/buttons/goBackButton.dart';
import 'package:dsixv02app/widgets/dialogs/confirmDialog.dart';
import 'package:dsixv02app/widgets/pageTitle.dart';
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
        // leadingWidth: MediaQuery.of(context).size.width * 0.1,
        // leading: Padding(
        //   padding: const EdgeInsets.fromLTRB(16, 0, 0, 0),
        //   child: GoBackButton(
        //     buttonColor: AppColors.neutral01,
        //   ),
        // ),

        titleSpacing: 10,
        automaticallyImplyLeading: false,
        backgroundColor: AppColors.neutral00,
        centerTitle: true,
        title: PageTitle(
          title: 'choose your player',
          color: AppColors.neutral03,
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
                                    title: 'delete player?',
                                    color: widget.dsix
                                        .getCurrentPlayer()
                                        .primaryColor,
                                    confirm: () async {
                                      widget.dsix.resetPlayer(index);
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
                  onTapAction: () async {
                    playersPageVM.goToGmUI(context, widget.dsix);
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
