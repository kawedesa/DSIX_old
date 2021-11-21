import 'package:dsixv02app/core/app_images.dart';
import 'package:dsixv02app/models/dsix/sprite.dart';
import 'package:dsixv02app/models/player/bonus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class PlayerRace {
  String icon;
  String name;
  Sprite sprite;
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

  void setSprite(Color color) {
    switch (this.name) {
      case 'human':
        this.sprite = new Sprite(
          layers: [
            SvgPicture.asset(
              AppImages.human,
              color: color,
              width: double.infinity,
              height: double.infinity,
            ),
          ],
          size: this.size,
        );
        break;
      case 'orc':
        this.sprite = new Sprite(layers: [
          SvgPicture.asset(
            AppImages.orc,
            color: color,
            width: double.infinity,
            height: double.infinity,
          ),
        ], size: this.size);
        break;
      case 'goblin':
        this.sprite = new Sprite(layers: [
          SvgPicture.asset(
            AppImages.goblin,
            color: color,
            width: double.infinity,
            height: double.infinity,
          ),
        ], size: this.size);
        break;
      case 'dwarf':
        this.sprite = new Sprite(layers: [
          SvgPicture.asset(
            AppImages.dwarf,
            color: color,
            width: double.infinity,
            height: double.infinity,
          ),
        ], size: this.size);
        break;
      case 'hobbit':
        this.sprite = new Sprite(layers: [
          SvgPicture.asset(
            AppImages.hobbit,
            color: color,
            width: double.infinity,
            height: double.infinity,
          ),
        ], size: this.size);
        break;
      case 'elf':
        this.sprite = new Sprite(layers: [
          SvgPicture.asset(
            AppImages.elf,
            color: color,
            width: double.infinity,
            height: double.infinity,
          ),
        ], size: this.size);
        break;
    }
  }

  PlayerRace(
      {Sprite sprite,
      String icon,
      String name,
      String description,
      String sex,
      int maxHealth,
      int maxWeight,
      double size,
      int availableActionPoints,
      List<int> actionPoints,
      List<Bonus> bonus}) {
    this.sprite = sprite;
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
