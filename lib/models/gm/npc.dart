import 'npcSkill.dart';
import 'dart:math';
import 'npcSkillList.dart';
import 'npcType.dart';
import 'npcRace.dart';

class Npc {
  String icon;
  String name;
  String description;

  NpcSkillList npcSkills = new NpcSkillList();

//  NpcType(this.type, this.health, this.pDamage, this.pArmor, this.mDamage,this.mArmor, this.pSkill, this.mSkill, this.possibleSkills);

  NpcRace selectedRace = NpcRace(
      icon: 'npc',
      name: 'NPC',
      description: 'This is a NPC.',
      npcType: [
        NpcType(
          type: 'TYPE',
          description: '',
          health: 0,
          pDamage: 0,
          pArmor: 0,
          mDamage: 0,
          mArmor: 0,
          pSkill: 0,
          mSkill: 0,
        )
      ]);
  List<NpcRace> races = [
    NpcRace(
        icon: 'undead',
        name: 'UNDEAD',
        description: 'undead is dead.',
        npcType: [
          NpcType(
            type: 'SKELETON MAGE',
            description: 'Skely pew pew',
            health: 3,
            dice: 2,
            pDamage: 0,
            pArmor: 3,
            mDamage: 2,
            mArmor: 0,
            pSkill: 0,
            mSkill: 1,
            loot: 0.25,
            xp: 25,
          ),
          NpcType(
            type: 'SKELETON',
            description: 'swaordsnd hff ds',
            health: 3,
            dice: 2,
            pDamage: 2,
            pArmor: 3,
            mDamage: 0,
            mArmor: 0,
            pSkill: 1,
            mSkill: 0,
            loot: 0.25,
            xp: 25,
          ),
          NpcType(
            type: 'ZOMBIE',
            description: 'Brainsinasin  asd',
            health: 9,
            dice: 2,
            pDamage: 1,
            pArmor: 2,
            mDamage: 0,
            mArmor: 2,
            pSkill: 0,
            mSkill: 0,
            loot: 0.25,
            xp: 25,
          )
        ]),
    NpcRace(
        icon: 'halfling',
        name: 'HALFLING',
        description: 'Halflingumans usd',
        npcType: [
          NpcType(
            type: 'HALFLING SCOUT',
            description: 'Brainsinasin  asd',
            health: 6,
            dice: 4,
            pDamage: 3,
            pArmor: 3,
            mDamage: 0,
            mArmor: 0,
            pSkill: 2,
            mSkill: 0,
            loot: 0.5,
            xp: 50,
          ),
          NpcType(
            type: 'HALFLING MUSICIAN',
            description: 'Brainsinasin  asd',
            health: 6,
            dice: 4,
            pDamage: 2,
            pArmor: 2,
            mDamage: 0,
            mArmor: 2,
            pSkill: 1,
            mSkill: 1,
            loot: 0.5,
            xp: 50,
          ),
          NpcType(
            type: 'HALFLING WIZZARD',
            description: 'Brainsinasin  asd',
            health: 6,
            dice: 4,
            pDamage: 0,
            pArmor: 0,
            mDamage: 3,
            mArmor: 3,
            pSkill: 0,
            mSkill: 2,
            loot: 0.5,
            xp: 50,
          )
        ]),
    NpcRace(
        icon: 'goblin',
        name: 'GOBLIN',
        description: 'GOOOBLINSd is dead.',
        npcType: [
          NpcType(
            type: 'GOBLIN WARRIOR',
            description: 'Brainsinasin  asd',
            health: 6,
            dice: 4,
            pDamage: 4,
            pArmor: 2,
            mDamage: 0,
            mArmor: 0,
            pSkill: 2,
            mSkill: 0,
            loot: 0.5,
            xp: 50,
          ),
          NpcType(
            type: 'GOBLIN SHAMAN',
            description: 'Brainsinasin  asd',
            health: 6,
            dice: 4,
            pDamage: 0,
            pArmor: 2,
            mDamage: 4,
            mArmor: 0,
            pSkill: 1,
            mSkill: 1,
            loot: 0.5,
            xp: 50,
          )
        ]),
    NpcRace(
        icon: 'human',
        name: 'HUMAN',
        description: 'humans bajsbdusd',
        npcType: [
          NpcType(
            type: 'HUMAN WARRIOR',
            description: 'Brainsinasin  asd',
            health: 12,
            dice: 6,
            pDamage: 4,
            pArmor: 2,
            mDamage: 0,
            mArmor: 0,
            pSkill: 2,
            mSkill: 0,
            loot: 1,
            xp: 100,
          ),
          NpcType(
            type: 'HUMAN WIZZARD',
            description: 'Brainsinasin  asd',
            health: 12,
            dice: 6,
            pDamage: 0,
            pArmor: 0,
            mDamage: 4,
            mArmor: 4,
            pSkill: 0,
            mSkill: 2,
            loot: 1,
            xp: 100,
          ),
        ]),
    NpcRace(icon: 'elf', name: 'ELF', description: 'Elf sucks ass.', npcType: [
      NpcType(
        type: 'ELF WARRIOR',
        description: 'Brainsinasin  asd',
        health: 9,
        dice: 6,
        pDamage: 4,
        pArmor: 3,
        mDamage: 0,
        mArmor: 2,
        pSkill: 1,
        mSkill: 1,
        loot: 1,
        xp: 100,
      ),
      NpcType(
        type: 'ELF WIZZARD',
        description: 'Brainsinasin  asd',
        health: 9,
        dice: 6,
        pDamage: 0,
        pArmor: 2,
        mDamage: 4,
        mArmor: 3,
        pSkill: 1,
        mSkill: 1,
        loot: 1,
        xp: 100,
      ),
    ]),
    NpcRace(
        icon: 'dwarf',
        name: 'DWARF',
        description: 'DWARF SUCKS.',
        npcType: [
          NpcType(
            type: 'DWARF WARRIOR',
            description: 'Brainsinasin  asd',
            health: 15,
            dice: 6,
            pDamage: 3,
            pArmor: 6,
            mDamage: 0,
            mArmor: 0,
            pSkill: 1,
            mSkill: 0,
            loot: 1,
            xp: 100,
          ),
          NpcType(
            type: 'DWARF CLERIC',
            description: 'Brainsinasin  asd',
            health: 15,
            dice: 6,
            pDamage: 0,
            pArmor: 6,
            mDamage: 3,
            mArmor: 0,
            pSkill: 0,
            mSkill: 1,
            loot: 1,
            xp: 100,
          ),
        ]),
    NpcRace(icon: 'orc', name: 'ORC', description: 'Orsc stincky.', npcType: [
      NpcType(
        type: 'ORC BERSERKER',
        description: 'Brainsinasin  asd',
        health: 18,
        dice: 6,
        pDamage: 8,
        pArmor: 0,
        mDamage: 0,
        mArmor: 0,
        pSkill: 1,
        mSkill: 0,
        loot: 1,
        xp: 100,
      ),
      NpcType(
        type: 'ORC FIGHTER',
        description: 'Brainsinasin  asd',
        health: 15,
        dice: 6,
        pDamage: 5,
        pArmor: 4,
        mDamage: 0,
        mArmor: 0,
        pSkill: 1,
        mSkill: 0,
        loot: 1,
        xp: 100,
      ),
      NpcType(
        type: 'ORC SHAMAN',
        description: 'Brainsinasin  asd',
        health: 15,
        dice: 6,
        pDamage: 0,
        pArmor: 3,
        mDamage: 4,
        mArmor: 2,
        pSkill: 0,
        mSkill: 1,
        loot: 1,
        xp: 100,
      ),
    ]),
    NpcRace(icon: 'ogre', name: 'OGRE', description: 'Ogre kils.', npcType: [
      NpcType(
        type: 'OGRE RAIDER',
        description: 'Brainsinasin  asd',
        health: 60,
        dice: 8,
        pDamage: 8,
        pArmor: 0,
        mDamage: 0,
        mArmor: 0,
        pSkill: 2,
        mSkill: 0,
        loot: 2,
        xp: 200,
      ),
    ]),
    NpcRace(
        icon: 'minotaur',
        name: 'MINOTAUR',
        description: 'Minotaur',
        npcType: [
          NpcType(
            type: 'MINOTAUR',
            description: 'Brainsinasin  asd',
            health: 45,
            dice: 8,
            pDamage: 5,
            pArmor: 3,
            mDamage: 0,
            mArmor: 3,
            pSkill: 2,
            mSkill: 1,
            loot: 2,
            xp: 200,
          ),
        ]),
  ];

  NpcType selectedType = NpcType(
    type: 'TYPE',
    description: '',
    health: 0,
    pDamage: 0,
    pArmor: 0,
    mDamage: 0,
    mArmor: 0,
    pSkill: 0,
    mSkill: 0,
  );

  List<NpcSkill> selectedSkills = [];

  int maxHealth = 0;
  int currentHealth = 0;
  int amount = 1;
  int totalXp;
  double totalLoot;
  List<NpcSkill> possibleSkills;

  void chooseRace(int index) {
    this.selectedRace = this.races[index];
    this.icon = this.races[index].icon;
  }

  void chooseType(int index) {
    this.selectedType = this.selectedRace.npcType[index];
    this.name = this.selectedType.type;
    this.totalXp = this.selectedType.xp;
    this.totalLoot = this.selectedType.loot;

    this.possibleSkills = npcSkills.getSkills(this.selectedType);

    for (int check = 0; check < this.selectedType.pSkill; check++) {
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

    for (int check = 0; check < this.selectedType.mSkill; check++) {
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

    this.totalXp = this.selectedType.xp * this.amount;
    this.totalLoot = this.selectedType.loot * this.amount;
  }

  void createNpc() {
    this.maxHealth = this.selectedType.health * this.amount;
    this.currentHealth = this.maxHealth;
  }

  List<NpcSkill> skillList;

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

  String npcAction() {
    String result = 'roll';

    result = '${Random().nextInt(this.selectedType.dice) + 1}';

    return result;
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
    this.amount = ((this.currentHealth - 1) ~/ this.selectedType.health) + 1;
  }

  Npc(this.icon, this.name, this.description);
}
