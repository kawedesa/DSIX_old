import 'player.dart';

class User {
  String? id;

  void selectPlayer(
    String? id,
  ) {
    this.id = id;
  }

  Player getPlayer(List<Player> players) {
    Player? selectedPlayer;

    players.forEach((player) {
      if (player.id != this.id) {
        return;
      }
      selectedPlayer = player;
    });
    return selectedPlayer!;
  }
}
