import 'game.dart';
import 'player.dart';

class User {
  int selectedPlayerIndex;
  Player selectedPlayer;
  String playerMode = 'walk';
  bool playerTurn = false;

  void changeSelectPlayer(List<Player> players, String playerID) {
    for (int i = 0; i < players.length; i++) {
      if (players[i].id == playerID) {
        selectPlayer(i, players[i]);
      }
    }
  }

  void selectPlayer(int index, Player player) {
    this.selectedPlayerIndex = index;
    this.selectedPlayer = player;
  }

  void checkForPlayerTurn(List<Turn> turnOrder) {
    if (turnOrder.first.id != this.selectedPlayer.id) {
      this.playerMode = 'wait';
      this.playerTurn = false;
      return;
    } else {
      this.playerMode = 'walk';
      this.playerTurn = true;
    }
  }

  void onTapAction(List<Turn> turnOrder) {
    switch (this.playerMode) {
      case 'menu':
        checkForPlayerTurn(turnOrder);
        break;
      case 'walk':
        this.playerMode = 'menu';
        break;
      case 'wait':
        this.playerMode = 'menu';
        break;
      case 'attack':
        this.playerMode = 'menu';
        break;
    }
  }

  void attackMode() {
    this.playerMode = 'attack';
  }

  void changeSelectedPlayerLocation(
    double dx,
    double dy,
  ) async {
    final batch = db.batch();
    final document = db.collection('players').doc(this.selectedPlayer.id);
    batch.update(document, {'dx': dx, 'dy': dy});
    await batch.commit();
  }

  void passTurn(int index) async {
    wait();
    await db.collection('turnOrder').doc('$index').delete();
  }

  void wait() {
    this.playerMode = 'wait';
    this.playerTurn = false;
  }

  void newTurnOrder(List<Player> players) {
    List<Player> randomPlayerOrder = [];
    players.forEach((player) {
      randomPlayerOrder.add(player);
    });
    randomPlayerOrder.shuffle();

    List<Turn> newTurnOrder = [];

    for (int i = 0; i < randomPlayerOrder.length; i++) {
      newTurnOrder.add(Turn().newTurn(randomPlayerOrder[i].id, i));
    }
    checkForPlayerTurn(newTurnOrder);

    newTurnOrder.forEach((turn) {
      addTurnToDataBase(turn);
    });
  }

  void addTurnToDataBase(Turn turn) async {
    await db
        .collection('turnOrder')
        .doc('${turn.index}')
        .set(turn.saveToDataBase(turn));
  }
}
