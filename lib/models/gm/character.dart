import 'package:dsixv02app/models/dsix/sprite.dart';
import 'package:flutter/cupertino.dart';
import 'characterSkill.dart';
import 'dart:math';

class Character {
  // CharacterSkillList CharacterSkills = new CharacterSkillList();

//NAME DESCRIPTION
  String icon;
  String name;
  String description;
  String image;
  Offset location = Offset.zero;
  // Sprite sprite;
//HEALTH

  int baseHealth;
  int maxHealth;
  int currentHealth = 0;

  //DICE

  int dice;

  double size;

  //STATS

  int pDamage;
  int pArmor;
  int mDamage;
  int mArmor;
  // int pSkill;
  // int mSkill;

//SKILLS

  List<CharacterSkill> possibleSkills = [];
  List<CharacterSkill> availableSkills = [];
  List<CharacterSkill> selectedSkills = [];

  int amount = 1;

//LOOT DESCRIPTION

  int totalLoot = 0;
  double baseLoot;
  int totalXp;
  int baseXp;

  Character newCharacter() {
    List<CharacterSkill> temp = [];

    Character newCharacter = new Character(
      icon: this.icon,
      image: this.image,
      name: this.name,
      description: this.description,
      baseHealth: this.baseHealth,
      baseLoot: this.baseLoot,
      baseXp: this.baseXp,
      dice: this.dice,
      size: this.size,
      pDamage: this.pDamage,
      pArmor: this.pArmor,
      mDamage: this.mDamage,
      mArmor: this.mArmor,
      possibleSkills: this.possibleSkills,
      selectedSkills: this.selectedSkills,
    );

    temp = this.possibleSkills;
    this.possibleSkills = [];
    temp.forEach((element) {
      this.possibleSkills.add(element.newSkill());
    });

    temp = this.selectedSkills;
    this.selectedSkills = [];
    temp.forEach((element) {
      this.selectedSkills.add(element.newSkill());
    });

    newCharacter.amount = 1;
    return newCharacter;
  }

  void changeAmount(int value) {
    if (this.amount + value < 1) {
      this.amount = 0;
      this.currentHealth = 0;
      this.maxHealth = 0;
      this.totalXp = 0;
      this.totalLoot = 0;
      return;
    }

    this.amount += value;
    setHpAndXp();
  }

  void setHpAndXp() {
    this.maxHealth = this.baseHealth * this.amount;
    this.currentHealth = this.baseHealth * this.amount;

    this.totalXp = this.baseXp * this.amount;
    this.totalLoot = (this.baseLoot * this.amount).toInt();
  }

  void setAmount(int value) {
    if (this.amount + value < 1) {
      this.amount = 1;
      return;
    }
    this.amount += value;
    setHpAndXp();
  }

  String characterAction() {
    String result = 'roll';

    result = '${Random().nextInt(this.dice) + 1}';

    return result;
  }

  void openSkill(CharacterSkill skill) {
    this.availableSkills = [];

    switch (skill.icon) {
      case 'pSkill':
        {
          this.possibleSkills.forEach((element) {
            if (element.skillType == 'pSkill') {
              this.availableSkills.add(element);
            }
          });
        }
        break;

      case 'mSkill':
        {
          this.possibleSkills.forEach((element) {
            if (element.skillType == 'mSkill') {
              this.availableSkills.add(element);
            }
          });
        }
        break;
    }
  }

  void chooseSkill(CharacterSkill skill) {
    switch (skill.skillType) {
      case 'pSkill':
        // this.selectedSkills.remove((element) => element.name == 'ABILITY');
        this.selectedSkills.remove(this
            .selectedSkills
            .lastWhere((element) => element.name == 'ABILITY'));

        this.selectedSkills.add(skill);

        break;

      case 'mSkill':
        this.selectedSkills.remove(this
            .selectedSkills
            .lastWhere((element) => element.name == 'SPELL'));
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

  Character({
    String icon,
    String name,
    String description,
    String image,
    Offset location,
    // Sprite sprite,
    int baseHealth,
    int dice,
    double size,
    int pDamage,
    int pArmor,
    int mDamage,
    int mArmor,
    // int pSkill,
    // int mSkill,
    List<CharacterSkill> possibleSkills,
    List<CharacterSkill> selectedSkills,
    double baseLoot,
    int baseXp,
  }) {
    this.icon = icon;
    this.name = name;
    this.description = description;
    this.image = image;
    this.location = location;
    // this.sprite = sprite;

    this.baseHealth = baseHealth;
    this.dice = dice;
    this.size = size;
    this.pDamage = pDamage;
    this.pArmor = pArmor;
    this.mDamage = mDamage;
    this.mArmor = mArmor;

    // this.pSkill = pSkill;
    // this.mSkill = mSkill;

    this.possibleSkills = possibleSkills;
    this.selectedSkills = selectedSkills;

    this.baseLoot = baseLoot;
    this.baseXp = baseXp;
  }
}
