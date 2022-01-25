import 'package:dsixv02app/models/shop/item.dart';

class EquipmentSlot {
  String? name;
  Item? item;
  EquipmentSlot({String? name, Item? item}) {
    this.name = name;
    this.item = item;
  }

  Map<String, dynamic> toMap() {
    return {
      'name': this.name,
      'item': this.item?.toMap(),
    };
  }

  factory EquipmentSlot.fromMap(Map<String, dynamic>? data) {
    return EquipmentSlot(
      name: data?['name'],
      item: Item.fromMap(data?['item']),
    );
  }
  factory EquipmentSlot.fromItem(String slotName, Item item) {
    return EquipmentSlot(
      name: slotName,
      item: item,
    );
  }

  factory EquipmentSlot.empty(String slotName) {
    return EquipmentSlot(
      name: slotName,
      item: Item.empty(),
    );
  }

  bool isEmpty() {
    if (this.item!.name == '') {
      return true;
    }
    return false;
  }

  void equip(EquipmentSlot equipmentSlot) {
    this.name = equipmentSlot.name;
    this.item = equipmentSlot.item;
  }

  void unequip() {
    this.item = Item.empty();
  }
}
