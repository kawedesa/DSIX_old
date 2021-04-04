import '../player/player.dart';
import 'shop.dart';
import 'package:dsixv02app/models/gm/gm.dart';

class Dsix {
  int currentPlayerIndex;

  List<Player> players = [];

  // Gm gm;

  Gm gm = new Gm();

  static Shop shop;

  Dsix();

  void setCurrentPlayer(int playerIndex) {
    this.currentPlayerIndex = playerIndex;
  }

  Player getCurrentPlayer() {
    return this.players[this.currentPlayerIndex];
  }
}
