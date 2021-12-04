import 'package:dsixv02app/core/app_Colors.dart';
import 'package:dsixv02app/core/widgets/button.dart';
import 'package:dsixv02app/core/widgets/goToPageButton.dart';
import 'package:dsixv02app/models/dsix.dart';
import 'package:dsixv02app/models/player.dart';
import 'package:dsixv02app/pages/battleRoyaleSettingsPage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'playerSelectionPageVM.dart';

class PlayerSelectionPage extends StatelessWidget {
  const PlayerSelectionPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final listOfPlayers = Provider.of<List<Player>>(context);
    final dsix = Provider.of<Dsix>(context);
    PlayerSelectionPageVM _selectPlayerPageVM = PlayerSelectionPageVM();

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
                  itemCount: listOfPlayers.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Padding(
                      padding: const EdgeInsets.fromLTRB(0, 0, 0, 5),
                      child: Button(
                        buttonText: '${dsix.listOfPlayers[index].id}',
                        buttonColor: dsix.listOfPlayers[index].color.primary,
                        buttonTextColor:
                            dsix.listOfPlayers[index].color.primary,
                        onTapAction: () async {
                          dsix.selectPlayer(index);
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
