import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dsixv02app/pages/shared/app_Colors.dart';
import 'package:dsixv02app/pages/shared/app_Icons.dart';
import 'package:dsixv02app/pages/shared/widgets/uiColor.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:rive/rive.dart';

import 'game.dart';
import 'player.dart';
import 'turnOrder.dart';
import 'user.dart';

class LootController {
  final db = FirebaseFirestore.instance;
  Shop _shop = Shop();

  Stream<List<Loot>> pullLootFromDataBase() {
    return db.collection('loot').snapshots().map((querySnapshot) =>
        querySnapshot.docs.map((loot) => Loot.fromMap(loot.data())).toList());
  }

  List<Loot> listOfRandomLoot = [];
  void createListOfRandomLootInRandomLocation(int numberOfLoot) {
    listOfRandomLoot = [];
    for (int i = 0; i < numberOfLoot; i++) {
      addLootToDataBase(Loot.newLoot(randomLocation(), randomLocation(), i));
    }
  }

  double randomLocation() {
    //For dev
    return (Random().nextDouble() * 640 * 0.1) + (640 * 0.35);
    //Original
    // return (Random().nextDouble() * 640 * 0.8) + (640 * 0.1);
  }

  void addLootToDataBase(Loot loot) {
    db.collection('loot').doc(loot.id).set(loot.saveToDataBase(loot));
  }

  List<Item> openLoot(String lootID) {
    List<Item> itemsInside = [];

    itemsInside.add(_shop.lightWeapons[0]);
    itemsInside.add(_shop.heavyWeapons[0]);

    var uploadItems = itemsInside.map((item) => item.toMap()).toList();

    db
        .collection('loot')
        .doc(lootID)
        .update({'isClosed': false, 'items': uploadItems});

    return itemsInside;
  }

  Future<List<Item>> seeWhatIsInside(String lootID) async {
    List<Item> itemsInside = [];
    var tempItems = await db
        .collection('loot')
        .doc(lootID)
        .get()
        .then((document) => Loot.fromMap(document.data()).items.toList());

    tempItems.forEach((item) {
      itemsInside.add(item);
    });
    return itemsInside;
  }

  // ignore: non_constant_identifier_names
  bool lootOutOfReach(Offset lootLocation, Offset playerLocation) {
    double distance = (lootLocation - playerLocation).distance;

    int lootRange = 15;

    if (distance > lootRange) {
      return true;
    } else {
      return false;
    }
  }

  void deleteAllLootFromDataBase() async {
    var batch = db.batch();
    await db.collection('loot').get().then((snapshot) {
      snapshot.docs.forEach((document) {
        batch.delete(document.reference);
      });
    });

    batch.commit();
  }
}

class Loot {
  String id;
  double dx;
  double dy;
  List<Item> items;
  bool isClosed;
  Loot({String id, double dx, double dy, List<Item> items, bool isClosed}) {
    this.id = id;
    this.dx = dx;
    this.dy = dy;
    this.items = items;
    this.isClosed = isClosed;
  }

  Map<String, dynamic> saveToDataBase(Loot loot) {
    var items = loot.items.map((item) => item.toMap()).toList();

    return {
      'id': loot.id,
      'dx': loot.dx,
      'dy': loot.dy,
      'items': items,
      'isClosed': loot.isClosed,
    };
  }

  factory Loot.fromMap(Map data) {
    List<Item> items = [];
    List<dynamic> itemsMap = data['items'];
    itemsMap.forEach((item) {
      items.add(new Item.fromMap(item));
    });

    return Loot(
      id: data['id'],
      dx: data['dx'] * 1.0,
      dy: data['dy'] * 1.0,
      items: items,
      isClosed: data['isClosed'],
    );
  }

  factory Loot.newLoot(double dx, double dy, int id) {
    return Loot(
      id: '$id',
      dx: dx,
      dy: dy,
      items: [],
      isClosed: true,
    );
  }
}

// ignore: must_be_immutable
class LootSprite extends StatelessWidget {
  String lootID;
  double dx;
  double dy;
  bool isClosed;
  LootSprite({Key key, this.lootID, this.dx, this.dy, this.isClosed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final game = Provider.of<Game>(context);
    final players = Provider.of<List<Player>>(context);
    final turnController = Provider.of<TurnController>(context);
    final turnOrder = Provider.of<List<Turn>>(context);
    final lootController = Provider.of<LootController>(context);
    final user = Provider.of<User>(context);

    return Positioned(
        left: dx - 5,
        top: dy - 5,
        child: GestureDetector(
          onTap: () {
            if (user.playerMode != 'walk') {
              return;
            }
            if (lootController.lootOutOfReach(
                Offset(dx, dy), user.selectedPlayer.getLocation())) {
              return;
            }
            if (isClosed) {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return LootDialog(
                    items: lootController.openLoot(lootID),
                  );
                },
              );
            }

            turnController.takeTurn(game, players, turnOrder, user);
          },
          child: Container(
            width: 10,
            height: 10,
            color: (isClosed) ? Colors.amber : Colors.blue,
          ),
        ));
  }
}

class LootDialog extends StatefulWidget {
  final List<Item> items;
  final Function() onTapAction;
  const LootDialog({
    @required this.items,
    this.onTapAction,
  });

  @override
  State<LootDialog> createState() => _LootDialogState();
}

class _LootDialogState extends State<LootDialog> {
  UIColor _uiColor = UIColor();
  Artboard _artboard;

  @override
  void initState() {
    _loadRiverFile();
    super.initState();
  }

  void _loadRiverFile() async {
    final bytes = await rootBundle.load('assets/animation/buttonAnimation.riv');
    final file = RiveFile.import(bytes);
    setState(() {
      _artboard = file.mainArtboard;
      _playReflectionAnimation();
    });
  }

  _playReflectionAnimation() {
    _artboard.addController(SimpleAnimation('reflection'));
  }

  _playOnTapAnimation() {
    _artboard.addController(OneShotAnimation(
      'onTap',
    ));
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

  void selectOptions(int index) {
    if (this.options[index]) {
      this.options[index] = false;
    } else {
      this.options[index] = true;
    }
  }

  void chooseItems(Player player) {
    for (int i = 0; i < widget.items.length; i++) {
      if (this.options[i]) {
        player.getItem(widget.items[i]);
      }
    }

    Navigator.pop(context);
  }

  refresh() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    setOptions(widget.items.length);

    return AlertDialog(
      contentPadding: EdgeInsets.fromLTRB(0, 0, 0, 0),
      content: Container(
        width: MediaQuery.of(context).size.width * 0.8,
        decoration: BoxDecoration(
          color: AppColors.black00,
          border: Border.all(
            color: _uiColor.setUIColor(user.selectedPlayer.id, 'primary'),
            width: 2,
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              color: _uiColor.setUIColor(user.selectedPlayer.id, 'primary'),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(30, 5, 30, 7),
                child: Center(
                  child: Text('chest'.toUpperCase(),
                      style: TextStyle(
                        fontFamily: 'Santana',
                        height: 1,
                        fontSize: 25,
                        color: _uiColor.setUIColor(
                            user.selectedPlayer.id, 'secondary'),
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
                      widget.items.length,
                  child: ListView.builder(
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                    itemCount: widget.items.length,
                    itemBuilder: (BuildContext context, int index) {
                      return LootOption(
                        item: widget.items[index],
                        optionSelected: options[index],
                        onTapAction: () {
                          selectOptions(index);
                          refresh();
                        },
                      );
                    },
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    _playOnTapAnimation();
                    chooseItems(user.selectedPlayer);
                  },
                  child: Container(
                    height: MediaQuery.of(context).size.height * 0.09,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: AppColors.black00,
                      border: Border.all(
                        color: _uiColor.setUIColor(
                            user.selectedPlayer.id, 'primary'),
                        width: 1,
                      ),
                    ),
                    child: Stack(
                      alignment: AlignmentDirectional.centerEnd,
                      children: [
                        (_artboard != null)
                            ? Rive(
                                artboard: _artboard,
                                fit: BoxFit.fill,
                              )
                            : Container(),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(0, 8, 0, 8),
                          child: Center(
                            child: Text('choose'.toUpperCase(),
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 2,
                                  fontFamily: 'Calibri',
                                  color: _uiColor.setUIColor(
                                      user.selectedPlayer.id, 'primary'),
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

// ignore: must_be_immutable
class LootOption extends StatelessWidget {
  Item item;
  bool optionSelected;
  Function() onTapAction;
  LootOption({Key key, this.item, this.optionSelected, this.onTapAction})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    UIColor _uiColor = UIColor();
    final user = Provider.of<User>(context);
    return GestureDetector(
      onTap: () {
        onTapAction();
      },
      child: Container(
        height: MediaQuery.of(context).size.height * 0.09,
        width: double.infinity,
        decoration: BoxDecoration(
          color: (optionSelected)
              ? _uiColor.setUIColor(user.selectedPlayer.id, 'secondary')
              : AppColors.black00,
          border: Border.all(
            color: _uiColor.setUIColor(user.selectedPlayer.id, 'primary'),
            width: 1,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(0, 8, 0, 8),
          child: Center(
            child: Text('${item.name}'.toUpperCase(),
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 2,
                  fontFamily: 'Calibri',
                  color: (optionSelected)
                      ? _uiColor.setUIColor(user.selectedPlayer.id, 'primary')
                      : _uiColor.setUIColor(user.selectedPlayer.id, 'primary'),
                )),
          ),
        ),
      ),
    );
  }
}

class Item {
  String icon;
  String name;
  String itemSlot;
  int pDamage;
  int mDamage;
  int pArmor;
  int mArmor;
  int weight;
  double weaponRange;
  Item(
      {String icon,
      String name,
      String itemSlot,
      int pDamage,
      int mDamage,
      int pArmor,
      int mArmor,
      int weight,
      double weaponRange}) {
    this.icon = icon;
    this.name = name;
    this.itemSlot = itemSlot;
    this.pDamage = pDamage;
    this.mDamage = mDamage;
    this.pArmor = pArmor;
    this.mArmor = mArmor;
    this.weight = weight;
    this.weaponRange = weaponRange;
  }

  factory Item.fromMap(
    Map data,
  ) {
    return Item(
      icon: data['icon'],
      name: data['name'],
      itemSlot: data['itemSlot'],
      pDamage: data['pDamage'],
      mDamage: data['mDamage'],
      pArmor: data['pArmor'],
      mArmor: data['mArmor'],
      weight: data['weight'],
      weaponRange: data['weaponRange'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'icon': this.icon,
      'name': this.name,
      'itemSlot': this.itemSlot,
      'pDamage': this.pDamage,
      'mDamage': this.mDamage,
      'pArmor': this.pArmor,
      'mArmor': this.mArmor,
      'weight': this.weight,
      'weaponRange': this.weaponRange,
    };
  }

  factory Item.emptyItem() {
    return Item(
      icon: '',
      name: '',
      itemSlot: '',
      pDamage: 0,
      mDamage: 0,
      pArmor: 0,
      mArmor: 0,
      weight: 0,
      weaponRange: 0,
    );
  }
}

class Shop {
  List<Item> lightWeapons = [
    Item(
      icon: AppIcons.dagger,
      name: 'dagger',
      itemSlot: 'oneHand',
      pDamage: 1,
      mDamage: 0,
      pArmor: 0,
      mArmor: 0,
      weight: 1,
      weaponRange: 5,
    ),
  ];
  List<Item> heavyWeapons = [
    Item(
      icon: AppIcons.longSpear,
      name: 'long spear',
      itemSlot: 'twoHands',
      pDamage: 3,
      mDamage: 0,
      pArmor: 0,
      mArmor: 0,
      weight: 2,
      weaponRange: 30,
    ),
  ];
}
