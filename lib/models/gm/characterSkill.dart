class CharacterSkill {
  String icon;
  String name;
  String skillType;
  String description;

  int value;

  CharacterSkill newSkill() {
    CharacterSkill newSkill = new CharacterSkill(
      icon: this.icon,
      name: this.name,
      skillType: this.skillType,
      description: this.description,
      value: this.value,
    );

    return newSkill;
  }

  CharacterSkill({
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
