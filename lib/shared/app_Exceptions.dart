class NewTurnException implements Exception {
  String message = 'new turn';
  NewTurnException();
}

class NotPlayerTurnException implements Exception {
  String message = 'not player turn';
  NotPlayerTurnException();
}

class StartPlayerTurnException implements Exception {
  String message = 'start player turn';
  StartPlayerTurnException();
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
