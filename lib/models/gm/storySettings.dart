class StorySettings {
  String icon;
  String name;
  String description;
  int fame;
  int questXp;
  int questGold;
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
    this.questXp = questXp;
    this.questGold = questGold;
    this.numberOfQuests = numberOfQuests;
  }
}
