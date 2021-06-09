class StorySettings {
  String icon;
  String name;
  String description;
  int fame;
  int numberOfQuests;
  int questXp;
  int questGold;

  StorySettings({
    String icon,
    String name,
    String description,
    int fame,
    int numberOfQuests,
    int questXp,
    int questGold,
  }) {
    this.icon = icon;
    this.name = name;
    this.description = description;
    this.fame = fame;
    this.numberOfQuests = numberOfQuests;
    this.questXp = questXp;
    this.questGold = questGold;
  }
}
