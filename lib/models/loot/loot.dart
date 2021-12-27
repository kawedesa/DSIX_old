import 'package:dsixv02app/models/shop/item.dart';
import 'package:flutter/material.dart';

class Loot {
  int? index;
  LootLocation? location;
  List<Item>? items;
  bool? isClosed;
  Loot(
      {int? index, LootLocation? location, List<Item>? items, bool? isClosed}) {
    this.index = index;
    this.location = location;
    this.items = items;
    this.isClosed = isClosed;
  }

  Map<String, dynamic> toMap() {
    var items = this.items!.map((item) => item.toMap()).toList();

    return {
      'index': this.index,
      'location': this.location!.toMap(),
      'items': items,
      'isClosed': this.isClosed,
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
      location: LootLocation.fromMap(data['location']),
      items: items,
      isClosed: data['isClosed'],
    );
  }

  factory Loot.newLoot(LootLocation location, int index) {
    return Loot(
      index: index,
      location: location,
      items: [],
      isClosed: true,
    );
  }
}

class LootLocation {
  double? dx;
  double? dy;
  LootLocation({double? dx, double? dy}) {
    this.dx = dx;
    this.dy = dy;
  }
  Map<String, dynamic> toMap() {
    return {
      'dx': this.dx,
      'dy': this.dy,
    };
  }

  factory LootLocation.fromMap(Map<String, dynamic>? data) {
    return LootLocation(
      dx: data?['dx'] * 1.0,
      dy: data?['dy'] * 1.0,
    );
  }
  factory LootLocation.newLocation(Offset location) {
    return LootLocation(
      dx: location.dx,
      dy: location.dy,
    );
  }
  Offset getLocation() {
    return Offset(this.dx!.toDouble(), this.dy!.toDouble());
  }
}
