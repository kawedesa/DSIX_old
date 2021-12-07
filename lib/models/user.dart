import 'player.dart';

class User {
  int selectedPlayerIndex;

  void selectPlayer(int index) {
    this.selectedPlayerIndex = index;
  }

  void changeSelectPlayer(List<Player> players, String playerID) {
    for (int i = 0; i < players.length; i++) {
      if (players[i].id == playerID) {
        selectedPlayerIndex = i;
      }
    }
  }
}
