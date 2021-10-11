import 'package:dsixv02app/models/player/action/actionOption.dart';
import 'package:dsixv02app/models/player/action/playerAction.dart';

class PlayerSkillList {
  List<PlayerAction> skills = [
    PlayerAction(
      icon: 'secondSkin',
      name: 'second skin',
      description: 'You become an animal and gain new abilities.',
      option: [
        ActionOption(
            name: 'morph',
            description: 'Your body and belongings morph into a new shape.',
            value: 0),
      ],
      value: 0,
      bonus: 0,
    ),
    PlayerAction(
      icon: 'illusion',
      name: 'illusion',
      description: 'You create illusions that trick people\'s minds.',
      option: [
        ActionOption(
            name: 'illusion',
            description:
                'You can trick everyone around, making them see, hear, feel or smeal things.',
            value: 0),
      ],
      value: 0,
      bonus: 0,
    ),
    PlayerAction(
      icon: 'bomber',
      name: 'bomber',
      description:
          'You throw a bomb that causes different effects on explosion.',
      option: [
        ActionOption(
          name: 'fire bomb',
          description: 'It explodes on impact.',
          value: 0,
        ),
        ActionOption(
          name: 'smoke bomb',
          description: 'It creates a thick cloud of smoke.',
          value: 0,
        ),
        ActionOption(
          name: 'ice bomb',
          description: 'It freezes anything it touches.',
          value: 0,
        ),
      ],
      value: 0,
      bonus: 0,
    ),
    PlayerAction(
      icon: 'transmute',
      name: 'transmute',
      description: 'You change the environment around you.',
      option: [
        ActionOption(name: 'dig', description: 'You create a hole.', value: 0),
        ActionOption(name: 'hold', description: 'You hold someone.', value: 0),
        ActionOption(
            name: 'build',
            description: 'You build a simple structure.',
            value: 0),
        ActionOption(
            name: 'destroy',
            description: 'You destroy an object or structure.',
            value: 0),
      ],
      value: 0,
      bonus: 0,
    ),
    PlayerAction(
      icon: 'shifter',
      name: 'shifter',
      description: 'You change your voice and appearance.',
      option: [
        ActionOption(
            name: 'transform',
            description:
                'Your body and voice changes to mach the person of your choice.',
            value: 0)
      ],
      value: 0,
      bonus: 0,
    ),
    PlayerAction(
      icon: 'enchant',
      name: 'enchant',
      description: 'You can bless or curse someone you touch.',
      option: [
        ActionOption(
            name: 'bless',
            description:
                'You make them see through walls, hear whispers or track a scent from far away.',
            value: 0),
        ActionOption(
            name: 'curse',
            description: 'You make them blind, deaf or numb.',
            value: 0)
      ],
      value: 0,
      bonus: 0,
    ),
  ];
}
