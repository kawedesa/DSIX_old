class NpcSkill {
  String icon;
  String name;
  String skillType;
  String description;

  int value;

  NpcSkill addSkill() {
    NpcSkill newSkill = new NpcSkill(
      icon: this.icon,
      name: this.name,
      description: this.description,
      value: this.value,
    );

    return newSkill;
  }

  NpcSkill({
    String icon,
    String name,
    String skillType,
    String description,
    int value,
  }) {
    this.icon = icon;
    this.name = name;
    this.skillType = skillType;
    this.description = description;

    this.value = value;
  }
}
