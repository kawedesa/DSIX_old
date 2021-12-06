import 'package:dsixv02app/pages/shared/app_Colors.dart';
import 'package:dsixv02app/models/dsix.dart';
import 'package:dsixv02app/models/gameMap.dart';
import 'package:dsixv02app/models/player.dart';
import 'package:dsixv02app/pages/shared/widgets/button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'battleRoyaleSettingsPageVM.dart';

class BattleRoyaleSettingsPage extends StatelessWidget {
  const BattleRoyaleSettingsPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    BattleRoyaleSettingsPageVM _battleRoyaleSettingsPage =
        BattleRoyaleSettingsPageVM();
    final dsix = Provider.of<Dsix>(context);
    final map = Provider.of<GameMap>(context);
    final players = Provider.of<List<Player>>(context);

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
                  (players.isNotEmpty)
                      ? Button(
                          buttonText: 'join game',
                          onTapAction: () {
                            _battleRoyaleSettingsPage.joinGame(context);
                          },
                        )
                      : Button(
                          buttonText: 'new game',
                          onTapAction: () {
                            _battleRoyaleSettingsPage.newGame(
                                context, dsix, map, 5);
                          },
                        ),
                  (players.isNotEmpty)
                      ? Padding(
                          padding: const EdgeInsets.only(top: 5),
                          child: Button(
                              buttonText: 'delete game',
                              onTapAction: () {
                                _battleRoyaleSettingsPage.deleteGame(dsix);
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
