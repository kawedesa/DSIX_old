import 'npcSkill.dart';

class NpcType {
  String type;
  String description;

  int health;
  int dice;
  int pDamage;
  int pArmor;
  int mDamage;
  int mArmor;

  int pSkill;
  int mSkill;
  List<NpcSkill> possibleSkills = [];

  double loot;
  int xp;

  // NpcType(this.type, this.description, this.health, this.pDamage, this.pArmor, this.mDamage,
  //     this.mArmor, this.pSkill, this.mSkill, this.possibleSkills);

  NpcType({
    String type,
    String description,
    int health,
    int dice,
    int pDamage,
    int pArmor,
    int mDamage,
    int mArmor,
    int pSkill,
    int mSkill,
    double loot,
    int xp,
  }) {
    this.type = type;
    description = description;

    this.health = health;
    this.dice = dice;
    this.pDamage = pDamage;
    this.pArmor = pArmor;
    this.mDamage = mDamage;
    this.mArmor = mArmor;

    this.pSkill = pSkill;
    this.mSkill = mSkill;

    this.loot = loot;

    this.xp = xp;
  }
}
