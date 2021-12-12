import 'package:cloud_firestore/cloud_firestore.dart';
import 'player.dart';

class User {
  final db = FirebaseFirestore.instance;
  int selectedPlayerIndex;
  Player selectedPlayer;
  String playerMode;

  void selectPlayer(Player player, int playerIndex) {
    this.selectedPlayer = player;
    this.selectedPlayerIndex = playerIndex;
  }

  void setPlayerModeBasedOnPlayerTurn(bool isPlayerTurn) {
    if (isPlayerTurn) {
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
    if (this.playerMode == 'attack') {
      this.playerMode = 'menu';
    }
    this.playerMode = 'attack';
  }

  void openOrCloseMenu(bool isPlayerTurn) {
    if (this.playerMode == 'menu') {
      if (isPlayerTurn) {
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
  }

  void updateSelectedPlayer(Player player) {
    this.selectedPlayer = player;
  }

  void updateSelectedPlayerLocation(double dx, dy) {
    this.selectedPlayer.dx = dx;
    this.selectedPlayer.dy = dy;
  }
}
