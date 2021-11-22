import 'package:dsixv02app/models/player/effectSystem.dart';
import 'package:dsixv02app/models/player/player.dart';
import 'package:dsixv02app/models/player/action/playerAction.dart';
import 'package:dsixv02app/widgets/selector.dart';

class ActionPageVM {
  Selector selector = Selector();
  EffectSystem _effectSystem = EffectSystem();

  PlayerAction selectedAction = PlayerAction(
    name: 'actions',
    description:
        'These represents the strenghts and weaknesses of your character. Click on the action to assign points to it. The more points you have, the better you are in that action.',
    option: [],
  );

  String actionDialogTitle;

  void selectAction(Player player, int index) {
    this.selectedAction = player.actions[index];
    this.actionDialogTitle = this.selectedAction.name;
    selector.select(index);
  }

  void changeActionPointValue(int value, Player player, PlayerAction action) {
    if (action.value + value > 3) {
      return;
    }

    if (action.value + value < -3) {
      return;
    }

    switch (action.name) {
      case 'attack':
        if (value > 0) {
          _effectSystem.addEffect('positive', 'powerful', 1, player);
        } else {
          _effectSystem.addEffect('negative', 'weak', 1, player);
        }

        break;

      case 'defend':
        if (value > 0) {
          _effectSystem.addEffect('positive', 'defensive', 1, player);
        } else {
          _effectSystem.addEffect('negative', 'vulnerable', 1, player);
        }
        break;
      case 'look':
        if (value > 0) {
          _effectSystem.addEffect('positive', 'perceptive', 1, player);
        } else {
          _effectSystem.addEffect('negative', 'dull', 1, player);
        }
        break;
      case 'talk':
        if (value > 0) {
          _effectSystem.addEffect('positive', 'charismatic', 1, player);
        } else {
          _effectSystem.addEffect('negative', 'inconvenient', 1, player);
        }
        break;
      case 'walk':
        if (value > 0) {
          _effectSystem.addEffect('positive', 'fast', 1, player);
        } else {
          _effectSystem.addEffect('negative', 'slow', 1, player);
        }
        break;
    }
  }
}
