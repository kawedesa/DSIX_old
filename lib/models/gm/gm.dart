import 'quest.dart';
import 'package:dsixv02app/models/gm/npcTypeList.dart';
import 'package:dsixv02app/models/gm/npc.dart';

class Gm {
  List<Quest> questList = [];

  Quest selectedQuest = Quest(
    icon: 'quest',
    name: 'NEW QUEST',
    description:
        'Each quest should feel unique and have a different backstory. Double tap this text to edit the description and write your own story.',
    character: '-',
    background: '-',
    personality: '-',
    look: '-',
    objective: '-',
    target: '-',
    location: '-',
    reward: '-',
  );

  void createQuest() {
    Quest newQuest = new Quest(
      icon: 'quest',
      name: 'NEW QUEST',
      description:
          'Each quest should feel unique and have a different backstory. Double tap this text to edit the description and write your own story.',
      character: '-',
      background: '-',
      personality: '-',
      look: '-',
      objective: '-',
      target: '-',
      location: '-',
      reward: '-',
    );
    this.questList.add(newQuest);
  }

  List<Npc> npcList = [];

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

  Gm();
}
