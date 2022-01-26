class PlayerTurnException implements Exception {
  String message = 'player turn';
  PlayerTurnException();
}

class PlayerIsDeadException implements Exception {
  String message = 'player is dead';
  PlayerIsDeadException();
}

class EndGameException implements Exception {
  String message = 'end game';
  EndGameException();
}

class CantPassException implements Exception {
  String message = 'cant pass';
  CantPassException();
}
