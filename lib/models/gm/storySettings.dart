class StorySettings {
  String icon;
  String name;
  String description;

  int numberOfQuests;
  int questXp;
  int totalXp = 0;
  int questGold;
  int totalGold = 0;

  StorySettings({
    String icon,
    String name,
    String description,
    int numberOfQuests,
    int questXp,
    int totalXp,
    int questGold,
    int totalGold,
  }) {
    this.icon = icon;
    this.name = name;
    this.description = description;

    this.numberOfQuests = numberOfQuests;
    this.questXp = questXp;
    this.totalXp = totalXp;
    this.questGold = questGold;
    this.totalGold = totalGold;
  }
}
