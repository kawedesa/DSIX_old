import 'package:dsixv02app/models/gm/loot.dart';
import 'package:dsixv02app/models/gm/newQuest.dart';
import 'package:dsixv02app/models/gm/npc.dart';

class Campaign {
  String difficulty = 'NORMAL';
  String name;

  void chooseDifficulty() {
    switch (this.difficulty) {
      case 'NORMAL':
        {
          fame = 1;
          questXP = 1;
          questGold = 100;
        }
        break;
    }
  }

  int fame = 1;
  int round = 0;
  int questXP = 1;
  int questGold = 100;

  List<Quest> questList;

  void createQuest() {
    Quest newQuest;

    questList.add(newQuest.newQuest());
  }

  List<Npc> npcList;
  List<Loot> lootList;

//  Quest selectedQuest = Quest(
//     icon: 'quest',
//     name: 'NEW QUEST',
//     questDescription:
//         'Each quest should feel unique and have a different backstory. Double tap this text to edit the description and write your own story.',
//     character: '-',
//     background: '-',
//     personality: '-',
//     characterDescription: '-',
//     objective: '-',
//     target: '-',
//     location: '-',
//     reward: '-',
//   );

//   void createQuest() {
//     Quest newQuest = new Quest(
//       icon: 'quest',
//       name: 'NEW QUEST',
//       questDescription:
//           'Each quest should feel unique and have a different backstory. Double tap this text to edit the description and write your own story.',
//       character: '-',
//       background: '-',
//       personality: '-',
//       characterDescription: '-',
//       objective: '-',
//       target: '-',
//       location: '-',
//       reward: '-',
//     );

//     this.selectedQuest = newQuest;

//     this.questList.add(newQuest);
//   }

// //NPCS AND MONSTERS

//   List<Npc> npcList = [];

//   int npcLayout = 0;

//   Npc selectedNpc = Npc(
//     icon: 'null',
//     image: 'goblin',
//     name: 'NPC',
//     description:
//         'An NPC is a character that you control. So pretty much eveyone besides the players. Click on the the buttons below to create a new NPC.',
//   );

//   List<Npc> npcTypeList = new NpcTypeList().npcType;

//   void createNpc(Npc npc) {
//     Npc newNpc = npc.newNpc();

//     newNpc.prepareNpc();

//     this.npcList.add(newNpc);
//   }

// //LOOT

//   Loot selectedLoot = Loot(
//     icon: 'loot',
//     name: 'NEW LOOT',
//     lootDescription:
//         'Each loot should have an interesting orign. Like the sword of an old king or the artifacts of a powerful wizzard. Double tap this text to edit it and write your own description.',
//   );

//   List<Loot> lootList = [];

//   void createLoot(int value) {
//     Loot newLoot = new Loot(
//       icon: 'loot',
//       name: 'NEW LOOT',
//       lootDescription:
//           'Each loot should have an interesting orign. Like the sword of an old king or the artifacts of a powerful wizzard. Double tap this text to edit it and write your own description.',
//     );

//     newLoot.newLoot(value);

//     int setIcon = 0;
//     newLoot.itemList.forEach((element) {
//       if (element.value >= setIcon) {
//         newLoot.icon = element.icon;
//         setIcon = element.value;
//       }
//     });

//     lootList.add(newLoot);

//     this.selectedLoot = newLoot;
//   }
}
