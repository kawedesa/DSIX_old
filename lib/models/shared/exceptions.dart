class NoAmmoException implements Exception {
  String message = 'You have no ammunition.';
  String title = 'NO AMMO';

  NoAmmoException();
}

class NoWeaponException implements Exception {
  String message = 'Buy a weapon.';
  String title = 'NO WEAPON';

  NoWeaponException();
}

class NoGoldException implements Exception {
  String message = 'You can\'t afford it.';
  String title = 'NO GOLD';

  NoGoldException();
}

class TooHeavyException implements Exception {
  String message = 'Too heavy.';
  String title = 'TOO HEAVY';

  TooHeavyException();
}

class MaxHpException implements Exception {
  String message = 'You are already at max HP.';
  String title = 'MAX HP';

  MaxHpException();
}

class MaxAmmoException implements Exception {
  String message = 'You are already loaded.';
  String title = 'MAX AMMO';

  MaxAmmoException();
}

class NoPlayersException implements Exception {
  String message = 'There are no players.';
  String title = 'NO PLAYERS';

  NoPlayersException();
}
