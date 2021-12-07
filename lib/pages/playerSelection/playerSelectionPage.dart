import 'package:dsixv02app/pages/shared/app_Colors.dart';
import 'package:dsixv02app/models/dsix.dart';
import 'package:dsixv02app/models/player.dart';
import 'package:dsixv02app/pages/settings/battleRoyaleSettingsPage.dart';
import 'package:dsixv02app/pages/shared/widgets/button.dart';
import 'package:dsixv02app/pages/shared/widgets/goToPageButton.dart';
import 'package:dsixv02app/pages/shared/widgets/uiColor.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'playerSelectionPageVM.dart';

class PlayerSelectionPage extends StatelessWidget {
  const PlayerSelectionPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    PlayerSelectionPageVM _selectPlayerPageVM = PlayerSelectionPageVM();
    UIColor _uiColor = UIColor();
    final dsix = Provider.of<Dsix>(context);
    final players = Provider.of<List<Player>>(context);
    final turnOrder = Provider.of<List<Turn>>(context);

    return Scaffold(
        appBar: AppBar(
          leading: Padding(
            padding: const EdgeInsets.only(left: 10),
            child: GoToPagePageButton(goToPage: BattleRoyaleSettingsPage()),
          ),
          backgroundColor: AppColors.grey00,
        ),
        backgroundColor: AppColors.black00,
        body: SafeArea(
          child: SizedBox(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: Center(
              child: Container(
                width: MediaQuery.of(context).size.width * 0.65,
                child: ListView.builder(
                  shrinkWrap: true,
                  padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                  itemCount: players.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Padding(
                      padding: const EdgeInsets.fromLTRB(0, 0, 0, 5),
                      child: Button(
                        buttonText: '${players[index].id}',
                        buttonColor:
                            _uiColor.setUIColor(players[index].id, 'primary'),
                        buttonTextColor:
                            _uiColor.setUIColor(players[index].id, 'primary'),
                        onTapAction: () async {
                          dsix.selectPlayer(index);
                          if (turnOrder.isEmpty) {
                            dsix.newRound(players);
                          }
                          _selectPlayerPageVM.goToMapPage(context);
                        },
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
        ));
  }
}
