import 'package:dsixv02app/models/gm/npcTypeList.dart';
import 'package:dsixv02app/models/gm/npc.dart';
import 'package:dsixv02app/models/gm/loot.dart';
import 'story.dart';
import 'package:dsixv02app/models/player/player.dart';

class Gm {
  // SET PLAYERS

  // SET DIFFICULTY AND STORY

  Story story = Story();

  void startQuest() {
    this.story.acceptQuest();
  }

//NPCS AND MONSTERS

  List<Npc> npcList = [];

  int npcLayout = 0;

  Npc selectedNpc = Npc(
    icon: 'null',
    image: 'goblin',
    name: 'NPC',
    description:
        'An NPC is a character that you control. So pretty much eveyone besides the players. Click on the the buttons below to create a new NPC.',
  );

  List<Npc> npcTypeList = new NpcTypeList().npcType;

  void createNpc(Npc npc) {
    Npc newNpc = npc.newNpc();

    newNpc.prepareNpc();

    this.npcList.add(newNpc);
  }

//LOOT

  Loot selectedLoot = Loot(
    icon: 'loot',
    name: 'NEW LOOT',
    lootDescription:
        'Each loot should have an interesting orign. Like the sword of an old king or the artifacts of a powerful wizzard. Double tap this text to edit it and write your own description.',
  );

  List<Loot> lootList = [];

  void createLoot(int value) {
    Loot newLoot = new Loot(
      icon: 'loot',
      name: 'NEW LOOT',
      lootDescription:
          'Each loot should have an interesting orign. Like the sword of an old king or the artifacts of a powerful wizzard. Double tap this text to edit it and write your own description.',
    );

    newLoot.newLoot(value);

    int setIcon = 0;
    newLoot.itemList.forEach((element) {
      if (element.value >= setIcon) {
        newLoot.icon = element.icon;
        setIcon = element.value;
      }
    });

    lootList.add(newLoot);

    this.selectedLoot = newLoot;
  }

//TURNS

  Gm();
}
