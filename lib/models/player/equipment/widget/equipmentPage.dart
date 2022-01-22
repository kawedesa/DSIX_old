import 'package:dsixv02app/models/game/game.dart';

import 'package:dsixv02app/models/shop/item.dart';
import 'package:dsixv02app/shared/app_Colors.dart';
import 'package:dsixv02app/shared/app_Icons.dart';
import 'package:dsixv02app/shared/widgets/uiColor.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import '../../user.dart';
import '../playerEquipment.dart';
import 'damageAndArmorStats.dart';

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

    double widgetWidth = MediaQuery.of(context).size.width * 0.8;

    return AlertDialog(
      contentPadding: EdgeInsets.fromLTRB(0, 0, 0, 0),
      content: Container(
        width: widgetWidth,
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
            Column(
              mainAxisSize: MainAxisSize.min,
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
                            //MAIN HAND
                            Expanded(
                              flex: 2,
                              child: DragTarget<Item>(
                                builder: (
                                  BuildContext context,
                                  List<dynamic> accepted,
                                  List<dynamic> rejected,
                                ) {
                                  return Container(
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                          color: _uiColor.setUIColor(
                                              user.selectedPlayer!.id,
                                              'primary'),
                                          width: 1,
                                        ),
                                      ),
                                      child: (user.selectedPlayer!.equipment!
                                              .mainHandSlot!.isEmpty!)
                                          ? SvgPicture.asset(
                                              AppIcons.mainHandSlot,
                                              width: double.infinity,
                                              color: _uiColor.setUIColor(
                                                  user.selectedPlayer!.id,
                                                  'primary'),
                                            )
                                          : Draggable<ItemSlot>(
                                              data: user.selectedPlayer!
                                                  .equipment!.mainHandSlot!,
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(10.0),
                                                child: SvgPicture.asset(
                                                  user
                                                      .selectedPlayer!
                                                      .equipment!
                                                      .mainHandSlot!
                                                      .item!
                                                      .icon!,
                                                  width: double.infinity,
                                                  color: AppColors.white00,
                                                ),
                                              ),
                                              feedback: Container(
                                                height: widgetWidth / 4,
                                                width: widgetWidth / 4,
                                                decoration: BoxDecoration(
                                                  border: Border.all(
                                                      width: 2,
                                                      color: _uiColor.setUIColor(
                                                          user.selectedPlayer!
                                                              .id,
                                                          'primary')),
                                                  shape: BoxShape.circle,
                                                  color: Colors.black,
                                                ),
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: SvgPicture.asset(
                                                    user
                                                        .selectedPlayer!
                                                        .equipment!
                                                        .mainHandSlot!
                                                        .item!
                                                        .icon!,
                                                    width: double.infinity,
                                                    color: AppColors.white00,
                                                  ),
                                                ),
                                              ),
                                            ));
                                },
                                onWillAccept: (data) {
                                  if (data!.itemSlot == 'oneHand' ||
                                      data.itemSlot == 'twoHands') {
                                    return true;
                                  }
                                  return false;
                                },
                                onAccept: (data) {
                                  user.selectedPlayer!.equipment!.equip(
                                      game.id!,
                                      user.selectedPlayer!.id!,
                                      user.selectedPlayer!.equipment!
                                          .mainHandSlot!,
                                      data);
                                  setState(() {});
                                },
                              ),
                            ),

                            //HANDS

                            Expanded(
                              flex: 1,
                              child: DragTarget<Item>(
                                builder: (
                                  BuildContext context,
                                  List<dynamic> accepted,
                                  List<dynamic> rejected,
                                ) {
                                  return Container(
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        color: _uiColor.setUIColor(
                                            user.selectedPlayer!.id, 'primary'),
                                        width: 1,
                                      ),
                                    ),
                                    child: (user.selectedPlayer!.equipment!
                                            .handSlot!.isEmpty!)
                                        ? SvgPicture.asset(
                                            AppIcons.handSlot,
                                            width: double.infinity,
                                            color: _uiColor.setUIColor(
                                                user.selectedPlayer!.id,
                                                'primary'),
                                          )
                                        : Draggable<ItemSlot>(
                                            data: user.selectedPlayer!
                                                .equipment!.handSlot!,
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(10.0),
                                              child: SvgPicture.asset(
                                                user.selectedPlayer!.equipment!
                                                    .handSlot!.item!.icon!,
                                                width: double.infinity,
                                                color: AppColors.white00,
                                              ),
                                            ),
                                            feedback: Container(
                                              height: widgetWidth / 4,
                                              width: widgetWidth / 4,
                                              decoration: BoxDecoration(
                                                border: Border.all(
                                                    width: 2,
                                                    color: _uiColor.setUIColor(
                                                        user.selectedPlayer!.id,
                                                        'primary')),
                                                shape: BoxShape.circle,
                                                color: Colors.black,
                                              ),
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: SvgPicture.asset(
                                                  user
                                                      .selectedPlayer!
                                                      .equipment!
                                                      .handSlot!
                                                      .item!
                                                      .icon!,
                                                  width: double.infinity,
                                                  color: AppColors.white00,
                                                ),
                                              ),
                                            ),
                                          ),
                                  );
                                },
                                onWillAccept: (data) {
                                  if (data!.itemSlot == 'hands') {
                                    return true;
                                  }
                                  return false;
                                },
                                onAccept: (data) {
                                  user.selectedPlayer!.equipment!.equip(
                                      game.id!,
                                      user.selectedPlayer!.id!,
                                      user.selectedPlayer!.equipment!.handSlot!,
                                      data);
                                  setState(() {});
                                },
                              ),
                            )
                          ],
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            //HEAD
                            Expanded(
                              flex: 1,
                              child: DragTarget<Item>(
                                builder: (
                                  BuildContext context,
                                  List<dynamic> accepted,
                                  List<dynamic> rejected,
                                ) {
                                  return Container(
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                          color: _uiColor.setUIColor(
                                              user.selectedPlayer!.id,
                                              'primary'),
                                          width: 1,
                                        ),
                                      ),
                                      child: (user.selectedPlayer!.equipment!
                                              .headSlot!.isEmpty!)
                                          ? SvgPicture.asset(
                                              AppIcons.headSlot,
                                              width: double.infinity,
                                              color: _uiColor.setUIColor(
                                                  user.selectedPlayer!.id,
                                                  'primary'),
                                            )
                                          : Draggable<ItemSlot>(
                                              data: user.selectedPlayer!
                                                  .equipment!.headSlot!,
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(10.0),
                                                child: SvgPicture.asset(
                                                  user
                                                      .selectedPlayer!
                                                      .equipment!
                                                      .headSlot!
                                                      .item!
                                                      .icon!,
                                                  width: double.infinity,
                                                  color: AppColors.white00,
                                                ),
                                              ),
                                              feedback: Container(
                                                height: widgetWidth / 4,
                                                width: widgetWidth / 4,
                                                decoration: BoxDecoration(
                                                  border: Border.all(
                                                      width: 2,
                                                      color: _uiColor.setUIColor(
                                                          user.selectedPlayer!
                                                              .id,
                                                          'primary')),
                                                  shape: BoxShape.circle,
                                                  color: Colors.black,
                                                ),
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: SvgPicture.asset(
                                                    user
                                                        .selectedPlayer!
                                                        .equipment!
                                                        .headSlot!
                                                        .item!
                                                        .icon!,
                                                    width: double.infinity,
                                                    color: AppColors.white00,
                                                  ),
                                                ),
                                              ),
                                            ));
                                },
                                onWillAccept: (data) {
                                  if (data!.itemSlot == 'head') {
                                    return true;
                                  }
                                  return false;
                                },
                                onAccept: (data) {
                                  user.selectedPlayer!.equipment!.equip(
                                      game.id!,
                                      user.selectedPlayer!.id!,
                                      user.selectedPlayer!.equipment!.headSlot!,
                                      data);
                                  setState(() {});
                                },
                              ),
                            ),

                            //BODY

                            Expanded(
                              flex: 2,
                              child: DragTarget<Item>(
                                builder: (
                                  BuildContext context,
                                  List<dynamic> accepted,
                                  List<dynamic> rejected,
                                ) {
                                  return Container(
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        color: _uiColor.setUIColor(
                                            user.selectedPlayer!.id, 'primary'),
                                        width: 1,
                                      ),
                                    ),
                                    child: (user.selectedPlayer!.equipment!
                                            .bodySlot!.isEmpty!)
                                        ? SvgPicture.asset(
                                            AppIcons.bodySlot,
                                            width: double.infinity,
                                            color: _uiColor.setUIColor(
                                                user.selectedPlayer!.id,
                                                'primary'),
                                          )
                                        : Draggable<ItemSlot>(
                                            data: user.selectedPlayer!
                                                .equipment!.bodySlot!,
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(10.0),
                                              child: SvgPicture.asset(
                                                user.selectedPlayer!.equipment!
                                                    .bodySlot!.item!.icon!,
                                                width: double.infinity,
                                                color: AppColors.white00,
                                              ),
                                            ),
                                            feedback: Container(
                                              height: widgetWidth / 4,
                                              width: widgetWidth / 4,
                                              decoration: BoxDecoration(
                                                border: Border.all(
                                                    width: 2,
                                                    color: _uiColor.setUIColor(
                                                        user.selectedPlayer!.id,
                                                        'primary')),
                                                shape: BoxShape.circle,
                                                color: Colors.black,
                                              ),
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: SvgPicture.asset(
                                                  user
                                                      .selectedPlayer!
                                                      .equipment!
                                                      .bodySlot!
                                                      .item!
                                                      .icon!,
                                                  width: double.infinity,
                                                  color: AppColors.white00,
                                                ),
                                              ),
                                            ),
                                          ),
                                  );
                                },
                                onWillAccept: (data) {
                                  if (data!.itemSlot == 'body') {
                                    return true;
                                  }
                                  return false;
                                },
                                onAccept: (data) {
                                  user.selectedPlayer!.equipment!.equip(
                                      game.id!,
                                      user.selectedPlayer!.id!,
                                      user.selectedPlayer!.equipment!.bodySlot!,
                                      data);
                                  setState(() {});
                                },
                              ),
                            )
                          ],
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            //OFF HAND
                            Expanded(
                              flex: 2,
                              child: DragTarget<Item>(
                                builder: (
                                  BuildContext context,
                                  List<dynamic> accepted,
                                  List<dynamic> rejected,
                                ) {
                                  return Container(
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                          color: _uiColor.setUIColor(
                                              user.selectedPlayer!.id,
                                              'primary'),
                                          width: 1,
                                        ),
                                      ),
                                      child: (user.selectedPlayer!.equipment!
                                              .offHandSlot!.isEmpty!)
                                          ? SvgPicture.asset(
                                              AppIcons.offHandSlot,
                                              width: double.infinity,
                                              color: _uiColor.setUIColor(
                                                  user.selectedPlayer!.id,
                                                  'primary'),
                                            )
                                          : Draggable<ItemSlot>(
                                              data: user.selectedPlayer!
                                                  .equipment!.offHandSlot!,
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(10.0),
                                                child: SvgPicture.asset(
                                                  user
                                                      .selectedPlayer!
                                                      .equipment!
                                                      .offHandSlot!
                                                      .item!
                                                      .icon!,
                                                  width: double.infinity,
                                                  color: AppColors.white00,
                                                ),
                                              ),
                                              feedback: Container(
                                                height: widgetWidth / 4,
                                                width: widgetWidth / 4,
                                                decoration: BoxDecoration(
                                                  border: Border.all(
                                                      width: 2,
                                                      color: _uiColor.setUIColor(
                                                          user.selectedPlayer!
                                                              .id,
                                                          'primary')),
                                                  shape: BoxShape.circle,
                                                  color: Colors.black,
                                                ),
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: SvgPicture.asset(
                                                    user
                                                        .selectedPlayer!
                                                        .equipment!
                                                        .offHandSlot!
                                                        .item!
                                                        .icon!,
                                                    width: double.infinity,
                                                    color: AppColors.white00,
                                                  ),
                                                ),
                                              ),
                                            ));
                                },
                                onWillAccept: (data) {
                                  if (data!.itemSlot == 'oneHand' ||
                                      data.itemSlot == 'twoHands') {
                                    return true;
                                  }
                                  return false;
                                },
                                onAccept: (data) {
                                  user.selectedPlayer!.equipment!.equip(
                                      game.id!,
                                      user.selectedPlayer!.id!,
                                      user.selectedPlayer!.equipment!
                                          .offHandSlot!,
                                      data);
                                  setState(() {});
                                },
                              ),
                            ),

                            //FEET

                            Expanded(
                              flex: 1,
                              child: DragTarget<Item>(
                                builder: (
                                  BuildContext context,
                                  List<dynamic> accepted,
                                  List<dynamic> rejected,
                                ) {
                                  return Container(
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        color: _uiColor.setUIColor(
                                            user.selectedPlayer!.id, 'primary'),
                                        width: 1,
                                      ),
                                    ),
                                    child: (user.selectedPlayer!.equipment!
                                            .feetSlot!.isEmpty!)
                                        ? SvgPicture.asset(
                                            AppIcons.feetSlot,
                                            width: double.infinity,
                                            color: _uiColor.setUIColor(
                                                user.selectedPlayer!.id,
                                                'primary'),
                                          )
                                        : Draggable<ItemSlot>(
                                            data: user.selectedPlayer!
                                                .equipment!.feetSlot!,
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(10.0),
                                              child: SvgPicture.asset(
                                                user.selectedPlayer!.equipment!
                                                    .feetSlot!.item!.icon!,
                                                width: double.infinity,
                                                color: AppColors.white00,
                                              ),
                                            ),
                                            feedback: Container(
                                              height: widgetWidth / 4,
                                              width: widgetWidth / 4,
                                              decoration: BoxDecoration(
                                                border: Border.all(
                                                    width: 2,
                                                    color: _uiColor.setUIColor(
                                                        user.selectedPlayer!.id,
                                                        'primary')),
                                                shape: BoxShape.circle,
                                                color: Colors.black,
                                              ),
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: SvgPicture.asset(
                                                  user
                                                      .selectedPlayer!
                                                      .equipment!
                                                      .feetSlot!
                                                      .item!
                                                      .icon!,
                                                  width: double.infinity,
                                                  color: AppColors.white00,
                                                ),
                                              ),
                                            ),
                                          ),
                                  );
                                },
                                onWillAccept: (data) {
                                  if (data!.itemSlot == 'feet') {
                                    return true;
                                  }
                                  return false;
                                },
                                onAccept: (data) {
                                  user.selectedPlayer!.equipment!.equip(
                                      game.id!,
                                      user.selectedPlayer!.id!,
                                      user.selectedPlayer!.equipment!.feetSlot!,
                                      data);
                                  setState(() {});
                                },
                              ),
                            )
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
                SizedBox(
                  height: widgetWidth / 3,
                  child: DragTarget<ItemSlot>(
                    builder: (
                      BuildContext context,
                      List<dynamic> accepted,
                      List<dynamic> rejected,
                    ) {
                      return Stack(children: [
                        GridView.count(
                          shrinkWrap: true,
                          crossAxisCount: 6,
                          children: List.generate(12, (index) {
                            return SvgPicture.asset(
                              AppIcons.bagSlot,
                              height: widgetWidth / 6,
                              width: widgetWidth / 6,
                              color: _uiColor.setUIColor(
                                  user.selectedPlayer!.id, 'primary'),
                            );
                          }),
                        ),
                        GridView.count(
                          shrinkWrap: true,
                          crossAxisCount: 6,
                          children: List.generate(
                              user.selectedPlayer!.equipment!.bag!.length,
                              (index) {
                            return Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 4),

                              child: Draggable<Item>(
                                data:
                                    user.selectedPlayer!.equipment!.bag![index],
                                feedback: Container(
                                  height: widgetWidth / 4,
                                  width: widgetWidth / 4,
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                        width: 2,
                                        color: _uiColor.setUIColor(
                                            user.selectedPlayer!.id,
                                            'primary')),
                                    shape: BoxShape.circle,
                                    color: Colors.black,
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(10),
                                    child: SvgPicture.asset(
                                      user.selectedPlayer!.equipment!
                                          .bag![index].icon!,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                                childWhenDragging: Padding(
                                  padding: const EdgeInsets.all(5),
                                  child: SvgPicture.asset(
                                    user.selectedPlayer!.equipment!.bag![index]
                                        .icon!,
                                    color: Colors.grey,
                                  ),
                                ),
                                child: SvgPicture.asset(
                                  user.selectedPlayer!.equipment!.bag![index]
                                      .icon!,
                                  color: Colors.white,
                                ),
                              ),

                              // child: GestureDetector(
                              //   onLongPress: () {
                              //     user.selectedPlayer!.equipment!.destroyItem(
                              //         game.id!,
                              //         user.selectedPlayer!.id!,
                              //         user.selectedPlayer!.equipment!.bag![index]);
                              //     refresh();
                              //   },
                              //   onTap: () {
                              //     showDialog(
                              //       context: context,
                              //       builder: (BuildContext context) {
                              //         return (user.selectedPlayer!.equipment!
                              //                     .bag![index].itemSlot ==
                              //                 'consumable')
                              //             ? ItemDetailPage(
                              //                 playerID: user.selectedPlayer!.id,
                              //                 outOfActions: user
                              //                     .selectedPlayer!.action!
                              //                     .outOfActions(),
                              //                 item: user.selectedPlayer!.equipment!
                              //                     .bag![index],
                              //                 buttonText: 'use',
                              //                 useEquipOrUnequip: () async {
                              //                   user.selectedPlayer!.useItem(
                              //                       game.id!,
                              //                       user.selectedPlayer!.equipment!
                              //                           .bag![index]);

                              //                   user.selectedPlayer!.action!
                              //                       .takeAction(
                              //                     game.id!,
                              //                     user.selectedPlayer!.id!,
                              //                   );

                              //                   if (user.selectedPlayer!.action!
                              //                       .outOfActions()) {
                              //                     game.round!.passTurn(game.id!,
                              //                         user.selectedPlayer!.id!);
                              //                   }
                              //                   Navigator.pop(context);

                              //                   refresh();
                              //                 },
                              //               )
                              //             : ItemDetailPage(
                              //                 playerID: user.selectedPlayer!.id,
                              //                 outOfActions: user
                              //                     .selectedPlayer!.action!
                              //                     .outOfActions(),
                              //                 item: user.selectedPlayer!.equipment!
                              //                     .bag![index],
                              //                 buttonText: 'equip',
                              //                 useEquipOrUnequip: () async {
                              //                   user.selectedPlayer!.equipment!
                              //                       .equip(
                              //                           game.id!,
                              //                           user.selectedPlayer!.id!,
                              //                           user
                              //                               .selectedPlayer!
                              //                               .equipment!
                              //                               .bag![index]);

                              //                   refresh();
                              //                 },
                              //               );
                              //       },
                              //     );
                              //   },
                              //   onDoubleTap: () {
                              //     if ((user.selectedPlayer!.equipment!.bag![index]
                              //             .itemSlot ==
                              //         'consumable')) {
                              //       user.selectedPlayer!.useItem(
                              //           game.id!,
                              //           user.selectedPlayer!.equipment!
                              //               .bag![index]);

                              //       user.selectedPlayer!.action!.takeAction(
                              //         game.id!,
                              //         user.selectedPlayer!.id!,
                              //       );

                              //       if (user.selectedPlayer!.action!
                              //           .outOfActions()) {
                              //         game.round!.passTurn(
                              //             game.id!, user.selectedPlayer!.id!);
                              //       }

                              //       Navigator.pop(context);
                              //     } else {
                              //       user.selectedPlayer!.equipment!.equip(
                              //           game.id!,
                              //           user.selectedPlayer!.id!,
                              //           user.selectedPlayer!.equipment!
                              //               .bag![index]);
                              //     }

                              //     refresh();
                              //   },
                              //   child: SvgPicture.asset(
                              //     user.selectedPlayer!.equipment!.bag![index].icon!,
                              //     color: Colors.white,
                              //   ),
                              // ),
                            );
                          }),
                        ),
                      ]);
                    },
                    onWillAccept: (data) {
                      return true;
                    },
                    onAccept: (data) {
                      user.selectedPlayer!.equipment!
                          .unequip(game.id!, user.selectedPlayer!.id!, data);
                      setState(() {});
                    },
                  ),
                ),
                Divider(
                  height: 0,
                  thickness: 2,
                  color:
                      _uiColor.setUIColor(user.selectedPlayer!.id, 'primary'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
