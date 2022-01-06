import 'package:dsixv02app/models/player/player.dart';
import 'enemyPlayerSprite/enemyPlayerSprite.dart';

class EnemyController {
  List<EnemyPlayerSprite> enemyPlayers = [];

  void updateEnemyPlayersInSight(List<Player> players, Player selectedPlayer) {
    this.enemyPlayers = [];

    players.forEach((target) {
      if (target.id == selectedPlayer.id) {
        return;
      }

      if (selectedPlayer.vision!
          .canSeeEnemyPlayer(target.location!, selectedPlayer.location!)) {
        this.enemyPlayers.add(EnemyPlayerSprite(
              enemyPlayer: target,
            ));
      }
    });
  }
}
