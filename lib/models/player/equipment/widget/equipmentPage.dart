import 'package:dsixv02app/models/chest/chest.dart';
import 'package:dsixv02app/models/game/game.dart';
import 'package:dsixv02app/models/player/equipment/widget/itemDetailPage.dart';
import 'package:dsixv02app/shared/app_Colors.dart';

import 'package:dsixv02app/shared/app_Icons.dart';
import 'package:dsixv02app/shared/widgets/uiColor.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import '../../player.dart';
import '../equipmentSlot.dart';
import 'equipmentStats.dart';

class EquipmentPage extends StatefulWidget {
  final Player? player;
  final Chest? chest;

  const EquipmentPage({
    Key? key,
    @required this.player,
    this.chest,
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
            DialogTitle(id: widget.player!.id, tittle: 'equipment'),
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  height: MediaQuery.of(context).size.height * 0.07,
                  child: SizedBox(
                      width: MediaQuery.of(context).size.width * 0.7,
                      child: EquipmentStats(
                        player: widget.player,
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
                              child: EquipmentPageSlot(
                                id: widget.player!.id,
                                widgetWidth: widgetWidth,
                                slotIcon: AppIcons.mainHandSlot,
                                slot: widget.player!.equipment!.mainHandSlot,
                                onDragCompleted: () async {
                                  setState(() {
                                    widget.player!.emptySlot(widget
                                        .player!.equipment!.mainHandSlot!);
                                  });
                                },
                                onWillAccept: (data) {
                                  if (data!.item!.itemSlot != 'oneHand' &&
                                      data.item!.itemSlot != 'twoHands') {
                                    return false;
                                  }

                                  if (data.name == 'offHandSlot') {
                                    return false;
                                  }

                                  if (widget.chest == null &&
                                      widget.player!.action!.outOfActions()) {
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(
                                          SnackBar(
                                            backgroundColor: _uiColor
                                                .setUIColor('error', 'primary'),
                                            content: EquipmentAlert(
                                              title: 'wait for your turn',
                                            ),
                                            duration:
                                                const Duration(seconds: 3),
                                            animation:
                                                AlwaysStoppedAnimation<double>(
                                                    20),
                                          ),
                                        )
                                        .closed
                                        .then((value) =>
                                            ScaffoldMessenger.of(context)
                                                .clearSnackBars());
                                    return false;
                                  }

                                  if (data.name == 'chest') {
                                    if (widget.player!.equipment!.weight!
                                        .cantCarry(data.item!.weight!)) {
                                      return false;
                                    } else {
                                      return true;
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
                              child: EquipmentPageSlot(
                                id: widget.player!.id,
                                widgetWidth: widgetWidth,
                                slotIcon: AppIcons.handSlot,
                                slot: widget.player!.equipment!.handSlot,
                                onDragCompleted: () {
                                  setState(() {
                                    widget.player!.emptySlot(
                                        widget.player!.equipment!.handSlot!);
                                  });
                                },
                                onWillAccept: (data) {
                                  if (data!.item!.itemSlot != 'hands') {
                                    return false;
                                  }

                                  if (widget.chest == null &&
                                      widget.player!.action!.outOfActions()) {
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(
                                          SnackBar(
                                            backgroundColor: _uiColor
                                                .setUIColor('error', 'primary'),
                                            content: EquipmentAlert(
                                              title: 'wait for your turn',
                                            ),
                                            duration:
                                                const Duration(seconds: 3),
                                            animation:
                                                AlwaysStoppedAnimation<double>(
                                                    20),
                                          ),
                                        )
                                        .closed
                                        .then((value) =>
                                            ScaffoldMessenger.of(context)
                                                .clearSnackBars());
                                    return false;
                                  }

                                  if (data.name == 'chest') {
                                    if (widget.player!.equipment!.weight!
                                        .cantCarry(data.item!.weight!)) {
                                      return false;
                                    } else {
                                      return true;
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
                              child: EquipmentPageSlot(
                                id: widget.player!.id,
                                widgetWidth: widgetWidth,
                                slotIcon: AppIcons.headSlot,
                                slot: widget.player!.equipment!.headSlot,
                                onDragCompleted: () {
                                  setState(() {
                                    widget.player!.emptySlot(
                                        widget.player!.equipment!.headSlot!);
                                  });
                                },
                                onWillAccept: (data) {
                                  if (data!.item!.itemSlot != 'head') {
                                    return false;
                                  }

                                  if (widget.chest == null &&
                                      widget.player!.action!.outOfActions()) {
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(
                                          SnackBar(
                                            backgroundColor: _uiColor
                                                .setUIColor('error', 'primary'),
                                            content: EquipmentAlert(
                                              title: 'wait for your turn',
                                            ),
                                            duration:
                                                const Duration(seconds: 3),
                                            animation:
                                                AlwaysStoppedAnimation<double>(
                                                    20),
                                          ),
                                        )
                                        .closed
                                        .then((value) =>
                                            ScaffoldMessenger.of(context)
                                                .clearSnackBars());
                                    return false;
                                  }

                                  if (data.name == 'chest') {
                                    if (widget.player!.equipment!.weight!
                                        .cantCarry(data.item!.weight!)) {
                                      return false;
                                    } else {
                                      return true;
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
                              child: EquipmentPageSlot(
                                id: widget.player!.id,
                                widgetWidth: widgetWidth,
                                slotIcon: AppIcons.bodySlot,
                                slot: widget.player!.equipment!.bodySlot,
                                onDragCompleted: () {
                                  setState(() {
                                    widget.player!.emptySlot(
                                        widget.player!.equipment!.bodySlot!);
                                  });
                                },
                                onWillAccept: (data) {
                                  if (data!.item!.itemSlot != 'body') {
                                    return false;
                                  }

                                  if (widget.chest == null &&
                                      widget.player!.action!.outOfActions()) {
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(
                                          SnackBar(
                                            backgroundColor: _uiColor
                                                .setUIColor('error', 'primary'),
                                            content: EquipmentAlert(
                                              title: 'wait for your turn',
                                            ),
                                            duration:
                                                const Duration(seconds: 3),
                                            animation:
                                                AlwaysStoppedAnimation<double>(
                                                    20),
                                          ),
                                        )
                                        .closed
                                        .then((value) =>
                                            ScaffoldMessenger.of(context)
                                                .clearSnackBars());
                                    return false;
                                  }

                                  if (data.name == 'chest') {
                                    if (widget.player!.equipment!.weight!
                                        .cantCarry(data.item!.weight!)) {
                                      return false;
                                    } else {
                                      return true;
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
                              child: EquipmentPageSlot(
                                id: widget.player!.id,
                                widgetWidth: widgetWidth,
                                slotIcon: AppIcons.offHandSlot,
                                slot: widget.player!.equipment!.offHandSlot,
                                onDragCompleted: () async {
                                  setState(() {
                                    widget.player!.emptySlot(
                                        widget.player!.equipment!.offHandSlot!);
                                  });
                                },
                                onWillAccept: (data) {
                                  if (data!.item!.itemSlot != 'oneHand' &&
                                      data.item!.itemSlot != 'twoHands') {
                                    return false;
                                  }

                                  if (data.name == 'mainHandSlot') {
                                    return false;
                                  }

                                  if (widget.chest == null &&
                                      widget.player!.action!.outOfActions()) {
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(
                                          SnackBar(
                                            backgroundColor: _uiColor
                                                .setUIColor('error', 'primary'),
                                            content: EquipmentAlert(
                                              title: 'wait for your turn',
                                            ),
                                            duration:
                                                const Duration(seconds: 3),
                                            animation:
                                                AlwaysStoppedAnimation<double>(
                                                    20),
                                          ),
                                        )
                                        .closed
                                        .then((value) =>
                                            ScaffoldMessenger.of(context)
                                                .clearSnackBars());
                                    return false;
                                  }

                                  if (data.name == 'chest') {
                                    if (widget.player!.equipment!.weight!
                                        .cantCarry(data.item!.weight!)) {
                                      return false;
                                    } else {
                                      return true;
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
                              child: EquipmentPageSlot(
                                id: widget.player!.id,
                                widgetWidth: widgetWidth,
                                slotIcon: AppIcons.feetSlot,
                                slot: widget.player!.equipment!.feetSlot,
                                onDragCompleted: () {
                                  setState(() {
                                    widget.player!.emptySlot(
                                        widget.player!.equipment!.feetSlot!);
                                  });
                                },
                                onWillAccept: (data) {
                                  if (data!.item!.itemSlot != 'feet') {
                                    return false;
                                  }

                                  if (widget.chest == null &&
                                      widget.player!.action!.outOfActions()) {
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(
                                          SnackBar(
                                            backgroundColor: _uiColor
                                                .setUIColor('error', 'primary'),
                                            content: EquipmentAlert(
                                              title: 'wait for your turn',
                                            ),
                                            duration:
                                                const Duration(seconds: 3),
                                            animation:
                                                AlwaysStoppedAnimation<double>(
                                                    20),
                                          ),
                                        )
                                        .closed
                                        .then((value) =>
                                            ScaffoldMessenger.of(context)
                                                .clearSnackBars());
                                    return false;
                                  }

                                  if (data.name == 'chest') {
                                    if (widget.player!.equipment!.weight!
                                        .cantCarry(data.item!.weight!)) {
                                      return false;
                                    } else {
                                      return true;
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
                DialogTitle(id: widget.player!.id, tittle: 'bag'),
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
                            return EquipmentPageSlot(
                              id: widget.player!.id,
                              widgetWidth: widgetWidth,
                              slotIcon: AppIcons.nullIcon,
                              slot: EquipmentSlot.empty('bag'),
                              onDragCompleted: () {},
                              onWillAccept: (data) {
                                return false;
                              },
                              onAccept: (data) {},
                            );
                          }),
                        ),
                        GridView.count(
                          shrinkWrap: true,
                          crossAxisCount: 6,
                          children: List.generate(
                              widget.player!.equipment!.bag!.length, (index) {
                            return EquipmentPageSlot(
                                id: widget.player!.id,
                                widgetWidth: widgetWidth,
                                slotIcon: widget
                                    .player!.equipment!.bag![index].item!.icon,
                                slot: widget.player!.equipment!.bag![index],
                                onDragCompleted: () {
                                  setState(() {
                                    widget.player!.removeItemFromBag(
                                        widget.player!.equipment!.bag![index]);
                                  });
                                },
                                onWillAccept: (data) {
                                  return false;
                                },
                                onAccept: (data) {},
                                onDoubleTap: () {
                                  if (widget.player!.action!.outOfActions()) {
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(
                                          SnackBar(
                                            backgroundColor: _uiColor
                                                .setUIColor('error', 'primary'),
                                            content: EquipmentAlert(
                                              title: 'wait for your turn',
                                            ),
                                            duration:
                                                const Duration(seconds: 3),
                                            animation:
                                                AlwaysStoppedAnimation<double>(
                                                    20),
                                          ),
                                        )
                                        .closed
                                        .then((value) =>
                                            ScaffoldMessenger.of(context)
                                                .clearSnackBars());
                                    return;
                                  }
                                  if (widget.player!.equipment!.bag![index]
                                          .item!.itemSlot !=
                                      'consumable') {
                                    return;
                                  }

                                  widget.player!.useItem(
                                      widget.player!.equipment!.bag![index]);

                                  game.round!
                                      .takeTurn(game.id!, widget.player!);
                                  setState(() {});
                                });
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

                      if (widget.chest == null &&
                          widget.player!.action!.outOfActions()) {
                        ScaffoldMessenger.of(context)
                            .showSnackBar(
                              SnackBar(
                                backgroundColor:
                                    _uiColor.setUIColor('error', 'primary'),
                                content: EquipmentAlert(
                                  title: 'wait for your turn',
                                ),
                                duration: const Duration(seconds: 3),
                                animation: AlwaysStoppedAnimation<double>(20),
                              ),
                            )
                            .closed
                            .then((value) =>
                                ScaffoldMessenger.of(context).clearSnackBars());
                        return false;
                      }

                      if (data.name == 'chest') {
                        if (widget.player!.equipment!.weight!
                            .cantCarry(data.item!.weight!)) {
                          ScaffoldMessenger.of(context)
                              .showSnackBar(
                                SnackBar(
                                  backgroundColor:
                                      _uiColor.setUIColor('error', 'primary'),
                                  content: EquipmentAlert(
                                    title: 'item is too heavy',
                                  ),
                                  duration: const Duration(seconds: 3),
                                ),
                              )
                              .closed
                              .then((value) => ScaffoldMessenger.of(context)
                                  .clearSnackBars());
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
                          DialogTitle(id: widget.player!.id, tittle: 'chest'),
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
                                      return EquipmentPageSlot(
                                        id: widget.player!.id,
                                        widgetWidth: widgetWidth,
                                        slotIcon: AppIcons.nullIcon,
                                        slot: EquipmentSlot.empty('chest'),
                                        onDragCompleted: () {},
                                        onWillAccept: (data) {
                                          return false;
                                        },
                                        onAccept: (data) {},
                                      );
                                    }),
                                  ),
                                  GridView.count(
                                    shrinkWrap: true,
                                    crossAxisCount: 6,
                                    children: List.generate(
                                        widget.chest!.loot!.length, (index) {
                                      return EquipmentPageSlot(
                                        id: widget.player!.id,
                                        widgetWidth: widgetWidth,
                                        slotIcon:
                                            widget.chest!.loot![index].icon,
                                        slot: EquipmentSlot.fromItem('chest',
                                            widget.chest!.loot![index]),
                                        onDragCompleted: () {
                                          setState(() {
                                            widget.chest!.removeItem(
                                                widget.chest!.loot![index]);
                                          });
                                        },
                                        onWillAccept: (data) {
                                          return false;
                                        },
                                        onAccept: (data) {},
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

// ignore: must_be_immutable
class DialogTitle extends StatelessWidget {
  String? id;
  String? tittle;
  DialogTitle({
    Key? key,
    @required this.id,
    @required this.tittle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    UIColor _uiColor = UIColor();
    return Container(
      height: MediaQuery.of(context).size.height * 0.05,
      color: _uiColor.setUIColor(id, 'primary'),
      child: Center(
        child: Text(this.tittle!.toUpperCase(),
            style: TextStyle(
              fontFamily: 'Santana',
              height: 1,
              fontSize: 25,
              color: _uiColor.setUIColor(id, 'secondary'),
              fontWeight: FontWeight.bold,
              letterSpacing: 3,
            )),
      ),
    );
  }
}

class EquipmentAlert extends StatelessWidget {
  final String? title;
  const EquipmentAlert({Key? key, @required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    UIColor _uiColor = UIColor();
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.05,
      child: Center(
          child: Text(
        title!.toUpperCase(),
        style: TextStyle(
          color: _uiColor.setUIColor('error', 'secondary'),
          fontFamily: 'Calibri',
          height: 1,
          fontSize: 20,
          fontWeight: FontWeight.bold,
          letterSpacing: 2.5,
        ),
      )),
    );
  }
}

class EquipmentPageSlot extends StatelessWidget {
  final String? id;
  final double? widgetWidth;
  final String? slotIcon;
  final EquipmentSlot? slot;
  final Function()? onDragCompleted;
  final bool Function(EquipmentSlot?)? onWillAccept;
  final Function(EquipmentSlot)? onAccept;
  final Function()? onDoubleTap;
  const EquipmentPageSlot({
    Key? key,
    @required this.id,
    @required this.widgetWidth,
    @required this.slotIcon,
    @required this.slot,
    @required this.onDragCompleted,
    @required this.onWillAccept,
    @required this.onAccept,
    this.onDoubleTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    UIColor _uiColor = UIColor();
    return DragTarget<EquipmentSlot>(
      builder: (
        BuildContext context,
        List<dynamic> accepted,
        List<dynamic> rejected,
      ) {
        return Container(
            decoration: BoxDecoration(
              border: Border.all(
                color: _uiColor.setUIColor(id, 'primary'),
                width: 1,
              ),
            ),
            child: (slot!.item!.name! == '')
                ? SvgPicture.asset(
                    slotIcon!,
                    width: double.infinity,
                    color: _uiColor.setUIColor(id, 'primary'),
                  )
                : Draggable<EquipmentSlot>(
                    data: slot!,
                    child: GestureDetector(
                      onDoubleTap: onDoubleTap,
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return ItemDetailPage(
                              id: id,
                              item: slot!.item,
                            );
                          },
                        );
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: SvgPicture.asset(
                          slot!.item!.icon!,
                          width: double.infinity,
                          color: AppColors.white00,
                        ),
                      ),
                    ),
                    onDragCompleted: onDragCompleted,
                    childWhenDragging: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: SvgPicture.asset(
                        slot!.item!.icon!,
                        width: double.infinity,
                        color: Colors.grey,
                      ),
                    ),
                    feedback: Padding(
                      padding: const EdgeInsets.fromLTRB(25, 25, 0, 0),
                      child: Container(
                        height: widgetWidth! / 3.5,
                        width: widgetWidth! / 3.5,
                        decoration: BoxDecoration(
                          border: Border.all(
                              width: 2,
                              color: _uiColor.setUIColor(id, 'primary')),
                          shape: BoxShape.circle,
                          color: Colors.black,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: SvgPicture.asset(
                            slot!.item!.icon!,
                            color: AppColors.white00,
                          ),
                        ),
                      ),
                    ),
                  ));
      },
      onWillAccept: onWillAccept,
      onAccept: onAccept,
    );
  }
}
