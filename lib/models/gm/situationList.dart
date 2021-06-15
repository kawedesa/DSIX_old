import 'situation.dart';
import 'dart:math';

class SituationList {
  Situation newRandomSituation() {
    Situation situation = Situation();
    situation.newSituation();

    int randomNumber = Random().nextInt(this.list.length);
    situation = list[randomNumber];
    return situation;
  }

  List<Situation> list = [
    Situation(icon: '', name: 'RAID', description: ''),
    Situation(icon: '', name: 'REBELION', description: ''),
    Situation(icon: '', name: 'WAR', description: ''),
    Situation(icon: '', name: 'DISAPPEARANCE', description: ''),
    Situation(icon: '', name: 'KIDNAPPING', description: ''),
    Situation(icon: '', name: 'DRUGS', description: ''),
    Situation(icon: '', name: 'DISCOVERY', description: ''),
    Situation(icon: '', name: 'CELEBRATION', description: ''),
    Situation(icon: '', name: 'PROPHECY', description: ''),
    Situation(icon: '', name: 'TOURNAMENT', description: ''),
    Situation(icon: '', name: 'CORRUPTION', description: ''),
    Situation(icon: '', name: 'MARRIAGE', description: ''),
    Situation(icon: '', name: 'RACISM', description: ''),
    Situation(icon: '', name: 'MURDER', description: ''),
    Situation(icon: '', name: 'ASSASSINATION', description: ''),
    Situation(icon: '', name: 'INVASION', description: ''),
    Situation(icon: '', name: 'HURRICANE', description: ''),
    Situation(icon: '', name: 'FLOOD', description: ''),
    Situation(icon: '', name: 'FIRE', description: ''),
    Situation(icon: '', name: 'STORM', description: ''),
    Situation(icon: '', name: 'VOTE', description: ''),
    Situation(icon: '', name: 'CROWNING', description: ''),
    Situation(icon: '', name: 'GOLD', description: ''),
    Situation(icon: '', name: 'FOOD', description: ''),
    Situation(icon: '', name: 'WATER', description: ''),
    Situation(icon: '', name: 'PLAGUE', description: ''),
    Situation(icon: '', name: 'BEAST', description: ''),
    Situation(icon: '', name: 'TRUCE', description: ''),
    Situation(icon: '', name: 'REFUGEES', description: ''),
  ];
}
