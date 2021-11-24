import 'package:dsixv02app/models/dsix/shop.dart';
import 'package:dsixv02app/models/gm/gm.dart';
import 'package:dsixv02app/models/player/player.dart';
import 'package:dsixv02app/models/world/world.dart';
import 'package:dsixv02app/core/app_colors.dart';
import 'package:flutter/material.dart';

class Dsix {
  World world = new World();

  Shop shop = new Shop();

  bool gameStarted = false;

  void newGame() {
    createNewPlayers();
    gameStarted = true;
  }

// Players
  List<Player> players = [];

  Player createPlayer(int index) {
    Player newPlayer;

    switch (index) {
      case 0:
        newPlayer = Player(
            playerCreated: false,
            index: 0,
            name: 'pink',
            primaryColor: AppColors.pinkPrimaryColor,
            secondaryColor: AppColors.pinkSecondaryColor,
            tertiaryColor: AppColors.pinkTertiaryColor);

        return newPlayer;
        break;
      case 1:
        newPlayer = Player(
            playerCreated: false,
            index: 1,
            name: 'blue',
            primaryColor: AppColors.bluePrimaryColor,
            secondaryColor: AppColors.blueSecondaryColor,
            tertiaryColor: AppColors.blueTertiaryColor);

        return newPlayer;
        break;
      case 2:
        newPlayer = Player(
            playerCreated: false,
            index: 2,
            name: 'green',
            primaryColor: AppColors.greenPrimaryColor,
            secondaryColor: AppColors.greenSecondaryColor,
            tertiaryColor: AppColors.greenTertiaryColor);

        return newPlayer;
        break;
      case 3:
        newPlayer = Player(
            playerCreated: false,
            index: 3,
            name: 'yellow',
            primaryColor: AppColors.yellowPrimaryColor,
            secondaryColor: AppColors.yellowSecondaryColor,
            tertiaryColor: AppColors.yellowTertiaryColor);

        return newPlayer;
        break;
      case 4:
        newPlayer = Player(
            playerCreated: false,
            index: 4,
            name: 'purple',
            primaryColor: AppColors.purplePrimaryColor,
            secondaryColor: AppColors.purpleSecondaryColor,
            tertiaryColor: AppColors.purpleTertiaryColor);

        return newPlayer;
        break;
    }
    return newPlayer;
  }

  void resetPlayer(int index) {
    List<Player> keepPlayers = [];

    this.players.forEach((element) {
      if (element.index != index) {
        keepPlayers.add(element);
      } else {
        Player newPlayer = createPlayer(index);
        keepPlayers.add(newPlayer);
      }
    });

    this.players = [];

    keepPlayers.forEach((element) {
      this.players.add(element);
    });
  }

  void createNewPlayers() {
    if (this.players.isNotEmpty) {
      return;
    }
    this.players.add(createPlayer(0));
    this.players.add(createPlayer(1));
    this.players.add(createPlayer(2));
    this.players.add(createPlayer(3));
    this.players.add(createPlayer(4));
  }

  int checkPlayers() {
    int numberPlayers = 0;

    this.players.forEach((element) {
      if (element.playerCreated) {
        numberPlayers++;
      }
    });

    return numberPlayers;
  }

// Get Player

  int currentPlayerIndex;

  void setCurrentPlayer(int playerIndex) {
    this.currentPlayerIndex = playerIndex;
  }

  // int getPlayerIndex(Color color) {
  //   for (int i = 0; i < this.players.length; i++) {
  //     if (this.players[i].primaryColor == color) {
  //       return i;
  //     }
  //   }
  //   return 0;
  // }

  Player getCurrentPlayer() {
    return this.players[this.currentPlayerIndex];
  }

// GM

  Gm gm = new Gm();
}
