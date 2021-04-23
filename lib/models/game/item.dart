class Item {
  String icon;
  String name;
  String itemClass;
  String inventorySpace;
  String description;
  int pDamage;
  int pArmor;
  int mDamage;
  int mArmor;
  int weight;
  int uses;
  int value;
  int enchant = 0;

  Item({
    String icon,
    String name,
    String itemClass,
    String inventorySpace,
    String description,
    int pDamage,
    int pArmor,
    int mDamage,
    int mArmor,
    int weight,
    int uses,
    int value,
    int enchant,
  }) {
    this.icon = icon;
    this.name = name;
    this.itemClass = itemClass;
    this.inventorySpace = inventorySpace;
    this.description = description;
    this.pDamage = pDamage;
    this.pArmor = pArmor;
    this.mDamage = mDamage;
    this.mArmor = mArmor;
    this.weight = weight;
    this.uses = uses;
    this.value = value;
    this.enchant = enchant;
  }

  Item copyItem() {
    Item newItem = new Item(
      icon: this.icon,
      name: this.name,
      itemClass: this.itemClass,
      inventorySpace: this.inventorySpace,
      description: this.description,
      pDamage: this.pDamage,
      pArmor: this.pArmor,
      mDamage: this.mDamage,
      mArmor: this.mArmor,
      weight: this.weight,
      uses: this.uses,
      value: this.value,
      enchant: this.enchant,
    );

    return newItem;
  }
}
