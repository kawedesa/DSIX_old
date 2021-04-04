import 'npc.dart';

class Gm {
  List<Npc> npcList = [
    Npc('npc', 'NPC',
        'An NPC is a character that you control. So pretty much eveyone besides the players. Click on the the buttons below to create a new NPC.')
  ];

  void createNpc() {
    Npc newNpc = new Npc('newNpc', 'NEW NPC', '');

    this.npcList.add(newNpc);
  }

  Gm();
}
