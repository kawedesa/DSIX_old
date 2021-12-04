import 'package:dsixv02app/core/app_Colors.dart';
import 'package:flutter/material.dart';

class Player {
  String id;
  PlayerColor color;
  double dx;
  double dy;
  String race;
  int life;
  int maxLife;
  Player(
      {String id,
      PlayerColor color,
      double dx,
      double dy,
      String race,
      int life,
      int maxLife}) {
    this.id = id;
    this.color = color;
    this.dx = dx;
    this.dy = dy;
    this.race = race;
    this.life = life;
    this.maxLife = maxLife;
  }

  Map<String, dynamic> saveToDataBase(Player player) {
    return {
      'id': player.id,
      'dx': player.dx,
      'dy': player.dy,
      'race': player.race,
      'life': player.life,
      'maxLife': player.maxLife,
    };
  }

  factory Player.fromMap(Map data) {
    return Player(
      id: data['id'],
      dx: data['dx'] * 1.0,
      dy: data['dy'] * 1.0,
      race: data['race'],
      life: data['life'],
      maxLife: data['maxLife'],
    );
  }

  Player newPlayer(int playerIndex) {
    switch (playerIndex) {
      case 0:
        {
          return Player(
            id: 'blue',
          );
        }
        break;
      case 1:
        {
          return Player(
            id: 'pink',
          );
        }
        break;
      case 2:
        {
          return Player(
            id: 'green',
          );
        }
        break;
      case 3:
        {
          return Player(
            id: 'yellow',
          );
        }
        break;
      case 4:
        {
          return Player(
            id: 'purple',
          );
        }
        break;
    }
    return Player(
      id: 'blue',
    );
  }

  void setColor() {
    if (this.color != null) {
      return;
    }
    switch (this.id) {
      case 'blue':
        {
          this.color = PlayerColor(
              primary: AppColors.bluePlayerPrimary,
              secondary: AppColors.bluePlayerSecondary);
        }
        break;
      case 'pink':
        {
          this.color = PlayerColor(
              primary: AppColors.pinkPlayerPrimary,
              secondary: AppColors.pinkPlayerSecondary);
        }
        break;
      case 'green':
        {
          this.color = PlayerColor(
              primary: AppColors.greenPlayerPrimary,
              secondary: AppColors.greenPlayerSecondary);
        }
        break;
      case 'yellow':
        {
          this.color = PlayerColor(
              primary: AppColors.yellowPlayerPrimary,
              secondary: AppColors.yellowPlayerSecondary);
        }
        break;
      case 'purple':
        {
          this.color = PlayerColor(
              primary: AppColors.purplePlayerPrimary,
              secondary: AppColors.purplePlayerSecondary);
        }
        break;
    }
  }

  void setAttributeBasedOnRace() {
    switch (this.race) {
      case 'dwarf':
        {
          this.maxLife = 16;
          this.life = maxLife;
        }
        break;
      case 'orc':
        {
          this.maxLife = 12;
          this.life = maxLife;
        }
        break;
    }
  }

  int getCurrentLife() {
    return this.life;
  }

  void reduceCurrentLife(int value) {
    this.life -= value;
  }

  void increaseCurrentLife(int value) {
    this.life += value;
  }

  bool checkIfPlayerIsDead() {
    if (this.life < 1) {
      return true;
    } else {
      return false;
    }
  }
}

class PlayerColor {
  Color primary;
  Color secondary;
  PlayerColor({Color primary, Color secondary}) {
    this.primary = primary;
    this.secondary = secondary;
  }
}

class PlayerTemporaryLocation extends ChangeNotifier {
  double dx = 0;
  double dy = 0;

  void changePlayerLocation(double dx, double dy) {
    this.dx += dx;
    this.dy += dy;
    notifyListeners();
  }

  void updatePlayerSprite(
    double dx,
    double dy,
  ) {
    this.dx = dx;
    this.dy = dy;
    notifyListeners();
  }
}
