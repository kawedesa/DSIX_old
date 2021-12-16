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
