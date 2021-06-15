class Situation {
  String icon;
  String name;
  String description;

  Situation({String icon, String name, String description}) {
    this.icon = icon;
    this.name = name;
    this.description = description;
  }

  Situation newSituation() {
    Situation newSituation = Situation(
      icon: '',
      name: '',
      description: '',
    );
    return newSituation;
  }

  Situation copySituation() {
    Situation newSituation = Situation(
      icon: this.icon,
      name: this.name,
      description: this.description,
    );
    return newSituation;
  }
}
