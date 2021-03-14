import '../player/player.dart';

class Dsix {
  int currentPlayerIndex;

  List<Player> players = [];

  // Gm gm;

  Dsix();

  void setCurrentPlayer(int playerIndex) {
    this.currentPlayerIndex = playerIndex;
  }

  Player getCurrentPlayer() {
    return this.players[this.currentPlayerIndex];
  }
}
