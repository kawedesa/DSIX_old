import 'package:cloud_firestore/cloud_firestore.dart';

class Turn {
  int index;
  String id;
  bool firstAction;
  bool secondAction;
  Turn({int index, String id, bool firstAction, bool secondAction}) {
    this.index = index;
    this.id = id;
    this.firstAction = firstAction;
    this.secondAction = secondAction;
  }

  final db = FirebaseFirestore.instance;
  factory Turn.fromMap(Map data) {
    return Turn(
      index: data['index'],
      id: data['id'],
      firstAction: data['firstAction'],
      secondAction: data['secondAction'],
    );
  }
  Map<String, dynamic> toMap(Turn turn) {
    return {
      'index': turn.index,
      'id': turn.id,
      'firstAction': turn.firstAction,
      'secondAction': turn.secondAction,
    };
  }

  Turn newTurn(String playerID, int index) {
    return Turn(
      index: index,
      id: playerID,
      firstAction: true,
      secondAction: true,
    );
  }

  void takeTurn() async {
    if (this.firstAction) {
      this.firstAction = false;
      await db
          .collection('turnOrder')
          .doc('${this.index}')
          .update({'firstAction': this.firstAction});
    } else {
      this.secondAction = false;
    }
  }

  bool turnIsNotOver() {
    if (this.secondAction) {
      return true;
    } else {
      return false;
    }
  }
}
