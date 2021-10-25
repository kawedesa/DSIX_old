import 'package:dsixv02app/models/dsix/shop.dart';
import 'package:dsixv02app/models/gm/gm.dart';
import 'package:dsixv02app/models/player/player.dart';
import 'package:dsixv02app/models/world/world.dart';
import 'package:dsixv02app/core/app_colors.dart';

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

  Player createPlayer(String color) {
    Player newPlayer;

    switch (color) {
      case 'pink':
        newPlayer = Player(
            name: 'pink',
            primaryColor: AppColors.pinkPrimaryColor,
            secondaryColor: AppColors.pinkSecondaryColor,
            tertiaryColor: AppColors.pinkTertiaryColor);

        return newPlayer;
        break;
      case 'blue':
        newPlayer = Player(
            name: 'blue',
            primaryColor: AppColors.bluePrimaryColor,
            secondaryColor: AppColors.blueSecondaryColor,
            tertiaryColor: AppColors.blueTertiaryColor);

        return newPlayer;
        break;
      case 'green':
        newPlayer = Player(
            name: 'green',
            primaryColor: AppColors.greenPrimaryColor,
            secondaryColor: AppColors.greenSecondaryColor,
            tertiaryColor: AppColors.greenTertiaryColor);

        return newPlayer;
        break;
      case 'yellow':
        newPlayer = Player(
            name: 'yellow',
            primaryColor: AppColors.yellowPrimaryColor,
            secondaryColor: AppColors.yellowSecondaryColor,
            tertiaryColor: AppColors.yellowTertiaryColor);

        return newPlayer;
        break;
      case 'purple':
        newPlayer = Player(
            name: 'purple',
            primaryColor: AppColors.purplePrimaryColor,
            secondaryColor: AppColors.purpleSecondaryColor,
            tertiaryColor: AppColors.purpleTertiaryColor);

        return newPlayer;
        break;
    }
    return newPlayer;
  }

  Player deletePlayer(Player player) {
    Player newPlayer = Player();

    if (player.primaryColor == AppColors.pinkPrimaryColor) {
      newPlayer = createPlayer('pink');
      return newPlayer;
    }
    if (player.primaryColor == AppColors.bluePrimaryColor) {
      newPlayer = createPlayer('blue');
      return newPlayer;
    }
    if (player.primaryColor == AppColors.greenPrimaryColor) {
      newPlayer = createPlayer('green');
      return newPlayer;
    }
    if (player.primaryColor == AppColors.yellowPrimaryColor) {
      newPlayer = createPlayer('yellow');
      return newPlayer;
    }
    if (player.primaryColor == AppColors.purplePrimaryColor) {
      newPlayer = createPlayer('purple');
      return newPlayer;
    }
    return newPlayer;
  }

  void createNewPlayers() {
    if (this.players.isNotEmpty) {
      return;
    }
    this.players.add(createPlayer('pink'));
    this.players.add(createPlayer('blue'));
    this.players.add(createPlayer('green'));
    this.players.add(createPlayer('yellow'));
    this.players.add(createPlayer('purple'));
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

  Player getCurrentPlayer() {
    return this.players[this.currentPlayerIndex];
  }

// GM

  Gm gm = new Gm();
}
