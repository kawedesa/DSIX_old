import 'package:dsixv02app/models/player/player.dart';
import 'package:dsixv02app/models/player/action/playerAction.dart';
import 'package:dsixv02app/widgets/selector.dart';

class ActionPageVM {
  Selector selector = Selector();

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
}
