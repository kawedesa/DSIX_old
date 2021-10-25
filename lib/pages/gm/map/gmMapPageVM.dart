import 'package:flutter/material.dart';

class GmMapPageVM {
  TransformationController interactiveViewerController;

  List<String> instructions = [
    '1 STEP: Click on the button to create new buildings. Each building has a different xp cost, depending on it\'s size.',
    '2 STEP: Place them anywhere you want, or delete them with a doubletap.',
    '3 STEP: Each building spawns random characters. You can drag than around and place them anywhere you want. You can also change them with a double tap.',
    '4 STEP: Choose the spawning location for the players.',
  ];
}
