import 'package:dsixv02app/models/loot/lootController.dart';
import 'package:dsixv02app/models/player/player.dart';
import 'package:dsixv02app/models/shop/item.dart';
import 'package:dsixv02app/models/player/user.dart';
import 'package:dsixv02app/shared/app_Colors.dart';
import 'package:dsixv02app/shared/app_Icons.dart';
import 'package:dsixv02app/shared/widgets/uiColor.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:rive/rive.dart';
import '../gameController.dart';
import 'loot.dart';

class LootDialog extends StatefulWidget {
  final int? lootIndex;
  final Function()? onTapAction;
  const LootDialog({
    @required this.lootIndex,
    this.onTapAction,
  });

  @override
  State<LootDialog> createState() => _LootDialogState();
}

class _LootDialogState extends State<LootDialog> {
  LootDialogController _lootDialogController = LootDialogController();
  UIColor _uiColor = UIColor();

  @override
  void initState() {
    _lootDialogController.loadRiverFile();
    super.initState();
  }

  refresh() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    final gameController = Provider.of<GameController>(context);
    final lootController = Provider.of<LootController>(context);
    final listOfloot = Provider.of<List<Loot>>(context);

    _lootDialogController.setItemList(widget.lootIndex!, listOfloot);
    _lootDialogController.setOptions(_lootDialogController.itemList.length);

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
              color: _uiColor.setUIColor(user.selectedPlayer!.id, 'primary'),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(30, 5, 30, 7),
                child: Center(
                  child: Text(
                      (_lootDialogController.itemList.isEmpty)
                          ? 'empty'.toUpperCase()
                          : 'chest'.toUpperCase(),
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
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height *
                      0.09 *
                      _lootDialogController.itemList.length,
                  child: ListView.builder(
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                    itemCount: _lootDialogController.itemList.length,
                    itemBuilder: (BuildContext context, int index) {
                      return LootDialogOption(
                        item: _lootDialogController.itemList[index],
                        optionSelected: _lootDialogController.options[index],
                        onTapAction: () {
                          _lootDialogController.selectOptions(
                              index, _lootDialogController.itemList[index]);
                          refresh();
                        },
                      );
                    },
                  ),
                ),
                (_lootDialogController.numberOfSelectedItems < 1)
                    ? GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Container(
                          height: MediaQuery.of(context).size.height * 0.09,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: AppColors.black00,
                            border: Border.all(
                              color: _uiColor.setUIColor(
                                  user.selectedPlayer!.id, 'primary'),
                              width: 1,
                            ),
                          ),
                          child: Stack(
                            alignment: AlignmentDirectional.centerEnd,
                            children: [
                              (_lootDialogController.artboard != null)
                                  ? Rive(
                                      artboard: _lootDialogController.artboard!,
                                      fit: BoxFit.fill,
                                    )
                                  : SizedBox(),
                              Padding(
                                padding: const EdgeInsets.fromLTRB(0, 8, 0, 8),
                                child: Center(
                                  child: Text('leave'.toUpperCase(),
                                      style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold,
                                        letterSpacing: 2,
                                        fontFamily: 'Calibri',
                                        color: _uiColor.setUIColor(
                                            user.selectedPlayer!.id, 'primary'),
                                      )),
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                    : GestureDetector(
                        onTap: () {
                          _lootDialogController.playOnTapAnimation();
                          _lootDialogController.chooseItems(
                              context,
                              gameController.gameID,
                              user.selectedPlayer!,
                              _lootDialogController.itemList,
                              lootController,
                              widget.lootIndex!);
                          setState(() {});
                        },
                        child: Container(
                          height: MediaQuery.of(context).size.height * 0.09,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color:
                                (_lootDialogController.buttonText == 'choose')
                                    ? AppColors.black00
                                    : AppColors.errorPrimary,
                            border: Border.all(
                              color: _uiColor.setUIColor(
                                  user.selectedPlayer!.id, 'primary'),
                              width: 1,
                            ),
                          ),
                          child: Stack(
                            alignment: AlignmentDirectional.centerEnd,
                            children: [
                              (_lootDialogController.artboard != null)
                                  ? Rive(
                                      artboard: _lootDialogController.artboard!,
                                      fit: BoxFit.fill,
                                    )
                                  : SizedBox(),
                              Padding(
                                padding: const EdgeInsets.fromLTRB(0, 8, 0, 8),
                                child: Center(
                                  child: Text(
                                      _lootDialogController.buttonText
                                          .toUpperCase(),
                                      style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold,
                                        letterSpacing: 2,
                                        fontFamily: 'Calibri',
                                        color:
                                            (_lootDialogController.buttonText ==
                                                    'choose')
                                                ? _uiColor.setUIColor(
                                                    user.selectedPlayer!.id,
                                                    'primary')
                                                : AppColors.errorSecondary,
                                      )),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class LootDialogController {
  Artboard? artboard;

  void loadRiverFile() async {
    final bytes = await rootBundle.load('assets/animation/buttonAnimation.riv');
    final file = RiveFile.import(bytes);

    artboard = file.mainArtboard;
    playReflectionAnimation();
  }

  playReflectionAnimation() {
    artboard!.addController(SimpleAnimation('reflection'));
  }

  playOnTapAnimation() {
    artboard!.addController(OneShotAnimation(
      'onTap',
    ));
  }

  List<Item> itemList = [];
  void setItemList(int lootIndex, List<Loot> loots) {
    this.itemList = [];
    loots.forEach((loot) {
      if (loot.index != lootIndex) {
        return;
      }
      itemList = loot.items!;
    });
  }

  List<bool> options = [];
  void setOptions(int numberOfOptions) {
    if (options.isNotEmpty) {
      return;
    }
    for (int i = 0; i < numberOfOptions; i++) {
      this.options.add(false);
    }
  }

  int totalWeight = 0;
  int numberOfSelectedItems = 0;
  String buttonText = 'choose';

  void selectOptions(int index, Item item) {
    buttonText = 'choose';
    if (this.options[index]) {
      numberOfSelectedItems--;
      totalWeight -= item.weight!;
      this.options[index] = false;
    } else {
      numberOfSelectedItems++;
      totalWeight += item.weight!;
      this.options[index] = true;
    }
  }

  void chooseItems(context, String gameID, Player player, List<Item> items,
      LootController lootController, int lootIndex) {
    if (player.weight!.cantCarry(totalWeight)) {
      buttonText = 'too heavy';
      return;
    }

    List<Item> itemsRemovedFromChest = [];

    for (int i = 0; i < items.length; i++) {
      if (this.options[i]) {
        player.getItem(items[i]);
        itemsRemovedFromChest.add(items[i]);
      }
    }

    itemsRemovedFromChest.forEach((item) {
      this.itemList.remove(item);
    });

    lootController.updateLootItems(gameID, lootIndex, this.itemList);

    Navigator.pop(context);
  }
}

// ignore: must_be_immutable
class LootDialogOption extends StatelessWidget {
  Item? item;
  bool? optionSelected;
  Function()? onTapAction;
  LootDialogOption({Key? key, this.item, this.optionSelected, this.onTapAction})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    UIColor _uiColor = UIColor();
    final user = Provider.of<User>(context);
    return GestureDetector(
      onTap: () {
        onTapAction!();
      },
      child: Container(
        height: MediaQuery.of(context).size.height * 0.09,
        width: double.infinity,
        decoration: BoxDecoration(
          color: (optionSelected!)
              ? _uiColor.setUIColor(user.selectedPlayer!.id, 'secondary')
              : AppColors.black00,
          border: Border.all(
            color: _uiColor.setUIColor(user.selectedPlayer!.id, 'primary'),
            width: 1,
          ),
        ),
        child: Stack(
          children: [
            Align(
              alignment: Alignment.centerRight,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text('${item!.weight}'.toUpperCase(),
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 2,
                        fontFamily: 'Calibri',
                        color: (optionSelected!)
                            ? _uiColor.setUIColor(
                                user.selectedPlayer!.id, 'primary')
                            : _uiColor.setUIColor(
                                user.selectedPlayer!.id, 'primary'),
                      )),
                  SvgPicture.asset(
                    AppIcons.weight,
                    height: MediaQuery.of(context).size.height * 0.03,
                    width: MediaQuery.of(context).size.height * 0.03,
                    color: (optionSelected!)
                        ? _uiColor.setUIColor(
                            user.selectedPlayer!.id, 'primary')
                        : _uiColor.setUIColor(
                            user.selectedPlayer!.id, 'primary'),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.05,
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 8, 0, 8),
              child: Center(
                child: Text('${item!.name}'.toUpperCase(),
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 2,
                      fontFamily: 'Calibri',
                      color: (optionSelected!)
                          ? _uiColor.setUIColor(
                              user.selectedPlayer!.id, 'primary')
                          : _uiColor.setUIColor(
                              user.selectedPlayer!.id, 'primary'),
                    )),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
