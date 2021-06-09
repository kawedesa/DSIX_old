class StorySettings {
  String icon;
  String name;
  String description;
  int fame;
  int numberOfQuests;

  StorySettings({
    String icon,
    String name,
    String description,
    int fame,
    int questXp,
    int questGold,
    int numberOfQuests,
  }) {
    this.icon = icon;
    this.name = name;
    this.description = description;
    this.fame = fame;
    this.numberOfQuests = numberOfQuests;
  }
}
