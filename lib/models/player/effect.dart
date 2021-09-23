class Effect {
  String icon;
  String name;
  String description;
  bool permanent;
  String type;
  int duration;
  int value;

  Effect({
    String icon,
    String name,
    String description,
    bool permanent,
    String type,
    int duration,
    int value,
  }) {
    this.icon = icon;
    this.name = name;
    this.description = description;
    this.permanent = permanent;
    this.type = type;
    this.duration = duration;
    this.value = value;
  }

  Effect copyEffect() {
    Effect newEffect = Effect(
      icon: this.icon,
      name: this.name,
      description: this.description,
      permanent: this.permanent,
      type: this.type,
      duration: this.duration,
      value: this.value,
    );

    return newEffect;
  }
}
