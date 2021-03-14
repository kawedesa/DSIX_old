import 'ability.dart';

class Npc{

  int npcLife;
  int npcAbilityPoint;

  List<Ability> abilityList = List<Ability>.empty(growable: true);


  Npc(this.npcLife, this.npcAbilityPoint);

}