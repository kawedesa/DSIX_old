import 'package:dsixv02app/shared/app_Exceptions.dart';
import 'player.dart';

class User {
  Player? selectedPlayer;
  String? playerMode = 'walk';
  bool menuIsOpen = false;

  void changeSelectPlayer(List<Player> players, String playerID) {
    for (int i = 0; i < players.length; i++) {
      if (players[i].id == playerID) {
        selectPlayer(
          players[i],
        );
      }
    }
  }

  void selectPlayer(
    Player? player,
  ) {
    this.selectedPlayer = player;
  }

  void checkForPlayerTurn(String playerID) {
    if (this.selectedPlayer!.id != playerID) {
      setPlayerMode();
      return;
    }

    if (this.selectedPlayer!.action!.outOfActions()) {
      throw StartPlayerTurnException();
    }

    setPlayerMode();
  }

  void startPlayerTurn(
    String gameID,
  ) {
    this.selectedPlayer!.action!.newActions(gameID, this.selectedPlayer!.id!);
    this.selectedPlayer!.clearTempEffects(gameID);
    setPlayerMode();
  }

  void setPlayerMode() {
    if (this.selectedPlayer!.action!.outOfActions()) {
      waitMode();
    } else {
      if (this.playerMode == 'wait') {
        walkMode();
      }
      if (this.menuIsOpen) {
        waitMode();
      }
    }
  }

  void openCloseMenu() {
    if (this.menuIsOpen) {
      if (this.selectedPlayer!.action!.outOfActions()) {
        waitMode();
      } else {
        walkMode();
      }
      this.menuIsOpen = false;
    } else {
      this.menuIsOpen = true;
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
    this.menuIsOpen = false;
  }
}
