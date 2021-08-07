class Effect {
  String icon;
  String name;
  String description;
  String typeOfEffect;
  int duration = 0;

  Effect({
    String icon,
    String name,
    String description,
    String typeOfEffect,
    int value,
    int duration,
  }) {
    this.icon = icon;
    this.name = name;
    this.description = description;
    this.typeOfEffect = typeOfEffect;
    this.duration = duration;
  }

  Effect copyEffect() {
    Effect newEffect = Effect(
      icon: this.icon,
      name: this.name,
      description: this.description,
      typeOfEffect: this.typeOfEffect,
      duration: this.duration,
    );

    return newEffect;
  }
}