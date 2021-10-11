class Effect {
  String icon;
  String name;
  String description;
  String origin;
  int duration;
  int value;

  Effect({
    String icon,
    String name,
    String description,
    String origin,
    int duration,
    int value,
  }) {
    this.icon = icon;
    this.name = name;
    this.description = description;
    this.origin = origin;
    this.duration = duration;
    this.value = value;
  }

  Effect copyEffect() {
    Effect newEffect = Effect(
      icon: (this.icon == null) ? '' : this.icon,
      name: (this.name == null) ? '' : this.name,
      description: (this.description == null) ? '' : this.description,
      origin: (this.origin == null) ? '' : this.origin,
      duration: (this.duration == null) ? 0 : this.duration,
      value: (this.value == null) ? 0 : this.value,
    );
    return newEffect;
  }
}
