import 'questLocation.dart';
import 'questObjective.dart';

class Quest {
  bool questStart;
  String description;
  QuestObjective objective;
  QuestLocation location;

  Quest newQuest() {
    Quest newQuest = new Quest(
      questStart: false,
      objective: newObjective(),
      location: newLocation(),
    );
    return newQuest;
  }

  Quest emptyQuest() {
    Quest newEmptyQuest = Quest(questStart: false);
    return newEmptyQuest;
  }

  QuestLocation newLocation() {
    QuestLocation newLocation = QuestLocation();

    newLocation.newRandomMap();

    return newLocation;
  }

  QuestObjective newObjective() {
    QuestObjective newObjective = QuestObjective();

    newObjective = newObjective.newRandomObjective();

    return newObjective;
  }

  Quest({bool questStart, QuestObjective objective, QuestLocation location}) {
    this.questStart = questStart;
    this.objective = objective;
    this.location = location;
  }
}
