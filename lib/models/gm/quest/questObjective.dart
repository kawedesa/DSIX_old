import 'dart:math';
import 'package:dsixv02app/models/gm/quest/questTarget.dart';

class QuestObjective {
  String objective;

  QuestTarget target;

  QuestObjective newRandomObjective() {
    QuestObjective newObjective = QuestObjective();

    List<QuestObjective> availableQuests = [
      QuestObjective(
        objective: 'escort',
        target: QuestTarget().newTarget('escort'),
      ),
      // QuestObjective(
      //   objective: 'control',
      //   target: QuestTarget().newTarget('control'),
      // ),
      // QuestObjective(
      //   objective: 'destroy',
      //   target: QuestTarget().newTarget('destroy'),
      // ),
      // QuestObjective(
      //   objective: 'protect',
      //   target: QuestTarget().newTarget('protect'),
      // ),
    ];

    int randomNumber = Random().nextInt(availableQuests.length);

    newObjective = availableQuests[randomNumber];

    return newObjective;
  }

  QuestObjective({
    String objective,
    QuestTarget target,
  }) {
    this.objective = objective;
    this.target = target;
  }
}
