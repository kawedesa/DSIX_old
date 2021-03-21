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

  Item(
    this.icon,
    this.name,
    this.itemClass,
    this.inventorySpace,
    this.description,
    this.pDamage,
    this.pArmor,
    this.mDamage,
    this.mArmor,
    this.weight,
    this.uses,
    this.value,
  );

  Item copyItem() {
    Item newItem = new Item(
        this.icon,
        this.name,
        this.itemClass,
        this.inventorySpace,
        this.description,
        this.pDamage,
        this.pArmor,
        this.mDamage,
        this.mArmor,
        this.weight,
        this.uses,
        this.value);

    return newItem;
  }
}
