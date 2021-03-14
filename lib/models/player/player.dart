import 'package:dsixv02app/item.dart';
import 'package:dsixv02app/playerBackground.dart';
import 'package:flutter/material.dart';
import 'package:dsixv02app/playerRace.dart';
import 'package:dsixv02app/option.dart';
import 'package:dsixv02app/playerAction.dart';
import 'package:dsixv02app/buff.dart';
import 'exceptions.dart';

class PlayerColor {
  String name;
  Color primaryColor;
  Color secondaryColor;
  Color tertiaryColor;

  PlayerColor(
      this.name, this.primaryColor, this.secondaryColor, this.tertiaryColor);
}

class Player {
  // var playerIndex;

  PlayerColor playerColor;

  String name = '';

  PlayerRace race;

  int playerSex;
  PlayerBackground background;

  int actionPoint; //.
  int currentHealth;
  int maxHealth;

  // o background pode mudar
  int pDamage;
  int mDamage;
  int pArmor;
  int mArmor;

  int currentWeight;
  int maxWeight;
  int gold;

  int actionsTaken = 0;

  Item headEquip = Item(
    'head',
    '',
    '',
    '',
    '',
    0,
    0,
    0,
    0,
    0,
    0,
    0,
  );
  Item bodyEquip = Item(
    'body',
    '',
    '',
    '',
    '',
    0,
    0,
    0,
    0,
    0,
    0,
    0,
  );
  Item mainHandEquip = Item(
    'mainHand',
    '',
    '',
    '',
    '',
    0,
    0,
    0,
    0,
    0,
    0,
    0,
  );

  Item offHandEquip = Item(
    'offHand',
    '',
    '',
    '',
    '',
    0,
    0,
    0,
    0,
    0,
    0,
    0,
  );
  Item handsEquip = Item(
    'hands',
    '',
    '',
    '',
    '',
    0,
    0,
    0,
    0,
    0,
    0,
    0,
  );
  Item feetEquip = Item(
    'feet',
    '',
    '',
    '',
    '',
    0,
    0,
    0,
    0,
    0,
    0,
    0,
  );

  int attack(bool withWeapon, int damage) {
    if (withWeapon) {
      if (this.mainHandEquip.name == '' && this.offHandEquip.name == '') {
        throw new NoWeaponException();
      }

      if (this.mainHandEquip.itemClass == 'rangedWeapon' &&
          this.offHandEquip.itemClass != 'ammo') {
        throw new NoAmmoException(
            'You don\'t have enough ammo to use your ${this.mainHandEquip.name}.');
      }

      if (this.offHandEquip.itemClass == 'rangedWeapon' &&
          this.mainHandEquip.itemClass != 'ammo') {
        throw new NoAmmoException(
            'You don\'t have enough ammo to use your ${this.mainHandEquip.name}.');
      }

      this.mainHandEquip.uses--;
      this.offHandEquip.uses--;

      return damage + this.mDamage + this.pDamage;
    }

    return damage;
  }

  List<PlayerAction> playerAction = [
    PlayerAction(
        'attack',
        'ATTACK',
        'You attack the target with your fists or weapon.',
        [
          Option(
              'PUNCH',
              'You punch the target with your bare fists, trying to knock them out.',
              'You hit them on a weak spot. Roll your damage.',
              'You hit them. Roll your damage.',
              'You miss the target and open your guard.'),
          Option(
              'WEAPON',
              'You attack the target with your weapon, trying to bring them down.',
              'You hit them on a weak spot. Roll your damage.',
              'You hit them. Roll your damage.',
              'You miss the target and open your guard.')
        ],
        0,
        false),
    PlayerAction(
        'defend',
        'DEFEND',
        'You defend yourself and others around you.',
        [
          Option(
              'PHYSICAL DEFENSE',
              'You face the danger, raise your shield and brace for impact. ',
              'You raise your guard in time. Roll to see how much you defend.',
              'You brace for impact and take the blow. Roll to see how much you defend.',
              'You can\'t raise your guard in time and take full damage.'),
          Option(
              'MAGIC DEFENSE',
              'You cast an enchantment that defends yourself and others around you.',
              'Your defense is ready in time. Roll to see how much you defend.',
              'Your defense is not fully ready. Roll to see how much you defend.',
              'You can\'t defend in time and take full damage.')
        ],
        0,
        false),
    PlayerAction(
        'perceive',
        'PERCEIVE',
        'You look around and search of something.',
        [
          Option(
              'RESOURCES',
              'You search for something useful, like potions, items, and resources.',
              'You find something very useful near by.',
              'You find something very useful, but it\'s out of reach.',
              'You find something bad'),
          Option(
              'INFORMATION',
              'You look around and try to gather information for this questions: \n\nWhat happened here? \nWhat\'s about to happen? \nWho is in control?',
              'You gather meaningful information.',
              'You gather information, but it costs you.',
              'You find something really bad.'),
          Option(
              'DANGER',
              'You search for signs of danger, trying to prevent an encounter.',
              'You spot danger before it becomes a problem.',
              'You spot danger coming your way.',
              'You are exposed to a hidden danger.'),
          Option(
              'PLACE',
              'You look for hidden doors, passages or rooms.',
              'You find a hidden room, shortcut or passage.',
              'You find a hidden room, shortcut or passage, but the entrance is blocked.',
              'You find something bad')
        ],
        0,
        false),
    PlayerAction(
        'talk',
        'TALK',
        'You talk to someone that can understand you.',
        [
          Option(
              'BARGAIN',
              'You bargain with them, trying to strike a deal on your favor.',
              'They agree to the terms and accept your offer.',
              'They accept, but ask for more in return.',
              'You uncover an ugly truth.'),
          Option(
              'INFORMATION',
              'You talk to someone and try to gather information on a specific subject.',
              'You receive valuable information.',
              'They will share what they know, but ask for something in return.',
              'You receive bad news.'),
          Option(
              'PERSUADE',
              'You persuade people to follow your lead or see things your way.',
              'You convince them and they follow your lead.',
              'They see your point, but ask for something in return.',
              'They are offended and see you as an enemy.'),
        ],
        0,
        false),
    PlayerAction(
        'move',
        'MOVE',
        'You jump, climb, dodge, hide, or escape from danger.',
        [
          Option(
              'DODGE',
              'You move out of the way of an attack, avoid a trap or dodge an arrow.',
              'You dodge and receive no damage.',
              'You are not that quick and receive half of the damage.',
              'You can\'t dodge in time and take full damage.'),
          Option(
              'ESCAPE',
              'You release your shackles, run away from danger or free yourself from a tough situation.',
              'You escape without any trouble.',
              'You escape, but call unwanted attention.',
              'You can\'t escape in time'),
          Option(
              'HIDE',
              'You avoid being seen by someone or sneak pass some guards.',
              'You are concealed and nobody notices you.',
              'You are hidden, but someone notice your presence.',
              'You are exposed and people find you.'),
          Option(
              'JUMP',
              'You jump over a gap, try to reach for something or pass over an obstacle.',
              'You reach your goal and land exactly where you wanted.',
              'You reach your goal, but land in a different place near by.',
              'You stumble, hesitate and fail. Something bad happens.'),
          Option(
              'CLIMB',
              'You climb a wall, a rope or the back of a giant.',
              'You reach your goal without any trouble.',
              'You face some difficulty and make to halfway.',
              'You slide, fall and fail.')
        ],
        0,
        false),
    PlayerAction(
        'skill',
        'SKILL',
        'This is your signature move and what you are known for. Choose your skill by clicking on the icons above.',
        [
          Option(
              'OPTIONS',
              'Some skills have more than one option or effect to choose from.',
              'Success.',
              'Half Success.',
              'Fail.')
        ],
        0,
        false),
  ];

  List<Item> inventory = [];

  List<Buff> buffList = [];

  Player(this.playerColor);

  void setColor(PlayerColor playerColor) {
    this.playerColor = playerColor;
  }
}
