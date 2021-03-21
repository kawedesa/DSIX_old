import 'dart:math';

class Dice {
  String dice = 'Roll';
  double animationLines = 1;

  Dice newDice() {
    Dice newDice = new Dice(
      this.dice,
      this.animationLines,
    );

    return newDice;
  }

  rollDice() {
    if (this.dice != 'Roll') {
      return;
    }
    this.animationLines = 0;
    this.dice = '${Random().nextInt(5) + 1}';
  }

  Dice(
    this.dice,
    this.animationLines,
  );
}
