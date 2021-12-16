import 'package:dsixv02app/models/shop/item.dart';

class Loot {
  int index;
  double dx;
  double dy;
  List<Item> items;
  bool isClosed;
  Loot({int index, double dx, double dy, List<Item> items, bool isClosed}) {
    this.index = index;
    this.dx = dx;
    this.dy = dy;
    this.items = items;
    this.isClosed = isClosed;
  }

  Map<String, dynamic> saveToDataBase(Loot loot) {
    var items = loot.items.map((item) => item.toMap()).toList();

    return {
      'index': loot.index,
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
      index: data['index'],
      dx: data['dx'] * 1.0,
      dy: data['dy'] * 1.0,
      items: items,
      isClosed: data['isClosed'],
    );
  }

  factory Loot.newLoot(double dx, double dy, int index) {
    return Loot(
      index: index,
      dx: dx,
      dy: dy,
      items: [],
      isClosed: true,
    );
  }
}
