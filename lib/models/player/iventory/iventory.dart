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
import 'itemDetail.dart';
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
                          pDamage: user.selectedPlayer!.pDamage,
                          mDamage: user.selectedPlayer!.mDamage,
                          pArmor: user.selectedPlayer!.pArmor,
                          mArmor: user.selectedPlayer!.mArmor,
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
                                  item: user.selectedPlayer!.mainHandSlot!,
                                  slotImage: AppIcons.mainHandSlot,
                                  onTap: () {
                                    showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return ItemDetail(
                                          playerID: user.selectedPlayerID,
                                          playerTurn: user.playerTurn,
                                          item: user
                                              .selectedPlayer!.mainHandSlot!,
                                          buttonText: 'unequip',
                                          useEquipOrUnequip: () async {
                                            user.selectedPlayer!.unequip(
                                                user.selectedPlayer!
                                                    .mainHandSlot!,
                                                'mainHandSlot');
                                            user.updateIventory(
                                                gameController.gameID);
                                            refresh();
                                          },
                                        );
                                      },
                                    );
                                  },
                                  onDoubleTap: () async {
                                    if (user.playerTurn == false) {
                                      return;
                                    }
                                    user.selectedPlayer!.unequip(
                                        user.selectedPlayer!.mainHandSlot!,
                                        'mainHandSlot');
                                    user.updateIventory(gameController.gameID);
                                    refresh();
                                  },
                                ),
                              ),
                              Expanded(
                                flex: 1,
                                child: IventorySlot(
                                  playerID: user.selectedPlayerID,
                                  item: user.selectedPlayer!.handSlot!,
                                  slotImage: AppIcons.handSlot,
                                  onTap: () {
                                    showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return ItemDetail(
                                          playerID: user.selectedPlayerID,
                                          playerTurn: user.playerTurn,
                                          item: user.selectedPlayer!.handSlot!,
                                          buttonText: 'unequip',
                                          useEquipOrUnequip: () async {
                                            user.selectedPlayer!.unequip(
                                                user.selectedPlayer!.handSlot!,
                                                'handSlot');
                                            user.updateIventory(
                                                gameController.gameID);
                                            refresh();
                                          },
                                        );
                                      },
                                    );
                                  },
                                  onDoubleTap: () async {
                                    if (user.playerTurn == false) {
                                      return;
                                    }
                                    user.selectedPlayer!.unequip(
                                        user.selectedPlayer!.handSlot!,
                                        'handSlot');
                                    user.updateIventory(gameController.gameID);
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
                                  item: user.selectedPlayer!.headSlot!,
                                  slotImage: AppIcons.headSlot,
                                  onTap: () {
                                    showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return ItemDetail(
                                          playerID: user.selectedPlayerID,
                                          playerTurn: user.playerTurn,
                                          item: user.selectedPlayer!.headSlot!,
                                          buttonText: 'unequip',
                                          useEquipOrUnequip: () async {
                                            user.selectedPlayer!.unequip(
                                                user.selectedPlayer!.headSlot!,
                                                'headSlot');
                                            user.updateIventory(
                                                gameController.gameID);
                                            refresh();
                                          },
                                        );
                                      },
                                    );
                                  },
                                  onDoubleTap: () async {
                                    if (user.playerTurn == false) {
                                      return;
                                    }
                                    user.selectedPlayer!.unequip(
                                        user.selectedPlayer!.headSlot!,
                                        'headSlot');
                                    user.updateIventory(gameController.gameID);
                                    refresh();
                                  },
                                ),
                              ),
                              Expanded(
                                flex: 2,
                                child: IventorySlot(
                                  playerID: user.selectedPlayerID,
                                  item: user.selectedPlayer!.bodySlot!,
                                  slotImage: AppIcons.bodySlot,
                                  onTap: () {
                                    showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return ItemDetail(
                                          playerID: user.selectedPlayerID,
                                          playerTurn: user.playerTurn,
                                          item: user.selectedPlayer!.bodySlot!,
                                          buttonText: 'unequip',
                                          useEquipOrUnequip: () async {
                                            user.selectedPlayer!.unequip(
                                                user.selectedPlayer!.bodySlot!,
                                                'bodySlot');
                                            user.updateIventory(
                                                gameController.gameID);
                                            refresh();
                                          },
                                        );
                                      },
                                    );
                                  },
                                  onDoubleTap: () async {
                                    if (user.playerTurn == false) {
                                      return;
                                    }
                                    user.selectedPlayer!.unequip(
                                        user.selectedPlayer!.bodySlot!,
                                        'bodySlot');
                                    user.updateIventory(gameController.gameID);
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
                                  item: user.selectedPlayer!.offHandSlot!,
                                  slotImage: AppIcons.offHandSlot,
                                  onTap: () {
                                    showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return ItemDetail(
                                          playerID: user.selectedPlayerID,
                                          playerTurn: user.playerTurn,
                                          item:
                                              user.selectedPlayer!.offHandSlot!,
                                          buttonText: 'unequip',
                                          useEquipOrUnequip: () async {
                                            user.selectedPlayer!.unequip(
                                                user.selectedPlayer!
                                                    .offHandSlot!,
                                                'offHandSlot');
                                            user.updateIventory(
                                                gameController.gameID);
                                            refresh();
                                          },
                                        );
                                      },
                                    );
                                  },
                                  onDoubleTap: () async {
                                    user.selectedPlayer!.unequip(
                                        user.selectedPlayer!.offHandSlot!,
                                        'offHandSlot');
                                    user.updateIventory(gameController.gameID);
                                    refresh();
                                  },
                                ),
                              ),
                              Expanded(
                                flex: 1,
                                child: IventorySlot(
                                  playerID: user.selectedPlayerID,
                                  item: user.selectedPlayer!.feetSlot!,
                                  slotImage: AppIcons.feetSlot,
                                  onTap: () {
                                    showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return ItemDetail(
                                          playerID: user.selectedPlayerID,
                                          playerTurn: user.playerTurn,
                                          item: user.selectedPlayer!.feetSlot!,
                                          buttonText: 'unequip',
                                          useEquipOrUnequip: () async {
                                            user.selectedPlayer!.unequip(
                                                user.selectedPlayer!.feetSlot!,
                                                'feetSlot');
                                            user.updateIventory(
                                                gameController.gameID);
                                            refresh();
                                          },
                                        );
                                      },
                                    );
                                  },
                                  onDoubleTap: () async {
                                    if (user.playerTurn == false) {
                                      return;
                                    }
                                    user.selectedPlayer!.unequip(
                                        user.selectedPlayer!.feetSlot!,
                                        'feetSlot');
                                    user.updateIventory(gameController.gameID);
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
                    color:
                        _uiColor.setUIColor(user.selectedPlayerID, 'primary'),
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(30, 5, 30, 7),
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
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: GridView.count(
                      shrinkWrap: true,
                      crossAxisCount: 6,
                      children: List.generate(user.selectedPlayer!.bag!.length,
                          (index) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 3),
                          child: GestureDetector(
                            onLongPress: () {
                              if (user.playerTurn == false) {
                                return;
                              }

                              user.selectedPlayer!.destroyItem(
                                  user.selectedPlayer!.bag![index]);
                              user.updateBag(gameController.gameID);
                              refresh();
                            },
                            onTap: () {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return (user.selectedPlayer!.bag![index]
                                              .itemSlot ==
                                          'consumable')
                                      ? ItemDetail(
                                          playerID: user.selectedPlayerID,
                                          playerTurn: user.playerTurn,
                                          item:
                                              user.selectedPlayer!.bag![index],
                                          buttonText: 'use',
                                          useEquipOrUnequip: () async {
                                            user.useItem(
                                                gameController.gameID,
                                                user.selectedPlayer!
                                                    .bag![index]);
                                            user.takeAction(
                                              gameController.gameID,
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
                                      : ItemDetail(
                                          playerID: user.selectedPlayerID,
                                          playerTurn: user.playerTurn,
                                          item:
                                              user.selectedPlayer!.bag![index],
                                          buttonText: 'equip',
                                          useEquipOrUnequip: () async {
                                            user.selectedPlayer!.equipItem(user
                                                .selectedPlayer!.bag![index]);
                                            user.updateIventory(
                                                gameController.gameID);

                                            refresh();
                                          },
                                        );
                                },
                              );
                            },
                            onDoubleTap: () {
                              if (user.playerTurn == false) {
                                return;
                              }
                              user.selectedPlayer!
                                  .equipItem(user.selectedPlayer!.bag![index]);
                              user.updateIventory(gameController.gameID);
                              refresh();
                            },
                            child: SvgPicture.asset(
                              user.selectedPlayer!.bag![index].icon!,
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
