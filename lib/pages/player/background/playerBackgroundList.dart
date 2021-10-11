import 'package:dsixv02app/models/dsix/shop.dart';
import 'package:dsixv02app/models/player/playerBackground.dart';
import 'package:dsixv02app/models/player/bonus.dart';

Shop shop = new Shop();

class PlayerBackgroundList {
  List<PlayerBackground> backgrounds = [
    PlayerBackground(
        icon: 'noble',
        name: 'noble',
        description:
            'Your life is filled with money and gifts. Your family is well known, and most people respect you.',
        bonus: [
          Bonus(
            'gold',
            'You are rich and get an extra \$300 gold.',
          ),
          Bonus(
            'fame',
            'You are famous and receive special treatment.',
          ),
        ],
        bonusItem: []),
    PlayerBackground(
        icon: 'fighter',
        name: 'fighter',
        description:
            'You move around, from place to place, looking for blood and coin. People stay out of your way, by will or by force.',
        bonus: [
          Bonus(
            '${shop.armor[1].name}',
            '${shop.armor[1].description}',
          ),
          Bonus(
            '${shop.armor[0].name}',
            '${shop.armor[0].description}',
          ),
          Bonus(
            '${shop.armor[3].name}',
            '${shop.armor[3].description}',
          )
        ],
        bonusItem: [
          shop.armor[0],
          shop.armor[1],
          shop.armor[3],
        ]),
    PlayerBackground(
        icon: 'thief',
        name: 'thief',
        description:
            'You have quick hands and a burning desire for treasure. Some people steal out of necessity, others do it for fun. You do it because you can.',
        bonus: [
          Bonus(
            '2x ${shop.rangedWeapons[4].name}',
            '${shop.rangedWeapons[4].description}',
          )
        ],
        bonusItem: [
          shop.rangedWeapons[4],
          shop.rangedWeapons[4],
        ]),
    PlayerBackground(
        icon: 'mage',
        name: 'mage',
        description:
            'You are familiar with magic. Either born with it or taught by a mentor. Most people see you as a freak and keep their distance.',
        bonus: [
          Bonus(
            '${shop.magicWeapons[5].name}',
            '${shop.magicWeapons[5].description}',
          )
        ],
        bonusItem: [
          shop.magicWeapons[5],
        ]),
    PlayerBackground(
        icon: 'hunter',
        name: 'hunter',
        description:
            'You spend most of your time hunting for game. You are not really used to people and feel more comfortable outdoors.',
        bonus: [
          Bonus(
            '${shop.rangedWeapons[6].name}',
            '${shop.rangedWeapons[6].description}',
          ),
          Bonus(
            '${shop.resources[4].name}',
            '${shop.resources[4].description}',
          ),
        ],
        bonusItem: [
          shop.rangedWeapons[6],
          shop.resources[4],
        ]),
    PlayerBackground(
        icon: 'medic',
        name: 'medic',
        description:
            'You already saved many lives and people respect you. Blood, diseases, guts and bones don\'t bother you.',
        bonus: [
          Bonus(
            '${shop.armor[6].name}',
            '${shop.armor[6].description}',
          ),
          Bonus(
            '${shop.resources[10].name}',
            '${shop.resources[10].description}',
          ),
        ],
        bonusItem: [
          shop.armor[6],
          shop.resources[10],
        ]),
  ];
}
