class NewTurnException implements Exception {
  String message = 'new turn';
  NewTurnException();
}

class NotPlayerTurnException implements Exception {
  String message = 'not player turn';
  NotPlayerTurnException();
}

class PlayerTurnException implements Exception {
  String message = 'player turn';
  PlayerTurnException();
}

class EndPlayerTurnException implements Exception {
  String message = 'end player turn';
  EndPlayerTurnException();
}

class ContinuePlayerTurnException implements Exception {
  String message = 'continue player turn';
  ContinuePlayerTurnException();
}

class UpdatePlayerException implements Exception {
  String message = 'update player';
  UpdatePlayerException();
}

class EndGameException implements Exception {
  String message = 'end game';
  EndGameException();
}

class CantPassException implements Exception {
  String message = 'cant pass';
  CantPassException();
}
