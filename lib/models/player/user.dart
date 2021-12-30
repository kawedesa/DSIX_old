import 'dart:math';
import 'package:dsixv02app/models/shop/item.dart';
import 'package:dsixv02app/shared/app_Exceptions.dart';
import '../turn/turn.dart';
import 'player.dart';

class User {
  String? selectedPlayerID;
  Player? selectedPlayer;
  String? playerMode = 'walk';
  bool playerTurn = false;
  bool menuIsOpen = false;

  void changeSelectPlayer(List<Player> players, String playerID) {
    for (int i = 0; i < players.length; i++) {
      if (players[i].id == playerID) {
        selectPlayer(
          playerID,
          players[i],
        );
      }
    }
  }

  void selectPlayer(
    String? id,
    Player? player,
  ) {
    this.selectedPlayerID = id;
    this.selectedPlayer = player;
  }

  void updateSelectedPlayer(Player player) {
    this.selectedPlayer = player;
  }

  void checkForPlayerTurn(List<Turn> turnOrder) {
    if (turnOrder.isEmpty) {
      throw NotPlayerTurnException();
    }

    if (turnOrder.first.id != this.selectedPlayerID) {
      throw NotPlayerTurnException();
    }

    if (this.selectedPlayer!.action!.outOfActions() &&
        this.playerTurn == false) {
      throw StartPlayerTurnException();
    }
    throw ContinuePlayerTurnException();
  }

  void startPlayerTurn(
    String gameID,
  ) {
    this.playerTurn = true;
    setPlayerMode();
    this
        .selectedPlayer!
        .action!
        .newActions(gameID, this.selectedPlayer!.index!.toString());

    this.selectedPlayer!.clearTempEffects(gameID);
  }

  void continuePlayerTurn() {
    this.playerTurn = true;
    setPlayerMode();
  }

  void endPlayerTurn() {
    this.playerTurn = false;
    setPlayerMode();
  }

  void setPlayerMode() {
    if (this.playerTurn) {
      if (this.playerMode == 'wait') {
        walkMode();
      }
      if (this.menuIsOpen) {
        waitMode();
      }
    } else {
      waitMode();
    }
  }

  void openCloseMenu() {
    if (this.menuIsOpen) {
      if (this.playerTurn) {
        walkMode();
      } else {
        waitMode();
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

  void equipItem(String gameID, Item item) {
    if (playerTurn == false) {
      return;
    }
    switch (item.itemSlot) {
      case 'oneHand':
        if (this.selectedPlayer!.iventory!.mainHandSlot!.name != '' &&
            this.selectedPlayer!.iventory!.offHandSlot!.name != '') {
          this
              .selectedPlayer!
              .unequip(gameID, this.selectedPlayer!.iventory!.mainHandSlot!);
        }
        if (this.selectedPlayer!.iventory!.mainHandSlot!.name != '') {
          this.selectedPlayer!.iventory!.offHandSlot = item;
        } else {
          this.selectedPlayer!.iventory!.mainHandSlot = item;
        }
        break;
      case 'twoHands':
        if (this.selectedPlayer!.iventory!.mainHandSlot!.name != '') {
          this
              .selectedPlayer!
              .unequip(gameID, this.selectedPlayer!.iventory!.mainHandSlot!);
        }
        if (this.selectedPlayer!.iventory!.offHandSlot!.name != '') {
          this
              .selectedPlayer!
              .unequip(gameID, this.selectedPlayer!.iventory!.offHandSlot!);
        }

        this.selectedPlayer!.iventory!.mainHandSlot = item;
        this.selectedPlayer!.iventory!.offHandSlot = item;

        break;
      case 'head':
        if (this.selectedPlayer!.iventory!.headSlot!.name != '') {
          this
              .selectedPlayer!
              .unequip(gameID, this.selectedPlayer!.iventory!.headSlot!);
        }
        this.selectedPlayer!.iventory!.headSlot = item;

        break;
      case 'body':
        if (this.selectedPlayer!.iventory!.bodySlot!.name != '') {
          this
              .selectedPlayer!
              .unequip(gameID, this.selectedPlayer!.iventory!.bodySlot!);
        }
        this.selectedPlayer!.iventory!.bodySlot = item;

        break;
      case 'hands':
        if (this.selectedPlayer!.iventory!.handSlot!.name != '') {
          this
              .selectedPlayer!
              .unequip(gameID, this.selectedPlayer!.iventory!.handSlot!);
        }
        this.selectedPlayer!.iventory!.handSlot = item;

        break;
      case 'feet':
        if (this.selectedPlayer!.iventory!.feetSlot!.name != '') {
          this
              .selectedPlayer!
              .unequip(gameID, this.selectedPlayer!.iventory!.feetSlot!);
        }
        this.selectedPlayer!.iventory!.feetSlot = item;

        break;
    }

    this.selectedPlayer!.equipItem(gameID, item);
  }

  void unequipItem(String gameID, Item item) {
    if (playerTurn == false) {
      return;
    }
    this.selectedPlayer!.unequip(gameID, item);
  }

  void useItem(String gameID, Item item) {
    if (playerTurn == false) {
      return;
    }
    switch (item.name) {
      case 'ward':
        this.selectedPlayer!.vision!.tempVision =
            this.selectedPlayer!.vision!.tempVision! + 50;
        this.selectedPlayer!.vision!.canSeeInvisible = true;
        this
            .selectedPlayer!
            .vision!
            .update(gameID, this.selectedPlayer!.index.toString());
        break;
      case 'food':
        int healingAmount = Random().nextInt(3) + 1;
        this.selectedPlayer!.life!.increase(
            gameID, this.selectedPlayer!.index.toString(), healingAmount);

        break;

      case 'healing potion':
        int healingAmount = Random().nextInt(3) + 4;
        this.selectedPlayer!.life!.increase(
            gameID, this.selectedPlayer!.index.toString(), healingAmount);

        break;
      case 'ward':
        break;
    }
    this
        .selectedPlayer!
        .iventory!
        .destroyItem(gameID, this.selectedPlayer!.index.toString(), item);
  }
}
