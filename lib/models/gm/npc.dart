import 'npcSkill.dart';
import 'npcSkillList.dart';
import 'dart:math';

class Npc {
  NpcSkillList npcSkills = new NpcSkillList();

  String icon;
  String name;
  String description;
  String image;

  int amount = 1;

  int baseHealth;
  int maxHealth;
  int currentHealth = 0;
  int dice;
  int pDamage;
  int pArmor;
  int mDamage;
  int mArmor;
  int pSkill;
  int mSkill;

  List<NpcSkill> possibleSkills = [];

  List<NpcSkill> selectedSkills = [];

  int totalLoot = 0;
  double baseLoot;
  int totalXp;
  int baseXp;

  Npc newNpc() {
    Npc newNpc = new Npc(
      icon: this.icon,
      name: this.name,
      description: this.description,
      image: this.image,
      baseHealth: this.baseHealth,
      dice: this.dice,
      pDamage: this.pDamage,
      pArmor: this.pArmor,
      mDamage: this.mDamage,
      mArmor: this.mArmor,
      pSkill: this.pSkill,
      mSkill: this.mSkill,
      baseLoot: this.baseLoot,
      baseXp: this.baseXp,
    );

    return newNpc;
  }

  void prepareNpc() {
    this.possibleSkills = npcSkills.getSkills(this.name);
    this.maxHealth = this.baseHealth;
    this.currentHealth = this.maxHealth;
    this.totalLoot = this.baseLoot.toInt();
    this.totalXp = this.baseXp;

    for (int check = 0; check < this.pSkill; check++) {
      selectedSkills.add(
        NpcSkill(
          icon: 'pSkill',
          name: 'ABILITY',
          skillType: 'pSkill',
          description: 'pSkill',
          value: 0,
        ),
      );
    }

    for (int check = 0; check < this.mSkill; check++) {
      selectedSkills.add(
        NpcSkill(
          icon: 'mSkill',
          name: 'SPELL',
          skillType: 'mSkill',
          description: 'mSkill',
          value: 0,
        ),
      );
    }
  }

  void chooseAmount(int value) {
    if (this.amount + value < 1) {
      this.amount = 1;
      return;
    }

    this.amount += value;

    this.maxHealth = this.baseHealth * this.amount;
    this.currentHealth = this.maxHealth;

    this.totalXp = this.baseXp * this.amount;
    this.totalLoot = (this.baseLoot * this.amount).toInt();
  }

  String npcAction() {
    String result = 'roll';

    result = '${Random().nextInt(this.dice) + 1}';

    return result;
  }

  List<NpcSkill> skillList = [];

  List<NpcSkill> openSkill(NpcSkill skill) {
    this.skillList = [];
    if (skill.icon == 'pSkill') {
      this.possibleSkills.forEach((element) {
        if (element.skillType == skill.skillType) {
          this.skillList.add(element);
        }
      });
      return this.skillList;
    }

    if (skill.icon == 'mSkill') {
      this.possibleSkills.forEach((element) {
        if (element.skillType == skill.skillType) {
          this.skillList.add(element);
        }
      });
      return this.skillList;
    }

    return this.skillList;
  }

  void chooseSkill(NpcSkill skill) {
    switch (skill.skillType) {
      case 'pSkill':
        this.selectedSkills.remove(
            this.selectedSkills.firstWhere((e) => e.skillType == 'pSkill'));
        this.selectedSkills.add(skill);

        break;

      case 'mSkill':
        this.selectedSkills.remove(
            this.selectedSkills.firstWhere((e) => e.skillType == 'mSkill'));
        this.selectedSkills.add(skill);
        break;
    }
  }

  void changeHealth(int value) {
    if (this.currentHealth + value > this.maxHealth) {
      this.currentHealth = this.maxHealth;

      return;
    }

    if (this.currentHealth + value < 1) {
      this.currentHealth = 0;

      return;
    }

    this.currentHealth += value;
    this.amount = ((this.currentHealth - 1) ~/ this.baseHealth) + 1;
  }

  Npc({
    String icon,
    String name,
    String description,
    String image,
    int baseHealth,
    int dice,
    int pDamage,
    int pArmor,
    int mDamage,
    int mArmor,
    int pSkill,
    int mSkill,
    double baseLoot,
    int baseXp,
  }) {
    this.icon = icon;
    this.name = name;
    this.description = description;
    this.image = image;

    this.baseHealth = baseHealth;
    this.dice = dice;
    this.pDamage = pDamage;
    this.pArmor = pArmor;
    this.mDamage = mDamage;
    this.mArmor = mArmor;

    this.pSkill = pSkill;
    this.mSkill = mSkill;

    this.baseLoot = baseLoot;

    this.baseXp = baseXp;
  }
}
