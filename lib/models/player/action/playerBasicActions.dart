import 'package:dsixv02app/models/player/action/actionOption.dart';
import 'package:dsixv02app/models/player/action/playerAction.dart';

class PlayerBasicActions {
  List<PlayerAction> basicActions = [
    PlayerAction(
      icon: 'attack',
      name: 'attack',
      description: 'You try to attack or grapple a target.',
      option: [
        ActionOption(
            name: 'punch',
            description: 'You punch the target with your fists.',
            value: 0),
        ActionOption(
            name: 'weapon',
            description:
                'You attack the target with your weapon, trying to bring them down.',
            value: 0),
        ActionOption(
            name: 'grapple',
            description: 'You try to grapple the target, holding them down.',
            value: 0),
      ],
      value: 0,
      bonus: 0,
    ),
    PlayerAction(
      icon: 'defend',
      name: 'defend',
      description: 'You protect yourself and others.',
      option: [
        ActionOption(
            name: 'defend', description: 'You try to protect.', value: 0),
        ActionOption(
            name: 'resist', description: 'You try to resist.', value: 0),
        ActionOption(name: 'help', description: 'You try to help.', value: 0),
        ActionOption(
            name: 'lift',
            description: 'You try to lift something heavy.',
            value: 0),
      ],
      value: 0,
      bonus: 0,
    ),
    PlayerAction(
      icon: 'look',
      name: 'look',
      description: 'You look around and notice things.',
      option: [
        ActionOption(
            name: 'resources',
            description: 'You search for something useful.',
            value: 0),
        ActionOption(
            name: 'information',
            description: 'You try to gather information.',
            value: 0),
      ],
      value: 0,
      bonus: 0,
    ),
    PlayerAction(
      icon: 'talk',
      name: 'talk',
      description: 'You talk to someone that can understand you.',
      option: [
        ActionOption(
            name: 'trade', description: 'You try to strike a deal.', value: 0),
        ActionOption(
            name: 'information',
            description: 'You try to gather information.',
            value: 0),
        ActionOption(
            name: 'convince',
            description: 'You try to change people\'s minds.',
            value: 0),
      ],
      value: 0,
      bonus: 0,
    ),
    PlayerAction(
      icon: 'move',
      name: 'move',
      description: 'You climb, swim, hide or try to escape.',
      option: [
        ActionOption(
            name: 'dodge',
            description: 'You try to get out of the way.',
            value: 0),
        ActionOption(
            name: 'escape',
            description: 'You try to escape from a tough situation.',
            value: 0),
        ActionOption(name: 'hide', description: 'You try to hide.', value: 0),
        ActionOption(
            name: 'jump',
            description: 'You try to jump over an obstacle.',
            value: 0),
        ActionOption(name: 'climb', description: 'You try to climb.', value: 0),
        ActionOption(name: 'swim', description: 'You try to swim.', value: 0)
      ],
      value: 0,
      bonus: 0,
    ),
  ];
}
