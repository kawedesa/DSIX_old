import 'package:dsixv02app/models/loot.dart';
import 'package:dsixv02app/models/turnOrder.dart';
import 'package:dsixv02app/pages/shared/app_Colors.dart';
import 'package:dsixv02app/models/game.dart';
import 'package:dsixv02app/models/player.dart';
import 'package:dsixv02app/pages/shared/app_Icons.dart';
import 'package:dsixv02app/pages/shared/widgets/button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'battleRoyaleSettingsPageVM.dart';

class BattleRoyaleSettingsPage extends StatefulWidget {
  const BattleRoyaleSettingsPage({Key key}) : super(key: key);

  @override
  State<BattleRoyaleSettingsPage> createState() =>
      _BattleRoyaleSettingsPageState();
}

class _BattleRoyaleSettingsPageState extends State<BattleRoyaleSettingsPage> {
  BattleRoyaleSettingsPageVM _battleRoyaleSettingsPage =
      BattleRoyaleSettingsPageVM();
  @override
  Widget build(BuildContext context) {
    _battleRoyaleSettingsPage.setNumberOfPlayers();
    final game = Provider.of<Game>(context);
    final playerController = Provider.of<PlayerController>(context);
    final players = Provider.of<List<Player>>(context);
    final turnController = Provider.of<TurnController>(context);
    final lootController = Provider.of<LootController>(context);

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
                      ? SizedBox()
                      : SizedBox(
                          width: MediaQuery.of(context).size.width * 0.5,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    _battleRoyaleSettingsPage
                                        .decreaseNumberOfPlayers();
                                  });
                                },
                                child: SvgPicture.asset(
                                  AppIcons.leftArrow,
                                  color: AppColors.grey03,
                                  width:
                                      MediaQuery.of(context).size.width * 0.07,
                                ),
                              ),
                              SizedBox(
                                width:
                                    MediaQuery.of(context).size.height * 0.15,
                                height:
                                    MediaQuery.of(context).size.height * 0.15,
                                child: Center(
                                    child: Text(
                                  '${_battleRoyaleSettingsPage.numberOfPlayers}',
                                  style: TextStyle(
                                    fontFamily: 'Calibri',
                                    fontSize: 75,
                                    color: AppColors.white00,
                                  ),
                                )),
                              ),
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    _battleRoyaleSettingsPage
                                        .increaseNumberOfPlayers();
                                  });
                                },
                                child: SvgPicture.asset(
                                  AppIcons.rightArrow,
                                  width:
                                      MediaQuery.of(context).size.width * 0.07,
                                  color: AppColors.grey03,
                                ),
                              ),
                            ],
                          ),
                        ),
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
                            _battleRoyaleSettingsPage.newBattleRoyaleGame(
                              context,
                              game,
                              playerController,
                              turnController,
                              lootController,
                            );
                          },
                        ),
                  (players.isNotEmpty)
                      ? Padding(
                          padding: const EdgeInsets.only(top: 5),
                          child: Button(
                              buttonText: 'delete game',
                              onTapAction: () {
                                _battleRoyaleSettingsPage
                                    .deleteBattleRoyaleGame(
                                        game,
                                        playerController,
                                        turnController,
                                        lootController);
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
