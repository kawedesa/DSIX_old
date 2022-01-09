import 'package:dsixv02app/models/game/gameController.dart';
import 'package:dsixv02app/models/turn/turnController.dart';
import 'package:dsixv02app/shared/app_Colors.dart';
import 'package:dsixv02app/shared/app_Icons.dart';
import 'package:dsixv02app/shared/widgets/uiColor.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import '../user.dart';
import 'damageAndArmorStats.dart';
import 'itemDetailPage.dart';
import 'iventorySlot.dart';

class Iventory extends StatefulWidget {
  const Iventory({
    Key? key,
  }) : super(key: key);

  @override
  State<Iventory> createState() => _IventoryState();
}

class _IventoryState extends State<Iventory> {
  UIColor _uiColor = UIColor();
  refresh() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final gameController = Provider.of<GameController>(context);
    final turnController = Provider.of<TurnController>(context);
    final user = Provider.of<User>(context);

    return AlertDialog(
      contentPadding: EdgeInsets.fromLTRB(0, 0, 0, 0),
      content: Container(
        width: MediaQuery.of(context).size.width * 0.8,
        decoration: BoxDecoration(
          color: AppColors.black00,
          border: Border.all(
            color: _uiColor.setUIColor(user.selectedPlayerID, 'primary'),
            width: 2,
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              height: MediaQuery.of(context).size.height * 0.05,
              color: _uiColor.setUIColor(user.selectedPlayerID, 'primary'),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(30, 5, 30, 7),
                child: Center(
                  child: Text('iventory'.toUpperCase(),
                      style: TextStyle(
                        fontFamily: 'Santana',
                        height: 1,
                        fontSize: 25,
                        color: _uiColor.setUIColor(
                            user.selectedPlayerID, 'secondary'),
                        fontWeight: FontWeight.bold,
                        letterSpacing: 3,
                      )),
                ),
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.75,
              child: Column(
                children: [
                  Container(
                    height: MediaQuery.of(context).size.height * 0.07,
                    child: SizedBox(
                        width: MediaQuery.of(context).size.width * 0.7,
                        child: DamageAndArmorStats(
                          playerID: user.selectedPlayerID,
                          pDamage: user.selectedPlayer!.damage!.pDamage,
                          mDamage: user.selectedPlayer!.damage!.mDamage,
                          pArmor: user.selectedPlayer!.armor!.pArmor,
                          mArmor: user.selectedPlayer!.armor!.mArmor,
                        )),
                  ),
                  Divider(
                    height: 0,
                    thickness: 2,
                    color:
                        _uiColor.setUIColor(user.selectedPlayerID, 'primary'),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.8,
                    height: MediaQuery.of(context).size.height * 0.4,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          flex: 1,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                flex: 2,
                                child: IventorySlot(
                                  playerID: user.selectedPlayerID,
                                  item: user
                                      .selectedPlayer!.iventory!.mainHandSlot!,
                                  slotImage: AppIcons.mainHandSlot,
                                  onTap: () {
                                    showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return ItemDetailPage(
                                          playerID: user.selectedPlayerID,
                                          playerTurn: user.playerTurn,
                                          item: user.selectedPlayer!.iventory!
                                              .mainHandSlot!,
                                          buttonText: 'unequip',
                                          useEquipOrUnequip: () async {
                                            user.unequipItem(
                                              gameController.gameID,
                                              user.selectedPlayer!.iventory!
                                                  .mainHandSlot!,
                                            );
                                            refresh();
                                          },
                                        );
                                      },
                                    );
                                  },
                                  onDoubleTap: () async {
                                    user.unequipItem(
                                      gameController.gameID,
                                      user.selectedPlayer!.iventory!
                                          .mainHandSlot!,
                                    );
                                    refresh();
                                  },
                                ),
                              ),
                              Expanded(
                                flex: 1,
                                child: IventorySlot(
                                  playerID: user.selectedPlayerID,
                                  item:
                                      user.selectedPlayer!.iventory!.handSlot!,
                                  slotImage: AppIcons.handSlot,
                                  onTap: () {
                                    showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return ItemDetailPage(
                                          playerID: user.selectedPlayerID,
                                          playerTurn: user.playerTurn,
                                          item: user.selectedPlayer!.iventory!
                                              .handSlot!,
                                          buttonText: 'unequip',
                                          useEquipOrUnequip: () async {
                                            user.unequipItem(
                                              gameController.gameID,
                                              user.selectedPlayer!.iventory!
                                                  .handSlot!,
                                            );
                                            refresh();
                                          },
                                        );
                                      },
                                    );
                                  },
                                  onDoubleTap: () async {
                                    user.unequipItem(
                                      gameController.gameID,
                                      user.selectedPlayer!.iventory!.handSlot!,
                                    );
                                    refresh();
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                flex: 1,
                                child: IventorySlot(
                                  playerID: user.selectedPlayerID,
                                  item:
                                      user.selectedPlayer!.iventory!.headSlot!,
                                  slotImage: AppIcons.headSlot,
                                  onTap: () {
                                    showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return ItemDetailPage(
                                          playerID: user.selectedPlayerID,
                                          playerTurn: user.playerTurn,
                                          item: user.selectedPlayer!.iventory!
                                              .headSlot!,
                                          buttonText: 'unequip',
                                          useEquipOrUnequip: () async {
                                            user.unequipItem(
                                              gameController.gameID,
                                              user.selectedPlayer!.iventory!
                                                  .headSlot!,
                                            );
                                            refresh();
                                          },
                                        );
                                      },
                                    );
                                  },
                                  onDoubleTap: () async {
                                    user.unequipItem(
                                      gameController.gameID,
                                      user.selectedPlayer!.iventory!.headSlot!,
                                    );

                                    refresh();
                                  },
                                ),
                              ),
                              Expanded(
                                flex: 2,
                                child: IventorySlot(
                                  playerID: user.selectedPlayerID,
                                  item:
                                      user.selectedPlayer!.iventory!.bodySlot!,
                                  slotImage: AppIcons.bodySlot,
                                  onTap: () {
                                    showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return ItemDetailPage(
                                          playerID: user.selectedPlayerID,
                                          playerTurn: user.playerTurn,
                                          item: user.selectedPlayer!.iventory!
                                              .bodySlot!,
                                          buttonText: 'unequip',
                                          useEquipOrUnequip: () async {
                                            user.unequipItem(
                                              gameController.gameID,
                                              user.selectedPlayer!.iventory!
                                                  .bodySlot!,
                                            );
                                            refresh();
                                          },
                                        );
                                      },
                                    );
                                  },
                                  onDoubleTap: () async {
                                    user.unequipItem(
                                      gameController.gameID,
                                      user.selectedPlayer!.iventory!.bodySlot!,
                                    );
                                    refresh();
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                flex: 2,
                                child: IventorySlot(
                                  playerID: user.selectedPlayerID,
                                  item: user
                                      .selectedPlayer!.iventory!.offHandSlot!,
                                  slotImage: AppIcons.offHandSlot,
                                  onTap: () {
                                    showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return ItemDetailPage(
                                          playerID: user.selectedPlayerID,
                                          playerTurn: user.playerTurn,
                                          item: user.selectedPlayer!.iventory!
                                              .offHandSlot!,
                                          buttonText: 'unequip',
                                          useEquipOrUnequip: () async {
                                            user.unequipItem(
                                              gameController.gameID,
                                              user.selectedPlayer!.iventory!
                                                  .offHandSlot!,
                                            );
                                            refresh();
                                          },
                                        );
                                      },
                                    );
                                  },
                                  onDoubleTap: () async {
                                    user.unequipItem(
                                      gameController.gameID,
                                      user.selectedPlayer!.iventory!
                                          .offHandSlot!,
                                    );
                                    refresh();
                                  },
                                ),
                              ),
                              Expanded(
                                flex: 1,
                                child: IventorySlot(
                                  playerID: user.selectedPlayerID,
                                  item:
                                      user.selectedPlayer!.iventory!.feetSlot!,
                                  slotImage: AppIcons.feetSlot,
                                  onTap: () {
                                    showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return ItemDetailPage(
                                          playerID: user.selectedPlayerID,
                                          playerTurn: user.playerTurn,
                                          item: user.selectedPlayer!.iventory!
                                              .feetSlot!,
                                          buttonText: 'unequip',
                                          useEquipOrUnequip: () async {
                                            user.unequipItem(
                                              gameController.gameID,
                                              user.selectedPlayer!.iventory!
                                                  .feetSlot!,
                                            );
                                            refresh();
                                          },
                                        );
                                      },
                                    );
                                  },
                                  onDoubleTap: () async {
                                    user.unequipItem(
                                      gameController.gameID,
                                      user.selectedPlayer!.iventory!.feetSlot!,
                                    );
                                    refresh();
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    height: MediaQuery.of(context).size.height * 0.05,
                    color:
                        _uiColor.setUIColor(user.selectedPlayerID, 'primary'),
                    child: Center(
                      child: Text('bag'.toUpperCase(),
                          style: TextStyle(
                            fontFamily: 'Santana',
                            height: 1,
                            fontSize: 25,
                            color: _uiColor.setUIColor(
                                user.selectedPlayerID, 'secondary'),
                            fontWeight: FontWeight.bold,
                            letterSpacing: 3,
                          )),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: GridView.count(
                      shrinkWrap: true,
                      crossAxisCount: 6,
                      children: List.generate(
                          user.selectedPlayer!.iventory!.bag!.length, (index) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 3),
                          child: GestureDetector(
                            onLongPress: () {
                              user.selectedPlayer!.iventory!.destroyItem(
                                  gameController.gameID,
                                  user.selectedPlayer!.index.toString(),
                                  user.selectedPlayer!.iventory!.bag![index]);
                              refresh();
                            },
                            onTap: () {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return (user.selectedPlayer!.iventory!
                                              .bag![index].itemSlot ==
                                          'consumable')
                                      ? ItemDetailPage(
                                          playerID: user.selectedPlayerID,
                                          playerTurn: user.playerTurn,
                                          item: user.selectedPlayer!.iventory!
                                              .bag![index],
                                          buttonText: 'use',
                                          useEquipOrUnequip: () async {
                                            user.useItem(
                                                gameController.gameID,
                                                user.selectedPlayer!.iventory!
                                                    .bag![index]);

                                            user.selectedPlayer!.action!
                                                .takeAction(
                                              gameController.gameID,
                                              user.selectedPlayer!.index!
                                                  .toString(),
                                            );

                                            if (user.selectedPlayer!.action!
                                                .outOfActions()) {
                                              turnController.passTurnWhere(
                                                  gameController.gameID,
                                                  user.selectedPlayer!.id!);
                                            }
                                            Navigator.pop(context);

                                            refresh();
                                          },
                                        )
                                      : ItemDetailPage(
                                          playerID: user.selectedPlayerID,
                                          playerTurn: user.playerTurn,
                                          item: user.selectedPlayer!.iventory!
                                              .bag![index],
                                          buttonText: 'equip',
                                          useEquipOrUnequip: () async {
                                            user.equipItem(
                                                gameController.gameID,
                                                user.selectedPlayer!.iventory!
                                                    .bag![index]);

                                            refresh();
                                          },
                                        );
                                },
                              );
                            },
                            onDoubleTap: () {
                              if ((user.selectedPlayer!.iventory!.bag![index]
                                      .itemSlot ==
                                  'consumable')) {
                                user.useItem(gameController.gameID,
                                    user.selectedPlayer!.iventory!.bag![index]);

                                user.selectedPlayer!.action!.takeAction(
                                  gameController.gameID,
                                  user.selectedPlayer!.index!.toString(),
                                );

                                if (user.selectedPlayer!.action!
                                    .outOfActions()) {
                                  turnController.passTurnWhere(
                                      gameController.gameID,
                                      user.selectedPlayer!.id!);
                                }
                                Navigator.pop(context);
                              } else {
                                user.equipItem(gameController.gameID,
                                    user.selectedPlayer!.iventory!.bag![index]);
                              }

                              refresh();
                            },
                            child: SvgPicture.asset(
                              user.selectedPlayer!.iventory!.bag![index].icon!,
                              color: Colors.white,
                            ),
                          ),
                        );
                      }),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
