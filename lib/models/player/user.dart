import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dsixv02app/models/game/fog/fog.dart';
import 'package:dsixv02app/models/game/gameMap/tallGrassArea.dart';
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
  final firebase = FirebaseFirestore.instance.collection('game');

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

  void endWalk(
    String gameID,
    PlayerLocation newLocation,
    TallGrassArea tallGrass,
  ) async {
    this.selectedPlayer!.location!.dx = newLocation.dx;
    this.selectedPlayer!.location!.dy = newLocation.dy;

    if (inTallGrass(tallGrass)) {
      this.selectedPlayer!.isVisible = false;
    } else {
      this.selectedPlayer!.isVisible = true;
    }

    await firebase
        .doc(gameID)
        .collection('players')
        .doc('${this.selectedPlayer!.index}')
        .update({
      'location': newLocation.toMap(),
      'isVisible': this.selectedPlayer!.isVisible
    });
  }

  bool inTallGrass(TallGrassArea tallgrass) {
    bool inThere = false;

    tallgrass.totalArea!.forEach((grass) {
      if (inThere) {
        return;
      }
      inThere = grass.inHere(this.selectedPlayer!.location!.getLocation());
    });

    return inThere;
  }

  void takeAction(String gameID) async {
    this.selectedPlayer!.action!.takeAction();

    await firebase
        .doc(gameID)
        .collection('players')
        .doc('${this.selectedPlayer!.index}')
        .update({'action': this.selectedPlayer!.action!.toMap()});
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

  void startPlayerTurn(String gameID, Fog fog) {
    this.playerTurn = true;
    setPlayerMode();
    this.selectedPlayer!.action!.newActions();
    updateActions(gameID);
    checkFog(gameID, fog);
    clearTempEffects(gameID);
  }

  void updateActions(String gameID) async {
    await firebase
        .doc(gameID)
        .collection('players')
        .doc('${this.selectedPlayer!.index}')
        .update({'action': this.selectedPlayer!.action!.toMap()});
  }

  void checkFog(String gameID, Fog fog) {
    double distance =
        (this.selectedPlayer!.location!.getLocation() - fog.getLocation())
            .distance;
    if (distance >= fog.size! / 2) {
      takeFogDamage(gameID);
    }
  }

  void takeFogDamage(
    String gameID,
  ) async {
    PlayerLife newLife = PlayerLife(
        max: this.selectedPlayer!.life!.max,
        current: this.selectedPlayer!.life!.current! - 2);

    await firebase
        .doc(gameID)
        .collection('players')
        .doc('${this.selectedPlayer!.index}')
        .update({'life': newLife.toMap()});
  }

  void clearTempEffects(String gameID) {
    this.selectedPlayer!.clearTempEffects();
    updateTempArmor(gameID);
    updateVision(gameID);
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

  void look(String gameID) {
    this.selectedPlayer!.vision!.look();
    updateVision(gameID);
  }

  void defend(String gameID) {
    this.selectedPlayer!.defend();
    updateTempArmor(gameID);
  }

  void useItem(String gameID, Item item) {
    switch (item.name) {
      case 'ward':
        this.selectedPlayer!.vision!.tempVision = 50;
        this.selectedPlayer!.vision!.canSeeInvisible = true;
        updateVision(gameID);
        break;
      case 'food':
        int healingAmount = Random().nextInt(3) + 1;
        this.selectedPlayer!.life!.increaseCurrentLife(healingAmount);
        updateLife(gameID);
        break;

      case 'healing potion':
        int healingAmount = Random().nextInt(3) + 4;
        this.selectedPlayer!.life!.increaseCurrentLife(healingAmount);
        updateLife(gameID);
        break;
      case 'ward':
        break;
    }
    this.selectedPlayer!.destroyItem(item);
    updateBag(gameID);
  }

  void updateLife(String gameID) async {
    await firebase
        .doc(gameID)
        .collection('players')
        .doc('${this.selectedPlayer!.index}')
        .update({
      'life': this.selectedPlayer!.life!.toMap(),
    });
  }

  void updateVision(String gameID) async {
    await firebase
        .doc(gameID)
        .collection('players')
        .doc('${this.selectedPlayer!.index}')
        .update({
      'vision': this.selectedPlayer!.vision!.toMap(),
    });
  }

  void updateTempArmor(String gameID) async {
    await firebase
        .doc(gameID)
        .collection('players')
        .doc('${this.selectedPlayer!.index}')
        .update({
      'tempArmor': this.selectedPlayer!.tempArmor,
    });
  }

  void updateBag(
    String gameID,
  ) async {
    var updatedBag =
        this.selectedPlayer!.bag!.map((item) => item.toMap()).toList();

    await firebase
        .doc(gameID)
        .collection('players')
        .doc('${this.selectedPlayer!.index}')
        .update({
      'bag': updatedBag,
      'weight': this.selectedPlayer!.weight!.toMap(),
    });
  }

  void updateIventory(
    String gameID,
  ) async {
    List<Map<String, dynamic>> updatedBag =
        this.selectedPlayer!.bag!.map((item) => item.toMap()).toList();

    await firebase
        .doc(gameID)
        .collection('players')
        .doc('${this.selectedPlayer!.index}')
        .update({
      'bag': updatedBag,
      'mainHandSlot': this.selectedPlayer!.mainHandSlot!.toMap(),
      'offHandSlot': this.selectedPlayer!.offHandSlot!.toMap(),
      'headSlot': this.selectedPlayer!.headSlot!.toMap(),
      'bodySlot': this.selectedPlayer!.bodySlot!.toMap(),
      'handSlot': this.selectedPlayer!.handSlot!.toMap(),
      'feetSlot': this.selectedPlayer!.feetSlot!.toMap(),
      'pDamage': this.selectedPlayer!.pDamage,
      'mDamage': this.selectedPlayer!.mDamage,
      'pArmor': this.selectedPlayer!.pArmor,
      'mArmor': this.selectedPlayer!.mArmor,
      'attackRange': this.selectedPlayer!.attackRange!.toMap(),
    });
  }

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
}
