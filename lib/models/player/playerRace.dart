import 'package:dsixv02app/core/app_icon.dart';
import 'package:dsixv02app/core/app_images.dart';
import 'package:dsixv02app/models/dsix/sprite.dart';
import 'package:dsixv02app/models/player/bonus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class PlayerRace {
  AppIcon icon;
  String name;
  String description;
  String sex;
  int maxHealth;
  int maxWeight;
  double size;
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

  PlayerRace copyRace() {
    PlayerRace newPlayerRace = PlayerRace(
      icon: this.icon,
      name: this.name,
      description: this.description,
      sex: this.sex,
      maxHealth: this.maxHealth,
      maxWeight: this.maxWeight,
      size: this.size,
      availableActionPoints: this.availableActionPoints,
      actionPoints: this.actionPoints,
      bonus: this.bonus,
    );
    return newPlayerRace;
  }

  void setSprite(Color color, int playerIndex) {
    switch (this.name) {
      case 'human':
        this.icon = AppIcon(
          icon: AppImages.human,
          color: color,
          index: playerIndex,
        );
        break;
      case 'orc':
        this.icon = AppIcon(
          icon: AppImages.orc,
          color: color,
          index: playerIndex,
        );
        break;
      case 'goblin':
        this.icon = AppIcon(
          icon: AppImages.goblin,
          color: color,
          index: playerIndex,
        );
        break;
      case 'dwarf':
        this.icon = AppIcon(
          icon: AppImages.dwarf,
          color: color,
          index: playerIndex,
        );
        break;
      case 'hobbit':
        this.icon = AppIcon(
          icon: AppImages.hobbit,
          color: color,
          index: playerIndex,
        );
        break;
      case 'elf':
        this.icon = AppIcon(
          icon: AppImages.elf,
          color: color,
          index: playerIndex,
        );
        break;
    }
  }

  PlayerRace(
      {AppIcon icon,
      String name,
      String description,
      String sex,
      int maxHealth,
      int maxWeight,
      double size,
      int availableActionPoints,
      List<int> actionPoints,
      List<Bonus> bonus}) {
    this.icon = icon;
    this.name = name;
    this.description = description;
    this.sex = sex;
    this.maxHealth = maxHealth;
    this.maxWeight = maxWeight;
    this.size = size;
    this.availableActionPoints = availableActionPoints;
    this.actionPoints = actionPoints;
    this.bonus = bonus;
  }
}
