class NoAmmoException implements Exception {
  String message;
  String title = 'No Ammo';

  NoAmmoException(this.message);
}

class NoWeaponException implements Exception {
  String message = 'Buy a weapon!';
  String title = 'No Weapon';

  NoWeaponException();
}
