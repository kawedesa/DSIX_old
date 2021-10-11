import 'package:dsixv02app/models/player/bonus.dart';

class PlayerRace {
  String icon;
  String name;
  String description;
  String sex;
  int maxHealth;
  int maxWeight;
  int availableActionPoints;

  List<int> actionPoints = [
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
      String name,
      String description,
      String sex,
      int maxHealth,
      int maxWeight,
      int availableActionPoints,
      List<int> actionPoints,
      List<Bonus> bonus}) {
    this.icon = icon;
    this.name = name;
    this.description = description;
    this.sex = sex;
    this.maxHealth = maxHealth;
    this.maxWeight = maxWeight;
    this.availableActionPoints = availableActionPoints;
    this.actionPoints = actionPoints;
    this.bonus = bonus;
  }
}
