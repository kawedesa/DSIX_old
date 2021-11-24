import 'package:dsixv02app/core/app_colors.dart';
import 'package:dsixv02app/models/dsix/item.dart';
import 'package:dsixv02app/models/player/action/actionResult.dart';
import 'package:dsixv02app/models/player/effectSystem.dart';
import 'package:dsixv02app/models/player/player.dart';
import 'package:dsixv02app/widgets/buttons/dialogButton.dart';
import 'package:dsixv02app/widgets/dialogs/dialogTitle.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class OpenLootDialog extends StatefulWidget {
  const OpenLootDialog({
    @required this.loot,
    @required this.player,
  });

  final List<Item> loot;
  final Player player;

  @override
  State<OpenLootDialog> createState() => _OpenLootDialogState();
}

class _OpenLootDialogState extends State<OpenLootDialog> {
  List<DialogOption> options = [];

  int additionalWeight = 0;
  bool tooHeavy = false;

  void selectItem(Player player, int index) {
    if (this.options[index].selected) {
      this.options[index].selected = false;
      additionalWeight -= this.options[index].item.weight;
    } else {
      this.options[index].selected = true;
      additionalWeight += this.options[index].item.weight;
    }
  }

  void confirm(Player player) {
    this.options.forEach((element) {
      if (element.selected) {
        player.lootItem(element.item);
        widget.loot.remove(element.item);
      }
    });
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    if (this.options.isEmpty && widget.loot.isNotEmpty) {
      this.options = [];
      widget.loot.forEach((element) {
        this.options.add(DialogOption(
              item: element,
              selected: false,
            ));
      });
    }

    if (additionalWeight + widget.player.weight >
        widget.player.race.maxWeight) {
      this.tooHeavy = true;
    } else {
      this.tooHeavy = false;
    }

    return AlertDialog(
      backgroundColor: Colors.black,
      contentPadding: EdgeInsets.fromLTRB(0, 0, 0, 0),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            decoration: BoxDecoration(
              border: Border.all(
                color: widget.player.primaryColor,
                width: 1.5, //                   <--- border width here
              ),
            ),
            width: MediaQuery.of(context).size.width * 0.7,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                DialogTitle(
                  title: (tooHeavy)
                      ? 'too heavy'.toUpperCase()
                      : 'choose items'.toUpperCase(),
                  color: widget.player.primaryColor,
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                  child: Container(
                    width: double.infinity,
                    height: (widget.loot.length < 6)
                        ? MediaQuery.of(context).size.height *
                            0.08 *
                            widget.loot.length
                        : MediaQuery.of(context).size.height * 0.08 * 6,
                    child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: widget.loot.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Stack(
                                children: [
                                  DialogButton(
                                    buttonIcon: 'weight',
                                    value: widget.loot[index].weight,
                                    buttonText:
                                        widget.loot[index].name.toUpperCase(),
                                    buttonColor: widget.player.primaryColor,
                                    buttonTextColor: AppColors.white01,
                                    iconFillColor:
                                        (this.options[index].selected)
                                            ? AppColors.white01
                                            : widget.player.primaryColor,
                                    buttonFillColor:
                                        (this.options[index].selected)
                                            ? widget.player.secondaryColor
                                            : null,
                                    onTapAction: () {
                                      setState(() {
                                        selectItem(widget.player, index);
                                      });
                                    },
                                  ),
                                ],
                              ),
                              Divider(
                                height: 0,
                                thickness: 2,
                                color: widget.player.primaryColor,
                              ),
                            ],
                          );
                        }),
                  ),
                ),
                DialogButton(
                  buttonText: 'confirm',
                  onTapAction: (tooHeavy)
                      ? () {}
                      : () async {
                          confirm(widget.player);
                        },
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class DialogOption {
  Item item;
  bool selected;
  DialogOption({Item item, bool selected}) {
    this.item = item;
    this.selected = selected;
  }
}
