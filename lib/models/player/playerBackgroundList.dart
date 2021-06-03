import 'package:dsixv02app/models/player/playerBackground.dart';
import 'package:dsixv02app/models/game/shop.dart';
import 'package:dsixv02app/models/player/bonus.dart';

Shop shop = new Shop();

class PlayerBackgroundList {
  List<PlayerBackground> backgrounds = [
    PlayerBackground(
        'noble',
        'NOBLE',
        'Your life is filled with money and gifts. Your family is well known, and most people respect you.',
        [
          Bonus(
            'GOLD',
            'gold',
            'You are rich! So you get an extra \$400 gold.',
          ),
          Bonus(
            'FAME',
            'fame',
            'You are famous and receive special treatment.',
          ),
        ],
        []),
    PlayerBackground(
        'fighter',
        'FIGHTER',
        'You move around, from place to place, looking for blood and coin. People stay out of your way, by will or by force.',
        [
          Bonus(
            'GLOVES',
            'item',
            '${shop.armor[1].description}',
          ),
          Bonus(
            'BOOTS',
            'item',
            '${shop.armor[0].description}',
          ),
          Bonus(
            'HELMET',
            'item',
            '${shop.armor[3].description}',
          )
        ],
        [
          shop.armor[0],
          shop.armor[1],
          shop.armor[3],
        ]),
    PlayerBackground(
        'thief',
        'THIEF',
        'You have quick hands and a burning desire for treasure. Some people steal out of necessity, others do it for fun. You do it because you can.',
        [
          Bonus(
            '2x KUNAIS   ',
            'item',
            '${shop.rangedWeapons[4].description}',
          )
        ],
        [
          shop.rangedWeapons[4],
          shop.rangedWeapons[4],
        ]),
    PlayerBackground(
        'mage',
        'MAGE',
        'You are familiar with magic. Either born with it or taught by a mentor. Most people see you as a freak and keep their distance.',
        [
          Bonus(
            'SPELLBOOK',
            'item',
            '${shop.magicWeapons[5].description}',
          )
        ],
        [
          shop.magicWeapons[5],
        ]),
    PlayerBackground(
        'hunter',
        'HUNTER',
        'You spend most of your time hunting for game. You are not really used to people and feel more comfortable outdoors.',
        [
          Bonus(
            'LONG BOW  ',
            'item',
            '${shop.rangedWeapons[6].description}',
          ),
          Bonus(
            'AMMO  ',
            'item',
            '${shop.resources[4].description}',
          ),
        ],
        [
          shop.rangedWeapons[6],
          shop.resources[1],
        ]),
    PlayerBackground(
        'medic',
        'MEDIC',
        'You already saved many lives and people respect you. Blood, diseases, guts and bones don\'t bother you.',
        [
          Bonus(
            '2x HEALING POTION   ',
            'item',
            '${shop.resources[10].description}',
          ),
        ],
        [
          shop.resources[10],
          shop.resources[10],
        ]),
    PlayerBackground(
        '',
        'BACKGROUND',
        'This represents your story. How you where raised and how people see you. Click on the icons above to choose your background.',
        [
          Bonus(
            'BONUS',
            'bonus',
            'All backgrounds are unique and have different bonuses. They can be items, gold, and passive attributes, like armor and damage.',
          )
        ],
        []),

    //OLD BACKGROUNDS

    //PlayerBackground(2,'Merchant','You are a successful merchant and know the real value of things. Nobody gets in between you and a good deal.','\$ 400',[]),
    //PlayerBackground(3,'Spy','You have many names, but none of them are real. You leave no footsteps behind.','GLOVES, BOOTS, GEAR',[shop.shopList[80], shop.shopList[67],shop.shopList[65],]),
    //PlayerBackground(4,'Prisoner','You are a criminal and nobody believes in you. You have nothing, but a key and the will to escape.','KEY',[shop.shopList[81]]),
    //PlayerBackground(5,'Pirate','You believe that laws are stupid and nobody can own something they can\'t protect. The world is there for the taking.','HAND CANNON',[shop.shopList[39]]),
    //PlayerBackground(7,'Worker','You are the pillar of any society and do the heavy lifting, while the nobles drink their wine.','TOOL GEAR',[shop.shopList[80],shop.shopList[80],]),
    //PlayerBackground(8,'Cook','You are an alchemist of smells and flavours. There is nothing more powerful than a tasty meal.','CLEAVER GEAR',[shop.shopList[80],shop.shopList[80],]),
    //PlayerBackground(10,'Detective','You are needed, because justice is blind. You can always tell when someone is lying.','WARD, WARD',[shop.shopList[82],shop.shopList[82],]),
    //PlayerBackground(11,'Performer','You are comfortable around people and love to the center of attention. Laughter, music, wine and love are your trade.','LUCKY CHARM, LUCKY CHARM',[shop.shopList[89],shop.shopList[89],]),
    //PlayerBackground(14,'Student','You are very curious about everything and believes that knowledge is power. There is always something new to be learned.','BOOK, BOOK, GEAR',[shop.shopList[78],shop.shopList[78],shop.shopList[80],]),
    //PlayerBackground(15,'Traveler','You wear different clothes and have a different accent. People don\'t know where you came from or where you are going.','SCROLL',[shop.shopList[46],shop.shopList[51],]),
    //PlayerBackground(16,'Assassin','You live a solitary life and trust no one. You are an agent of destruction and death is your only partner. ','DAGGER, KUNAI, ANTIDOTE',[shop.shopList[3],shop.shopList[35],shop.shopList[71],]),
    //PlayerBackground(18,'Fugitive','You are running from your past, and nothing will make you go back. You are going to be fine if you stay one step ahead.','FREE ACTION, BOOTS',[shop.shopList[65],shop.shopList[88],]),
  ];
}
