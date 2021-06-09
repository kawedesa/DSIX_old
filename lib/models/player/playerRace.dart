import 'bonus.dart';

class PlayerRace {
  String icon;
  String race;
  String description;
  int maxHealth;
  int maxWeight;

  List<int> actionPoints = [
    0, //0-Available Action Points
    0, //1-ATTACK
    0, //2-DEFENSE
    0, //3-PERCEIVE
    0, //4-TALK
    0, //5-MOVE
    0, //6-SKILL
  ];

  List<Bonus> bonus;

  PlayerRace(
      {String icon,
      String race,
      String description,
      int maxHealth,
      int maxWeight,
      List<int> actionPoints,
      List<Bonus> bonus}) {
    this.icon = icon;
    this.race = race;
    this.description = description;
    this.maxHealth = maxHealth;
    this.maxWeight = maxWeight;
    this.actionPoints = actionPoints;
    this.bonus = bonus;
  }
}
