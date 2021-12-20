import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dsixv02app/shared/app_Exceptions.dart';
import 'player.dart';

class User {
  final db = FirebaseFirestore.instance;
  int selectedPlayerIndex;
  Player selectedPlayer;
  String playerMode = 'wait';
  bool playerTurn = false;

  void selectPlayer(Player player, int playerIndex) {
    this.selectedPlayer = player;
    this.selectedPlayerIndex = playerIndex;
  }

  void startPlayerTurn() {
    if (playerTurn) {
      return;
    }
    playerTurn = true;
    throw StartPlayerTurnException();
  }

  void endPlayerTurn() {
    this.playerTurn = false;
  }

  void setPlayerModeBasedOnPlayerTurn() {
    if (this.playerMode == null) {
      this.playerMode = 'wait';
    }
    if (this.playerTurn) {
      if (this.playerMode == 'wait') {
        walkMode();
      }
    } else {
      if (this.playerMode != 'menu') {
        waitMode();
      }
    }
  }

  void walkMode() {
    this.playerMode = 'walk';
  }

  void waitMode() {
    this.playerMode = 'wait';
  }

  void attackMode() {
    this.playerMode = 'attack';
  }

  void openOrCloseMenu() {
    if (this.playerMode == 'menu') {
      if (this.playerTurn) {
        walkMode();
      } else {
        waitMode();
      }
    } else {
      this.playerMode = 'menu';
    }
  }

  void changeSelectPlayer(List<Player> players, String playerID) {
    for (int i = 0; i < players.length; i++) {
      if (players[i].id == playerID) {
        selectPlayer(players[i], i);
      }
    }
    endPlayerTurn();
  }

  void updateSelectedPlayer(Player player) {
    this.selectedPlayer = player;
  }

  void endWalk(double dx, dy) async {
    this.selectedPlayer.dx = dx;
    this.selectedPlayer.dy = dy;

    final batch = db.batch();
    final document = db.collection('players').doc(this.selectedPlayer.id);
    batch.update(
        document, {'dx': this.selectedPlayer.dx, 'dy': this.selectedPlayer.dy});
    await batch.commit();
  }
}
