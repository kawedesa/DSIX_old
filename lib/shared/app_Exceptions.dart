class PlayerTurnException implements Exception {
  String message = 'player turn';
  PlayerTurnException();
}

class EndGameException implements Exception {
  String message = 'end game';
  EndGameException();
}

class CantPassException implements Exception {
  String message = 'cant pass';
  CantPassException();
}
