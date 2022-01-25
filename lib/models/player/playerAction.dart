import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dsixv02app/shared/app_Exceptions.dart';

class PlayerAction {
  bool? firstAction;
  bool? secondAction;
  PlayerAction(
      {int? index, String? id, bool? firstAction, bool? secondAction}) {
    this.firstAction = firstAction;
    this.secondAction = secondAction;
  }

  factory PlayerAction.fromMap(Map<String, dynamic>? data) {
    return PlayerAction(
      firstAction: data?['firstAction'],
      secondAction: data?['secondAction'],
    );
  }
  Map<String, dynamic> toMap() {
    return {
      'firstAction': this.firstAction,
      'secondAction': this.secondAction,
    };
  }

  factory PlayerAction.empty() {
    return PlayerAction(
      firstAction: false,
      secondAction: false,
    );
  }

  void newActions(String gameID, String playerIndex) {
    this.firstAction = true;
    this.secondAction = true;
    updatePlayerActions(gameID, playerIndex);
  }

  void takeAction(String gameID, String playerIndex) {
    if (this.firstAction!) {
      this.firstAction = false;
    } else {
      this.secondAction = false;
    }
    updatePlayerActions(gameID, playerIndex);
    if (outOfActions()) {
      throw EndPlayerTurnException();
    }
  }

  bool outOfActions() {
    if (this.secondAction!) {
      return false;
    } else {
      return true;
    }
  }

  void updatePlayerActions(String gameID, String playerIndex) async {
    final database = FirebaseFirestore.instance.collection('game');
    await database
        .doc(gameID)
        .collection('players')
        .doc(playerIndex)
        .update({'action': toMap()});
  }
}
