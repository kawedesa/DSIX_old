import 'package:dsixv02app/models/game/gameMap/totalArea.dart';
import 'package:dsixv02app/models/player/player.dart';
import 'enemyPlayerSprite/enemyPlayerSprite.dart';

class EnemyController {
  List<EnemyPlayerSprite> enemyPlayers = [];

  void updateEnemyPlayersInSight(
      List<Player> players, Player selectedPlayer, TotalArea tallGrass) {
    this.enemyPlayers = [];

    players.forEach((target) {
      if (target.id == selectedPlayer.id) {
        return;
      }

      if (selectedPlayer.vision!.canSeeEnemyPlayer(
          target.location!, selectedPlayer.location!, tallGrass)) {
        this.enemyPlayers.add(EnemyPlayerSprite(
              player: selectedPlayer,
              enemyPlayer: target,
            ));
      }
    });
  }
}
