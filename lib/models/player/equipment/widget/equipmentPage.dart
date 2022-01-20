import 'package:dsixv02app/models/game/game.dart';
import 'package:dsixv02app/shared/app_Colors.dart';
import 'package:dsixv02app/shared/app_Icons.dart';
import 'package:dsixv02app/shared/widgets/uiColor.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import '../../user.dart';
import 'damageAndArmorStats.dart';
import 'itemDetailPage.dart';
import 'iventorySlot.dart';

class EquipmentPage extends StatefulWidget {
  const EquipmentPage({
    Key? key,
  }) : super(key: key);

  @override
  State<EquipmentPage> createState() => _EquipmentPageState();
}

class _EquipmentPageState extends State<EquipmentPage> {
  UIColor _uiColor = UIColor();
  refresh() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final game = Provider.of<Game>(context);
    final user = Provider.of<User>(context);

    return AlertDialog(
      contentPadding: EdgeInsets.fromLTRB(0, 0, 0, 0),
      content: Container(
        width: MediaQuery.of(context).size.width * 0.8,
        decoration: BoxDecoration(
          color: AppColors.black00,
          border: Border.all(
            color: _uiColor.setUIColor(user.selectedPlayer!.id, 'primary'),
            width: 2,
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              height: MediaQuery.of(context).size.height * 0.05,
              color: _uiColor.setUIColor(user.selectedPlayer!.id, 'primary'),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(30, 5, 30, 7),
                child: Center(
                  child: Text('equipment'.toUpperCase(),
                      style: TextStyle(
                        fontFamily: 'Santana',
                        height: 1,
                        fontSize: 25,
                        color: _uiColor.setUIColor(
                            user.selectedPlayer!.id, 'secondary'),
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
                          playerID: user.selectedPlayer!.id,
                          pDamage:
                              user.selectedPlayer!.equipment!.damage!.pDamage,
                          mDamage:
                              user.selectedPlayer!.equipment!.damage!.mDamage,
                          pArmor: user.selectedPlayer!.equipment!.armor!.pArmor,
                          mArmor: user.selectedPlayer!.equipment!.armor!.mArmor,
                        )),
                  ),
                  Divider(
                    height: 0,
                    thickness: 2,
                    color:
                        _uiColor.setUIColor(user.selectedPlayer!.id, 'primary'),
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
                                  playerID: user.selectedPlayer!.id,
                                  item: user
                                      .selectedPlayer!.equipment!.mainHandSlot!,
                                  slotImage: AppIcons.mainHandSlot,
                                  onTap: () {
                                    if (user.selectedPlayer!.equipment!
                                            .mainHandSlot!.name! ==
                                        '') {
                                      return;
                                    }

                                    showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return ItemDetailPage(
                                          playerID: user.selectedPlayer!.id,
                                          outOfActions: user
                                              .selectedPlayer!.action!
                                              .outOfActions(),
                                          item: user.selectedPlayer!.equipment!
                                              .mainHandSlot!,
                                          buttonText: 'unequip',
                                          useEquipOrUnequip: () async {
                                            user.selectedPlayer!.equipment!
                                                .unequip(
                                              game.id!,
                                              user.selectedPlayer!.id!,
                                              user.selectedPlayer!.equipment!
                                                  .mainHandSlot!,
                                            );
                                            refresh();
                                          },
                                        );
                                      },
                                    );
                                  },
                                  onDoubleTap: () async {
                                    user.selectedPlayer!.equipment!.unequip(
                                      game.id!,
                                      user.selectedPlayer!.id!,
                                      user.selectedPlayer!.equipment!
                                          .mainHandSlot!,
                                    );
                                    refresh();
                                  },
                                ),
                              ),
                              Expanded(
                                flex: 1,
                                child: IventorySlot(
                                  playerID: user.selectedPlayer!.id,
                                  item:
                                      user.selectedPlayer!.equipment!.handSlot!,
                                  slotImage: AppIcons.handSlot,
                                  onTap: () {
                                    if (user.selectedPlayer!.equipment!
                                            .handSlot!.name! ==
                                        '') {
                                      return;
                                    }

                                    showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return ItemDetailPage(
                                          playerID: user.selectedPlayer!.id,
                                          outOfActions: user
                                              .selectedPlayer!.action!
                                              .outOfActions(),
                                          item: user.selectedPlayer!.equipment!
                                              .handSlot!,
                                          buttonText: 'unequip',
                                          useEquipOrUnequip: () async {
                                            user.selectedPlayer!.equipment!
                                                .unequip(
                                              game.id!,
                                              user.selectedPlayer!.id!,
                                              user.selectedPlayer!.equipment!
                                                  .handSlot!,
                                            );
                                            refresh();
                                          },
                                        );
                                      },
                                    );
                                  },
                                  onDoubleTap: () async {
                                    user.selectedPlayer!.equipment!.unequip(
                                      game.id!,
                                      user.selectedPlayer!.id!,
                                      user.selectedPlayer!.equipment!.handSlot!,
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
                                  playerID: user.selectedPlayer!.id,
                                  item:
                                      user.selectedPlayer!.equipment!.headSlot!,
                                  slotImage: AppIcons.headSlot,
                                  onTap: () {
                                    if (user.selectedPlayer!.equipment!
                                            .headSlot!.name! ==
                                        '') {
                                      return;
                                    }

                                    showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return ItemDetailPage(
                                          playerID: user.selectedPlayer!.id,
                                          outOfActions: user
                                              .selectedPlayer!.action!
                                              .outOfActions(),
                                          item: user.selectedPlayer!.equipment!
                                              .headSlot!,
                                          buttonText: 'unequip',
                                          useEquipOrUnequip: () async {
                                            user.selectedPlayer!.equipment!
                                                .unequip(
                                              game.id!,
                                              user.selectedPlayer!.id!,
                                              user.selectedPlayer!.equipment!
                                                  .headSlot!,
                                            );
                                            refresh();
                                          },
                                        );
                                      },
                                    );
                                  },
                                  onDoubleTap: () async {
                                    user.selectedPlayer!.equipment!.unequip(
                                      game.id!,
                                      user.selectedPlayer!.id!,
                                      user.selectedPlayer!.equipment!.headSlot!,
                                    );

                                    refresh();
                                  },
                                ),
                              ),
                              Expanded(
                                flex: 2,
                                child: IventorySlot(
                                  playerID: user.selectedPlayer!.id,
                                  item:
                                      user.selectedPlayer!.equipment!.bodySlot!,
                                  slotImage: AppIcons.bodySlot,
                                  onTap: () {
                                    if (user.selectedPlayer!.equipment!
                                            .bodySlot!.name! ==
                                        '') {
                                      return;
                                    }

                                    showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return ItemDetailPage(
                                          playerID: user.selectedPlayer!.id,
                                          outOfActions: user
                                              .selectedPlayer!.action!
                                              .outOfActions(),
                                          item: user.selectedPlayer!.equipment!
                                              .bodySlot!,
                                          buttonText: 'unequip',
                                          useEquipOrUnequip: () async {
                                            user.selectedPlayer!.equipment!
                                                .unequip(
                                              game.id!,
                                              user.selectedPlayer!.id!,
                                              user.selectedPlayer!.equipment!
                                                  .bodySlot!,
                                            );
                                            refresh();
                                          },
                                        );
                                      },
                                    );
                                  },
                                  onDoubleTap: () async {
                                    user.selectedPlayer!.equipment!.unequip(
                                      game.id!,
                                      user.selectedPlayer!.id!,
                                      user.selectedPlayer!.equipment!.bodySlot!,
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
                                  playerID: user.selectedPlayer!.id,
                                  item: user
                                      .selectedPlayer!.equipment!.offHandSlot!,
                                  slotImage: AppIcons.offHandSlot,
                                  onTap: () {
                                    if (user.selectedPlayer!.equipment!
                                            .offHandSlot!.name! ==
                                        '') {
                                      return;
                                    }

                                    showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return ItemDetailPage(
                                          playerID: user.selectedPlayer!.id,
                                          outOfActions: user
                                              .selectedPlayer!.action!
                                              .outOfActions(),
                                          item: user.selectedPlayer!.equipment!
                                              .offHandSlot!,
                                          buttonText: 'unequip',
                                          useEquipOrUnequip: () async {
                                            user.selectedPlayer!.equipment!
                                                .unequip(
                                              game.id!,
                                              user.selectedPlayer!.id!,
                                              user.selectedPlayer!.equipment!
                                                  .offHandSlot!,
                                            );
                                            refresh();
                                          },
                                        );
                                      },
                                    );
                                  },
                                  onDoubleTap: () async {
                                    user.selectedPlayer!.equipment!.unequip(
                                      game.id!,
                                      user.selectedPlayer!.id!,
                                      user.selectedPlayer!.equipment!
                                          .offHandSlot!,
                                    );
                                    refresh();
                                  },
                                ),
                              ),
                              Expanded(
                                flex: 1,
                                child: IventorySlot(
                                  playerID: user.selectedPlayer!.id,
                                  item:
                                      user.selectedPlayer!.equipment!.feetSlot!,
                                  slotImage: AppIcons.feetSlot,
                                  onTap: () {
                                    if (user.selectedPlayer!.equipment!
                                            .feetSlot!.name! ==
                                        '') {
                                      return;
                                    }

                                    showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return ItemDetailPage(
                                          playerID: user.selectedPlayer!.id,
                                          outOfActions: user
                                              .selectedPlayer!.action!
                                              .outOfActions(),
                                          item: user.selectedPlayer!.equipment!
                                              .feetSlot!,
                                          buttonText: 'unequip',
                                          useEquipOrUnequip: () async {
                                            user.selectedPlayer!.equipment!
                                                .unequip(
                                              game.id!,
                                              user.selectedPlayer!.id!,
                                              user.selectedPlayer!.equipment!
                                                  .feetSlot!,
                                            );
                                            refresh();
                                          },
                                        );
                                      },
                                    );
                                  },
                                  onDoubleTap: () async {
                                    user.selectedPlayer!.equipment!.unequip(
                                      game.id!,
                                      user.selectedPlayer!.id!,
                                      user.selectedPlayer!.equipment!.feetSlot!,
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
                        _uiColor.setUIColor(user.selectedPlayer!.id, 'primary'),
                    child: Center(
                      child: Text('bag'.toUpperCase(),
                          style: TextStyle(
                            fontFamily: 'Santana',
                            height: 1,
                            fontSize: 25,
                            color: _uiColor.setUIColor(
                                user.selectedPlayer!.id, 'secondary'),
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
                          user.selectedPlayer!.equipment!.bag!.length, (index) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 3),
                          child: GestureDetector(
                            onLongPress: () {
                              user.selectedPlayer!.equipment!.destroyItem(
                                  game.id!,
                                  user.selectedPlayer!.id!,
                                  user.selectedPlayer!.equipment!.bag![index]);
                              refresh();
                            },
                            onTap: () {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return (user.selectedPlayer!.equipment!
                                              .bag![index].itemSlot ==
                                          'consumable')
                                      ? ItemDetailPage(
                                          playerID: user.selectedPlayer!.id,
                                          outOfActions: user
                                              .selectedPlayer!.action!
                                              .outOfActions(),
                                          item: user.selectedPlayer!.equipment!
                                              .bag![index],
                                          buttonText: 'use',
                                          useEquipOrUnequip: () async {
                                            user.selectedPlayer!.useItem(
                                                game.id!,
                                                user.selectedPlayer!.equipment!
                                                    .bag![index]);

                                            user.selectedPlayer!.action!
                                                .takeAction(
                                              game.id!,
                                              user.selectedPlayer!.id!,
                                            );

                                            if (user.selectedPlayer!.action!
                                                .outOfActions()) {
                                              game.round!.passTurn(game.id!,
                                                  user.selectedPlayer!.id!);
                                            }
                                            Navigator.pop(context);

                                            refresh();
                                          },
                                        )
                                      : ItemDetailPage(
                                          playerID: user.selectedPlayer!.id,
                                          outOfActions: user
                                              .selectedPlayer!.action!
                                              .outOfActions(),
                                          item: user.selectedPlayer!.equipment!
                                              .bag![index],
                                          buttonText: 'equip',
                                          useEquipOrUnequip: () async {
                                            user.selectedPlayer!.equipment!
                                                .equip(
                                                    game.id!,
                                                    user.selectedPlayer!.id!,
                                                    user
                                                        .selectedPlayer!
                                                        .equipment!
                                                        .bag![index]);

                                            refresh();
                                          },
                                        );
                                },
                              );
                            },
                            onDoubleTap: () {
                              if ((user.selectedPlayer!.equipment!.bag![index]
                                      .itemSlot ==
                                  'consumable')) {
                                user.selectedPlayer!.useItem(
                                    game.id!,
                                    user.selectedPlayer!.equipment!
                                        .bag![index]);

                                user.selectedPlayer!.action!.takeAction(
                                  game.id!,
                                  user.selectedPlayer!.id!,
                                );

                                if (user.selectedPlayer!.action!
                                    .outOfActions()) {
                                  game.round!.passTurn(
                                      game.id!, user.selectedPlayer!.id!);
                                }

                                Navigator.pop(context);
                              } else {
                                user.selectedPlayer!.equipment!.equip(
                                    game.id!,
                                    user.selectedPlayer!.id!,
                                    user.selectedPlayer!.equipment!
                                        .bag![index]);
                              }

                              refresh();
                            },
                            child: SvgPicture.asset(
                              user.selectedPlayer!.equipment!.bag![index].icon!,
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
