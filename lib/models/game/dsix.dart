import '../player/player.dart';
import 'shop.dart';

class Dsix {
  int currentPlayerIndex;

  List<Player> players = [];

  // Gm gm;

  static Shop shop;

  Dsix();

  void setCurrentPlayer(int playerIndex) {
    this.currentPlayerIndex = playerIndex;
  }

  Player getCurrentPlayer() {
    return this.players[this.currentPlayerIndex];
  }
}
