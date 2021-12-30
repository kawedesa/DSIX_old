import 'package:cloud_firestore/cloud_firestore.dart';

class PlayerLife {
  int? max;
  int? current;
  PlayerLife({int? max, int? current}) {
    this.max = max;
    this.current = current;
  }
  Map<String, dynamic> toMap() {
    return {
      'max': this.max,
      'current': this.current,
    };
  }

  factory PlayerLife.fromMap(Map<String, dynamic>? data) {
    return PlayerLife(
      max: data?['max'],
      current: data?['current'],
    );
  }

  factory PlayerLife.set(String race) {
    int max;
    int current;
    if (race == 'dwarf') {
      max = 25;
    } else {
      max = 20;
    }
    current = max;
    return PlayerLife(max: max, current: current);
  }

  void decrease(String gameID, String playerIndex, int value) {
    this.current = this.current! - value;
    update(gameID, playerIndex);
  }

  void increase(String gameID, String playerIndex, int value) {
    this.current = this.current! + value;
    if (this.current! > this.max!) {
      this.current = this.max;
    }
    update(gameID, playerIndex);
  }

  bool isDead() {
    if (this.current! < 1) {
      return true;
    } else {
      return false;
    }
  }

  void update(String gameID, String playerIndex) async {
    final database = FirebaseFirestore.instance.collection('game');

    await database.doc(gameID).collection('players').doc(playerIndex).update({
      'life': toMap(),
    });
  }
}
