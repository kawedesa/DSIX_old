import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';

class DiceAnimation extends StatelessWidget {
  const DiceAnimation({this.die, this.lines, this.color});

  final int die;
  final double lines;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 125,
      child: Stack(
        children: <Widget>[
          AnimatedOpacity(
            curve: Curves.easeInOutExpo,
            opacity: this.lines,
            duration: Duration(milliseconds: 300),
            child: FlareActor(
              'assets/animation/dice/line.flr',
              fit: BoxFit.fitHeight,
              animation: 'Lines',
              color: color,
            ),
          ),
          FlareActor(
            'assets/animation/dice/dice.flr',
            fit: BoxFit.fitHeight,
            animation: (this.die == 0) ? 'Roll' : this.die.toString(),
            color: Colors.white,
          ),
        ],
      ),
    );
  }
}
