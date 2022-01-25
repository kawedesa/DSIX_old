import 'package:dsixv02app/models/game/game.dart';
import 'package:dsixv02app/shared/app_Colors.dart';
import 'package:dsixv02app/shared/app_Exceptions.dart';
import 'package:dsixv02app/shared/app_Icons.dart';
import 'package:dsixv02app/shared/widgets/uiColor.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import '../player/player.dart';
import '../player/equipment/equipmentSlot.dart';
import '../player/equipment/widget/equipmentStats.dart';
import 'chest.dart';

class ChestPage extends StatefulWidget {
  final Player? player;
  final Chest? chest;
  const ChestPage({
    Key? key,
    @required this.player,
    this.chest,
  }) : super(key: key);

  @override
  State<ChestPage> createState() => _ChestPageState();
}

class _ChestPageState extends State<ChestPage> {
  UIColor _uiColor = UIColor();
  refresh() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final game = Provider.of<Game>(context);
    double widgetWidth = MediaQuery.of(context).size.width * 0.8;

    return AlertDialog(
      contentPadding: EdgeInsets.fromLTRB(0, 0, 0, 0),
      content: Container(
        width: widgetWidth,
        decoration: BoxDecoration(
          color: AppColors.black00,
          border: Border.all(
            color: _uiColor.setUIColor(widget.player!.id, 'primary'),
            width: 2,
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              height: MediaQuery.of(context).size.height * 0.05,
              color: _uiColor.setUIColor(widget.player!.id, 'primary'),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(30, 5, 30, 7),
                child: Center(
                  child: Text('equipment'.toUpperCase(),
                      style: TextStyle(
                        fontFamily: 'Santana',
                        height: 1,
                        fontSize: 25,
                        color:
                            _uiColor.setUIColor(widget.player!.id, 'secondary'),
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
                      child: EquipmentStats(
                        playerID: widget.player!.id,
                        pDamage: widget.player!.equipment!.damage!.pDamage,
                        mDamage: widget.player!.equipment!.damage!.mDamage,
                        pArmor: widget.player!.equipment!.armor!.pArmor,
                        mArmor: widget.player!.equipment!.armor!.mArmor,
                        maxWeight: widget.player!.equipment!.weight!.max,
                        currentWeight:
                            widget.player!.equipment!.weight!.current,
                      )),
                ),
                Divider(
                  height: 0,
                  thickness: 2,
                  color: _uiColor.setUIColor(widget.player!.id, 'primary'),
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
                              child: DragTarget<EquipmentSlot>(
                                builder: (
                                  BuildContext context,
                                  List<dynamic> accepted,
                                  List<dynamic> rejected,
                                ) {
                                  return Container(
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                          color: _uiColor.setUIColor(
                                              widget.player!.id, 'primary'),
                                          width: 1,
                                        ),
                                      ),
                                      child: (widget.player!.equipment!
                                                  .mainHandSlot!.item!.name! ==
                                              '')
                                          ? SvgPicture.asset(
                                              AppIcons.mainHandSlot,
                                              width: double.infinity,
                                              color: _uiColor.setUIColor(
                                                  widget.player!.id, 'primary'),
                                            )
                                          : Draggable<EquipmentSlot>(
                                              data: widget.player!.equipment!
                                                  .mainHandSlot!,
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(10.0),
                                                child: SvgPicture.asset(
                                                  widget
                                                      .player!
                                                      .equipment!
                                                      .mainHandSlot!
                                                      .item!
                                                      .icon!,
                                                  width: double.infinity,
                                                  color: AppColors.white00,
                                                ),
                                              ),
                                              onDragCompleted: () {
                                                setState(() {
                                                  widget.player!.emptySlot(
                                                      widget.player!.equipment!
                                                          .mainHandSlot!);
                                                });
                                              },
                                              feedback: Padding(
                                                padding:
                                                    const EdgeInsets.fromLTRB(
                                                        50, 75, 0, 0),
                                                child: Container(
                                                  height: widgetWidth / 4,
                                                  width: widgetWidth / 4,
                                                  decoration: BoxDecoration(
                                                    border: Border.all(
                                                        width: 2,
                                                        color:
                                                            _uiColor.setUIColor(
                                                                widget
                                                                    .player!.id,
                                                                'primary')),
                                                    shape: BoxShape.circle,
                                                    color: Colors.black,
                                                  ),
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    child: SvgPicture.asset(
                                                      widget
                                                          .player!
                                                          .equipment!
                                                          .mainHandSlot!
                                                          .item!
                                                          .icon!,
                                                      width: double.infinity,
                                                      color: AppColors.white00,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ));
                                },
                                onWillAccept: (data) {
                                  if (data!.item!.itemSlot != 'oneHand' &&
                                      data.item!.itemSlot != 'twoHands') {
                                    return false;
                                  }

                                  if (data.name == 'offHandSlot') {
                                    return false;
                                  }

                                  if (data.name == 'chest') {
                                    if (widget.player!.equipment!.weight!
                                        .cantCarry(data.item!.weight!)) {
                                      return false;
                                    }
                                  }

                                  return true;
                                },
                                onAccept: (data) {
                                  if (data.name == 'chest') {
                                    widget.player!.getItem(data.item!);
                                  }
                                  widget.player!.equipItem(
                                    widget.player!.equipment!.mainHandSlot!,
                                    data,
                                  );

                                  setState(() {});
                                },
                              ),
                            ),

                            //HANDS

                            Expanded(
                              flex: 1,
                              child: DragTarget<EquipmentSlot>(
                                builder: (
                                  BuildContext context,
                                  List<dynamic> accepted,
                                  List<dynamic> rejected,
                                ) {
                                  return Container(
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        color: _uiColor.setUIColor(
                                            widget.player!.id, 'primary'),
                                        width: 1,
                                      ),
                                    ),
                                    child: (widget.player!.equipment!.handSlot!
                                                .item!.name! ==
                                            '')
                                        ? SvgPicture.asset(
                                            AppIcons.handSlot,
                                            width: double.infinity,
                                            color: _uiColor.setUIColor(
                                                widget.player!.id, 'primary'),
                                          )
                                        : Draggable<EquipmentSlot>(
                                            data: widget
                                                .player!.equipment!.handSlot!,
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(10.0),
                                              child: SvgPicture.asset(
                                                widget.player!.equipment!
                                                    .handSlot!.item!.icon!,
                                                width: double.infinity,
                                                color: AppColors.white00,
                                              ),
                                            ),
                                            onDragCompleted: () {
                                              setState(() {
                                                widget.player!.emptySlot(widget
                                                    .player!
                                                    .equipment!
                                                    .handSlot!);
                                              });
                                            },
                                            feedback: Container(
                                              height: widgetWidth / 4,
                                              width: widgetWidth / 4,
                                              decoration: BoxDecoration(
                                                border: Border.all(
                                                    width: 2,
                                                    color: _uiColor.setUIColor(
                                                        widget.player!.id,
                                                        'primary')),
                                                shape: BoxShape.circle,
                                                color: Colors.black,
                                              ),
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: SvgPicture.asset(
                                                  widget.player!.equipment!
                                                      .handSlot!.item!.icon!,
                                                  width: double.infinity,
                                                  color: AppColors.white00,
                                                ),
                                              ),
                                            ),
                                          ),
                                  );
                                },
                                onWillAccept: (data) {
                                  if (data!.item!.itemSlot != 'hands') {
                                    return false;
                                  }

                                  if (data.name == 'chest') {
                                    if (widget.player!.equipment!.weight!
                                        .cantCarry(data.item!.weight!)) {
                                      return false;
                                    }
                                  }
                                  return true;
                                },
                                onAccept: (data) {
                                  if (data.name == 'chest') {
                                    widget.player!.getItem(data.item!);
                                  }
                                  widget.player!.equipItem(
                                      widget.player!.equipment!.handSlot!,
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
                              child: DragTarget<EquipmentSlot>(
                                builder: (
                                  BuildContext context,
                                  List<dynamic> accepted,
                                  List<dynamic> rejected,
                                ) {
                                  return Container(
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                          color: _uiColor.setUIColor(
                                              widget.player!.id, 'primary'),
                                          width: 1,
                                        ),
                                      ),
                                      child: (widget.player!.equipment!
                                                  .headSlot!.item!.name! ==
                                              '')
                                          ? SvgPicture.asset(
                                              AppIcons.headSlot,
                                              width: double.infinity,
                                              color: _uiColor.setUIColor(
                                                  widget.player!.id, 'primary'),
                                            )
                                          : Draggable<EquipmentSlot>(
                                              data: widget
                                                  .player!.equipment!.headSlot!,
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(10.0),
                                                child: SvgPicture.asset(
                                                  widget.player!.equipment!
                                                      .headSlot!.item!.icon!,
                                                  width: double.infinity,
                                                  color: AppColors.white00,
                                                ),
                                              ),
                                              onDragCompleted: () {
                                                setState(() {
                                                  widget.player!.emptySlot(
                                                      widget.player!.equipment!
                                                          .headSlot!);
                                                });
                                              },
                                              feedback: Container(
                                                height: widgetWidth / 4,
                                                width: widgetWidth / 4,
                                                decoration: BoxDecoration(
                                                  border: Border.all(
                                                      width: 2,
                                                      color:
                                                          _uiColor.setUIColor(
                                                              widget.player!.id,
                                                              'primary')),
                                                  shape: BoxShape.circle,
                                                  color: Colors.black,
                                                ),
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: SvgPicture.asset(
                                                    widget.player!.equipment!
                                                        .headSlot!.item!.icon!,
                                                    width: double.infinity,
                                                    color: AppColors.white00,
                                                  ),
                                                ),
                                              ),
                                            ));
                                },
                                onWillAccept: (data) {
                                  if (data!.item!.itemSlot != 'head') {
                                    return false;
                                  }

                                  if (data.name == 'chest') {
                                    if (widget.player!.equipment!.weight!
                                        .cantCarry(data.item!.weight!)) {
                                      return false;
                                    }
                                  }

                                  return true;
                                },
                                onAccept: (data) {
                                  if (data.name == 'chest') {
                                    widget.player!.getItem(data.item!);
                                  }
                                  widget.player!.equipItem(
                                      widget.player!.equipment!.headSlot!,
                                      data);
                                  setState(() {});
                                },
                              ),
                            ),

                            //BODY

                            Expanded(
                              flex: 2,
                              child: DragTarget<EquipmentSlot>(
                                builder: (
                                  BuildContext context,
                                  List<dynamic> accepted,
                                  List<dynamic> rejected,
                                ) {
                                  return Container(
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        color: _uiColor.setUIColor(
                                            widget.player!.id, 'primary'),
                                        width: 1,
                                      ),
                                    ),
                                    child: (widget.player!.equipment!.bodySlot!
                                                .item!.name! ==
                                            '')
                                        ? SvgPicture.asset(
                                            AppIcons.bodySlot,
                                            width: double.infinity,
                                            color: _uiColor.setUIColor(
                                                widget.player!.id, 'primary'),
                                          )
                                        : Draggable<EquipmentSlot>(
                                            data: widget
                                                .player!.equipment!.bodySlot!,
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(10.0),
                                              child: SvgPicture.asset(
                                                widget.player!.equipment!
                                                    .bodySlot!.item!.icon!,
                                                width: double.infinity,
                                                color: AppColors.white00,
                                              ),
                                            ),
                                            onDragCompleted: () {
                                              setState(() {
                                                widget.player!.emptySlot(widget
                                                    .player!
                                                    .equipment!
                                                    .bodySlot!);
                                              });
                                            },
                                            feedback: Container(
                                              height: widgetWidth / 4,
                                              width: widgetWidth / 4,
                                              decoration: BoxDecoration(
                                                border: Border.all(
                                                    width: 2,
                                                    color: _uiColor.setUIColor(
                                                        widget.player!.id,
                                                        'primary')),
                                                shape: BoxShape.circle,
                                                color: Colors.black,
                                              ),
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: SvgPicture.asset(
                                                  widget.player!.equipment!
                                                      .bodySlot!.item!.icon!,
                                                  width: double.infinity,
                                                  color: AppColors.white00,
                                                ),
                                              ),
                                            ),
                                          ),
                                  );
                                },
                                onWillAccept: (data) {
                                  if (data!.item!.itemSlot != 'body') {
                                    return false;
                                  }

                                  if (data.name == 'chest') {
                                    if (widget.player!.equipment!.weight!
                                        .cantCarry(data.item!.weight!)) {
                                      return false;
                                    }
                                  }
                                  return true;
                                },
                                onAccept: (data) {
                                  if (data.name == 'chest') {
                                    widget.player!.getItem(data.item!);
                                  }
                                  widget.player!.equipItem(
                                      widget.player!.equipment!.bodySlot!,
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
                              child: DragTarget<EquipmentSlot>(
                                builder: (
                                  BuildContext context,
                                  List<dynamic> accepted,
                                  List<dynamic> rejected,
                                ) {
                                  return Container(
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                          color: _uiColor.setUIColor(
                                              widget.player!.id, 'primary'),
                                          width: 1,
                                        ),
                                      ),
                                      child: (widget.player!.equipment!
                                                  .offHandSlot!.item!.name! ==
                                              '')
                                          ? SvgPicture.asset(
                                              AppIcons.offHandSlot,
                                              width: double.infinity,
                                              color: _uiColor.setUIColor(
                                                  widget.player!.id, 'primary'),
                                            )
                                          : Draggable<EquipmentSlot>(
                                              data: widget.player!.equipment!
                                                  .offHandSlot!,
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(10.0),
                                                child: SvgPicture.asset(
                                                  widget.player!.equipment!
                                                      .offHandSlot!.item!.icon!,
                                                  width: double.infinity,
                                                  color: AppColors.white00,
                                                ),
                                              ),
                                              onDragCompleted: () {
                                                setState(() {
                                                  widget.player!.emptySlot(
                                                      widget.player!.equipment!
                                                          .offHandSlot!);
                                                });
                                              },
                                              feedback: Padding(
                                                padding:
                                                    const EdgeInsets.fromLTRB(
                                                        50, 75, 0, 0),
                                                child: Container(
                                                  height: widgetWidth / 4,
                                                  width: widgetWidth / 4,
                                                  decoration: BoxDecoration(
                                                    border: Border.all(
                                                        width: 2,
                                                        color:
                                                            _uiColor.setUIColor(
                                                                widget
                                                                    .player!.id,
                                                                'primary')),
                                                    shape: BoxShape.circle,
                                                    color: Colors.black,
                                                  ),
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    child: SvgPicture.asset(
                                                      widget
                                                          .player!
                                                          .equipment!
                                                          .offHandSlot!
                                                          .item!
                                                          .icon!,
                                                      width: double.infinity,
                                                      color: AppColors.white00,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ));
                                },
                                onWillAccept: (data) {
                                  if (data!.item!.itemSlot != 'oneHand' &&
                                      data.item!.itemSlot != 'twoHands') {
                                    return false;
                                  }
                                  if (data.name == 'mainHandSlot') {
                                    return false;
                                  }

                                  if (data.name == 'chest') {
                                    if (widget.player!.equipment!.weight!
                                        .cantCarry(data.item!.weight!)) {
                                      return false;
                                    }
                                  }

                                  return true;
                                },
                                onAccept: (data) {
                                  if (data.name == 'chest') {
                                    widget.player!.getItem(data.item!);
                                  }
                                  widget.player!.equipItem(
                                    widget.player!.equipment!.offHandSlot!,
                                    data,
                                  );

                                  setState(() {});
                                },
                              ),
                            ),

                            //FEET

                            Expanded(
                              flex: 1,
                              child: DragTarget<EquipmentSlot>(
                                builder: (
                                  BuildContext context,
                                  List<dynamic> accepted,
                                  List<dynamic> rejected,
                                ) {
                                  return Container(
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        color: _uiColor.setUIColor(
                                            widget.player!.id, 'primary'),
                                        width: 1,
                                      ),
                                    ),
                                    child: (widget.player!.equipment!.feetSlot!
                                                .item!.name! ==
                                            '')
                                        ? SvgPicture.asset(
                                            AppIcons.feetSlot,
                                            width: double.infinity,
                                            color: _uiColor.setUIColor(
                                                widget.player!.id, 'primary'),
                                          )
                                        : Draggable<EquipmentSlot>(
                                            data: widget
                                                .player!.equipment!.feetSlot!,
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(10.0),
                                              child: SvgPicture.asset(
                                                widget.player!.equipment!
                                                    .feetSlot!.item!.icon!,
                                                width: double.infinity,
                                                color: AppColors.white00,
                                              ),
                                            ),
                                            onDragCompleted: () {
                                              setState(() {
                                                widget.player!.emptySlot(widget
                                                    .player!
                                                    .equipment!
                                                    .feetSlot!);
                                              });
                                            },
                                            feedback: Container(
                                              height: widgetWidth / 4,
                                              width: widgetWidth / 4,
                                              decoration: BoxDecoration(
                                                border: Border.all(
                                                    width: 2,
                                                    color: _uiColor.setUIColor(
                                                        widget.player!.id,
                                                        'primary')),
                                                shape: BoxShape.circle,
                                                color: Colors.black,
                                              ),
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: SvgPicture.asset(
                                                  widget.player!.equipment!
                                                      .feetSlot!.item!.icon!,
                                                  width: double.infinity,
                                                  color: AppColors.white00,
                                                ),
                                              ),
                                            ),
                                          ),
                                  );
                                },
                                onWillAccept: (data) {
                                  if (data!.item!.itemSlot != 'feet') {
                                    return false;
                                  }

                                  if (data.name == 'chest') {
                                    if (widget.player!.equipment!.weight!
                                        .cantCarry(data.item!.weight!)) {
                                      return false;
                                    }
                                  }

                                  return true;
                                },
                                onAccept: (data) {
                                  if (data.name == 'chest') {
                                    widget.player!.getItem(data.item!);
                                  }
                                  widget.player!.equipItem(
                                      widget.player!.equipment!.feetSlot!,
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
                  color: _uiColor.setUIColor(widget.player!.id, 'primary'),
                  child: Center(
                    child: Text('bag'.toUpperCase(),
                        style: TextStyle(
                          fontFamily: 'Santana',
                          height: 1,
                          fontSize: 25,
                          color: _uiColor.setUIColor(
                              widget.player!.id, 'secondary'),
                          fontWeight: FontWeight.bold,
                          letterSpacing: 3,
                        )),
                  ),
                ),
                SizedBox(
                  height: widgetWidth / 3,
                  child: DragTarget<EquipmentSlot>(
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
                                  widget.player!.id, 'primary'),
                            );
                          }),
                        ),
                        GridView.count(
                          shrinkWrap: true,
                          crossAxisCount: 6,
                          children: List.generate(
                              widget.player!.equipment!.bag!.length, (index) {
                            return Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 4),
                              child: Draggable<EquipmentSlot>(
                                data: widget.player!.equipment!.bag![index],
                                feedback: Container(
                                  height: widgetWidth / 4,
                                  width: widgetWidth / 4,
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                        width: 2,
                                        color: _uiColor.setUIColor(
                                            widget.player!.id, 'primary')),
                                    shape: BoxShape.circle,
                                    color: Colors.black,
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(10),
                                    child: SvgPicture.asset(
                                      widget.player!.equipment!.bag![index]
                                          .item!.icon!,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                                onDragCompleted: () {
                                  setState(() {
                                    widget.player!.removeItemFromBag(
                                        widget.player!.equipment!.bag![index]);
                                  });
                                },
                                childWhenDragging: Padding(
                                  padding: const EdgeInsets.all(5),
                                  child: SvgPicture.asset(
                                    widget.player!.equipment!.bag![index].item!
                                        .icon!,
                                    color: Colors.grey,
                                  ),
                                ),
                                child: GestureDetector(
                                  onDoubleTap: () {
                                    try {
                                      widget.player!.action!.takeAction(
                                        game.id!,
                                        widget.player!.id!,
                                      );
                                    } on EndPlayerTurnException {
                                      game.round!
                                          .passTurn(game.id!, widget.player!);
                                    }
                                    setState(() {});
                                  },
                                  child: SvgPicture.asset(
                                    widget.player!.equipment!.bag![index].item!
                                        .icon!,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            );
                          }),
                        ),
                      ]);
                    },
                    onWillAccept: (data) {
                      if (data!.name == 'bag') {
                        return false;
                      }

                      if (widget.player!.equipment!.bag!.length == 12) {
                        return false;
                      }

                      if (data.name == 'chest') {
                        if (widget.player!.equipment!.weight!
                            .cantCarry(data.item!.weight!)) {
                          return false;
                        }
                      }

                      return true;
                    },
                    onAccept: (data) {
                      if (data.name == 'chest') {
                        widget.player!.getItem(data.item!);
                      }

                      widget.player!.addItemToBag(data.item!);
                    },
                  ),
                ),
                Divider(
                  height: 0,
                  thickness: 2,
                  color: _uiColor.setUIColor(widget.player!.id, 'primary'),
                ),
                (widget.chest == null)
                    ? SizedBox()
                    : Column(
                        children: [
                          Container(
                            height: MediaQuery.of(context).size.height * 0.05,
                            color: _uiColor.setUIColor(
                                widget.player!.id, 'primary'),
                            child: Center(
                              child: Text('chest'.toUpperCase(),
                                  style: TextStyle(
                                    fontFamily: 'Santana',
                                    height: 1,
                                    fontSize: 25,
                                    color: _uiColor.setUIColor(
                                        widget.player!.id, 'secondary'),
                                    fontWeight: FontWeight.bold,
                                    letterSpacing: 3,
                                  )),
                            ),
                          ),
                          SizedBox(
                            height: widgetWidth / 6,
                            child: DragTarget<EquipmentSlot>(
                              builder: (
                                BuildContext context,
                                List<dynamic> accepted,
                                List<dynamic> rejected,
                              ) {
                                return Stack(children: [
                                  GridView.count(
                                    shrinkWrap: true,
                                    crossAxisCount: 6,
                                    children: List.generate(6, (index) {
                                      return SvgPicture.asset(
                                        AppIcons.bagSlot,
                                        height: widgetWidth / 6,
                                        width: widgetWidth / 6,
                                        color: _uiColor.setUIColor(
                                            widget.player!.id, 'primary'),
                                      );
                                    }),
                                  ),
                                  GridView.count(
                                    shrinkWrap: true,
                                    crossAxisCount: 6,
                                    children: List.generate(
                                        widget.chest!.loot!.length, (index) {
                                      return Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 4),
                                        child: Draggable<EquipmentSlot>(
                                          data: EquipmentSlot.fromItem('chest',
                                              widget.chest!.loot![index]),
                                          feedback: Container(
                                            height: widgetWidth / 4,
                                            width: widgetWidth / 4,
                                            decoration: BoxDecoration(
                                              border: Border.all(
                                                  width: 2,
                                                  color: _uiColor.setUIColor(
                                                      widget.player!.id,
                                                      'primary')),
                                              shape: BoxShape.circle,
                                              color: Colors.black,
                                            ),
                                            child: Padding(
                                              padding: const EdgeInsets.all(10),
                                              child: SvgPicture.asset(
                                                widget
                                                    .chest!.loot![index].icon!,
                                                color: Colors.white,
                                              ),
                                            ),
                                          ),
                                          onDragCompleted: () {
                                            setState(() {
                                              widget.chest!.removeItem(
                                                  widget.chest!.loot![index]);
                                            });
                                          },
                                          childWhenDragging: Padding(
                                            padding: const EdgeInsets.all(5),
                                            child: SvgPicture.asset(
                                              widget.chest!.loot![index].icon!,
                                              color: Colors.grey,
                                            ),
                                          ),
                                          child: SvgPicture.asset(
                                            widget.chest!.loot![index].icon!,
                                            color: Colors.white,
                                          ),
                                        ),
                                      );
                                    }),
                                  ),
                                ]);
                              },
                              onWillAccept: (data) {
                                if (data!.name == 'chest') {
                                  return false;
                                }
                                if (widget.chest!.loot!.length == 6) {
                                  return false;
                                }
                                return true;
                              },
                              onAccept: (data) {
                                widget.player!.removeItem(data);
                                widget.chest!.getItem(data.item!);
                                setState(() {});
                              },
                            ),
                          ),
                          Divider(
                            height: 0,
                            thickness: 2,
                            color: _uiColor.setUIColor(
                                widget.player!.id, 'primary'),
                          ),
                        ],
                      ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
