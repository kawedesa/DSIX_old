class NoAmmoException implements Exception {
  String message = 'NO AMMO';

  NoAmmoException();
}

class NoWeaponException implements Exception {
  String message = 'NO WEAPON';

  NoWeaponException();
}

class NoGoldException implements Exception {
  String message = 'TOO EXPENSIVE';

  NoGoldException();
}

class TooHeavyException implements Exception {
  String message = 'TOO HEAVY';

  TooHeavyException();
}

class MaxHpException implements Exception {
  String message = 'LIFE IS FULL';

  MaxHpException();
}

class MaxAmmoException implements Exception {
  String message = 'FULLY LOADED';

  MaxAmmoException();
}

class NoPlayersException implements Exception {
  String message = 'NO PLAYERS';

  NoPlayersException();
}

class NewRoundException implements Exception {
  String message = 'NEW ROUND';

  NewRoundException();
}

class NewStoryException implements Exception {
  String message = 'NEW STORY';

  NewStoryException();
}

class AcceptQuestException implements Exception {
  String message = 'QUEST ACCEPTED';

  AcceptQuestException();
}

class FinishQuestException implements Exception {
  String message = 'QUEST FINISHED';

  FinishQuestException();
}

class NewTurnException implements Exception {
  String message = 'NEW TURN';

  NewTurnException();
}

class NoAvailableItemsException implements Exception {
  String message = 'NO AVAILABLE ITEMS';

  NoAvailableItemsException();
}
