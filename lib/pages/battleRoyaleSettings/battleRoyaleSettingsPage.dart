import 'package:dsixv02app/models/game/gameController.dart';
import 'package:dsixv02app/models/loot/lootController.dart';
import 'package:dsixv02app/models/player/playersController.dart';
import 'package:dsixv02app/models/round/roundController.dart';
import 'package:dsixv02app/models/turn/turnController.dart';
import 'package:dsixv02app/shared/app_Colors.dart';
import 'package:dsixv02app/models/game/game.dart';
import 'package:dsixv02app/shared/app_Icons.dart';
import 'package:dsixv02app/shared/widgets/button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'battleRoyaleSettingsPageVM.dart';

class BattleRoyaleSettingsPage extends StatefulWidget {
  const BattleRoyaleSettingsPage({Key? key}) : super(key: key);

  @override
  State<BattleRoyaleSettingsPage> createState() =>
      _BattleRoyaleSettingsPageState();
}

class _BattleRoyaleSettingsPageState extends State<BattleRoyaleSettingsPage> {
  BattleRoyaleSettingsPageVM _battleRoyaleSettingsPage =
      BattleRoyaleSettingsPageVM();
  @override
  Widget build(BuildContext context) {
    final game = Provider.of<Game>(context);
    final gameController = Provider.of<GameController>(context);
    final playerController = Provider.of<PlayersController>(context);
    // final roundController = Provider.of<RoundController>(context);
    // final turnController = Provider.of<TurnController>(context);
    final lootController = Provider.of<LootController>(context);

    return Scaffold(
      backgroundColor: AppColors.black00,
      appBar: AppBar(
        toolbarHeight: MediaQuery.of(context).size.height * 0.06,
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: Text(
          'battle royale'.toUpperCase(),
          textAlign: TextAlign.left,
          style: TextStyle(
            fontFamily: 'Santana',
            height: 1,
            fontSize: 27,
            color: AppColors.grey00,
            letterSpacing: 1.2,
          ),
        ),
        backgroundColor: AppColors.grey02,
      ),
      body: SafeArea(
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Center(
            child: (game.isRunning!)
                ? Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Button(
                        buttonText: 'join game',
                        buttonColor: AppColors.grey02,
                        buttonFillColor: AppColors.black00,
                        buttonTextColor: AppColors.grey04,
                        onTapAction: () async {
                          _battleRoyaleSettingsPage.joinGame(context);
                        },
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 5),
                        child: Button(
                          buttonText: 'delete game',
                          buttonColor: AppColors.grey02,
                          buttonFillColor: AppColors.black00,
                          buttonTextColor: AppColors.grey04,
                          onTapAction: () async {
                            _battleRoyaleSettingsPage.deleteGame(
                              gameController,
                              playerController,
                              lootController,
                              // turnController
                            );
                          },
                        ),
                      ),
                    ],
                  )
                : Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Column(
                        children: [
                          Text(
                            'players'.toUpperCase(),
                            textAlign: TextAlign.left,
                            style: TextStyle(
                              fontFamily: 'Santana',
                              height: 1,
                              fontSize: 35,
                              color: AppColors.grey03,
                              letterSpacing: 4,
                            ),
                          ),
                          SizedBox(
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
                                    width: MediaQuery.of(context).size.width *
                                        0.07,
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
                                    width: MediaQuery.of(context).size.width *
                                        0.07,
                                    color: AppColors.grey03,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          Text(
                            'loot'.toUpperCase(),
                            textAlign: TextAlign.left,
                            style: TextStyle(
                              fontFamily: 'Santana',
                              height: 1,
                              fontSize: 35,
                              color: AppColors.grey03,
                              letterSpacing: 4,
                            ),
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.5,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      _battleRoyaleSettingsPage
                                          .decreaseNumberOfLoot();
                                    });
                                  },
                                  child: SvgPicture.asset(
                                    AppIcons.leftArrow,
                                    color: AppColors.grey03,
                                    width: MediaQuery.of(context).size.width *
                                        0.07,
                                  ),
                                ),
                                SizedBox(
                                  width:
                                      MediaQuery.of(context).size.height * 0.15,
                                  height:
                                      MediaQuery.of(context).size.height * 0.15,
                                  child: Center(
                                      child: Text(
                                    '${_battleRoyaleSettingsPage.numberOfLoot}',
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
                                          .increaseNumberOfLoot();
                                    });
                                  },
                                  child: SvgPicture.asset(
                                    AppIcons.rightArrow,
                                    width: MediaQuery.of(context).size.width *
                                        0.07,
                                    color: AppColors.grey03,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      Button(
                        buttonText: 'new game',
                        buttonColor: AppColors.grey02,
                        buttonFillColor: AppColors.black00,
                        buttonTextColor: AppColors.grey04,
                        onTapAction: () async {
                          _battleRoyaleSettingsPage.newBattleRoyaleGame(
                              gameController,
                              playerController,
                              // roundController,
                              // turnController,
                              lootController);
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
