import 'package:dsixv02app/core/app_Colors.dart';
import 'package:dsixv02app/core/widgets/button.dart';
import 'package:dsixv02app/models/dsix.dart';
import 'package:dsixv02app/models/player.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'battleRoyaleSettingsPageVM.dart';

class BattleRoyaleSettingsPage extends StatefulWidget {
  const BattleRoyaleSettingsPage({Key key}) : super(key: key);

  @override
  State<BattleRoyaleSettingsPage> createState() =>
      _BattleRoyaleSettingsPageState();
}

class _BattleRoyaleSettingsPageState extends State<BattleRoyaleSettingsPage> {
  @override
  Widget build(BuildContext context) {
    BattleRoyaleSettingsPageVM _battleRoyaleSettingsPage =
        BattleRoyaleSettingsPageVM();
    final dsix = Provider.of<Dsix>(context);
    final listOfPlayers = Provider.of<List<Player>>(context);

    return Scaffold(
      backgroundColor: AppColors.black00,
      body: SafeArea(
        child: SizedBox(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  (listOfPlayers.isNotEmpty)
                      ? Button(
                          buttonText: 'join game',
                          onTapAction: () {
                            setState(() {
                              _battleRoyaleSettingsPage.continueGame(
                                  context, dsix);
                            });
                          },
                        )
                      : Button(
                          buttonText: 'new game',
                          onTapAction: () {
                            setState(() {
                              _battleRoyaleSettingsPage.newGame(
                                  context, dsix, 5);
                            });
                          },
                        ),
                  (listOfPlayers.isNotEmpty)
                      ? Padding(
                          padding: const EdgeInsets.only(top: 5),
                          child: Button(
                              buttonText: 'delete game',
                              onTapAction: () {
                                setState(() {
                                  _battleRoyaleSettingsPage.deleteGame(dsix);
                                });
                              }),
                        )
                      : Container(),
                ],
              ),
            )),
      ),
    );
  }
}
