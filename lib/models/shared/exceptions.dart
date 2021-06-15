class NoAmmoException implements Exception {
  String message = 'NO AMMO';

  NoAmmoException();
}

class NoWeaponException implements Exception {
  String message = 'NO WEAPON';

  NoWeaponException();
}

class NoGoldException implements Exception {
  String message = 'IT\'S TOO EXPENSIVE';

  NoGoldException();
}

class TooHeavyException implements Exception {
  String message = 'IT\'S TOO HEAVY';

  TooHeavyException();
}

class MaxHpException implements Exception {
  String message = 'YOUR LIFE IS FULL';

  MaxHpException();
}

class HealException implements Exception {
  String message = '';
  HealException({String message}) {
    this.message = message;
  }
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

class OnGoingQuestException implements Exception {
  String message = 'FINISH A QUEST FIRST ';

  OnGoingQuestException();
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

class EnchantException implements Exception {
  EnchantException();
}

class UseItemException implements Exception {
  String message = '';
  UseItemException({String message}) {
    this.message = message;
  }
}

class RestockException implements Exception {
  String message = 'AMMO RESTOCKED';

  RestockException();
}

class BuyException implements Exception {
  String message = '';
  BuyException({String message}) {
    this.message = message;
  }
}

class SellException implements Exception {
  String message = '';
  SellException({String message}) {
    this.message = message;
  }
}
