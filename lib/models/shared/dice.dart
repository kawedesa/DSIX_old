import 'dart:math';

class Dice {
  String dice = 'Roll';
  double animationLines = 1;

  Dice newDie() {
    Dice newDie = new Dice(
      this.dice,
      this.animationLines,
    );

    return newDie;
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
