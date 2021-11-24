import 'package:dsixv02app/core/app_colors.dart';
import 'package:dsixv02app/core/app_images.dart';
import 'package:dsixv02app/models/player/playerRace.dart';
import 'package:dsixv02app/models/player/bonus.dart';
import 'package:dsixv02app/models/player/playerSprite.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class PlayerRaceList {
  Color color;

  List<PlayerRace> races = [
    PlayerRace(
        name: 'human',
        description:
            'Humans are flexible and can adapt to anything. They have the worlds largest population.',
        maxHealth: 12,
        maxWeight: 16,
        size: 16,
        availableActionPoints: 3,
        actionPoints: [
          1,
          1,
          1,
          1,
          1,
          1
        ],
        bonus: [
          Bonus(
            'flexible',
            'Humans are flexible and can perform any role.',
          )
        ]),
    PlayerRace(
        name: 'orc',
        description:
            'Orcs are big and strong, making them good warriors, but easy targets.',
        maxHealth: 12,
        maxWeight: 20,
        size: 17,
        availableActionPoints: 5,
        actionPoints: [
          1,
          0,
          0,
          0,
          -1,
          0
        ],
        bonus: [
          Bonus(
            'big',
            'Your size makes it hard for you to move around.',
          ),
          Bonus(
            'strong',
            'You are strong and can carry more things.',
          ),
          Bonus(
            'warrior',
            'You are a warrior and know how to fight.',
          ),
        ]),
    PlayerRace(
        name: 'goblin',
        description:
            'Goblins are small vicious creatures with sharp teeth and quick feet.',
        maxHealth: 12,
        maxWeight: 12,
        size: 13,
        availableActionPoints: 5,
        actionPoints: [
          1,
          0,
          0,
          0,
          1,
          0
        ],
        bonus: [
          Bonus(
            'vicious',
            'You are evil and don\'t care about anyone.',
          ),
          Bonus(
            'quick feet',
            'You are fast and have quick reflexes.',
          ),
          Bonus(
            'weak',
            'You are weak and can\'t carry a lot of things.',
          )
        ]),
    PlayerRace(
        name: 'dwarf',
        description:
            'Dwarfs have long beards and love to drink. They are small, tough and stubborn.',
        maxHealth: 16,
        maxWeight: 16,
        size: 15,
        availableActionPoints: 5,
        actionPoints: [
          0,
          1,
          -1,
          0,
          0,
          0
        ],
        bonus: [
          Bonus(
            'stubborn',
            'Your size and stubborn personality limits your perception of things.',
          ),
          Bonus(
            'tough',
            'You can take more blows befores going down.',
          )
        ]),
    PlayerRace(
        name: 'hobbit',
        description:
            'Hobbits are small curious creatures, always looking for something new to learn.',
        maxHealth: 12,
        maxWeight: 16,
        size: 14,
        availableActionPoints: 5,
        actionPoints: [
          -1,
          0,
          1,
          1,
          0,
          0
        ],
        bonus: [
          Bonus(
            'peaceful',
            'You are peaceful and hate violence.',
          ),
          Bonus(
            'curious',
            'You are always intrigued by your surrounding.',
          ),
          Bonus(
            'charismatic',
            'You are friendly and people usually like you.',
          )
        ]),
    PlayerRace(
        name: 'elf',
        description:
            'Elves have quick reflexes and sharp senses, making them very agile and precise.',
        maxHealth: 12,
        maxWeight: 16,
        size: 16,
        availableActionPoints: 5,
        actionPoints: [
          0,
          -1,
          1,
          0,
          1,
          0
        ],
        bonus: [
          Bonus(
            'quick reflexes',
            'Your instinct is to get out of the way, instead of holding your ground.',
          ),
          Bonus(
            'keen senses',
            'You have perfect vision and amazing hearing.',
          ),
        ]),
  ];
}
