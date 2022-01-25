import 'package:dsixv02app/models/game/game.dart';
import 'package:dsixv02app/shared/app_Exceptions.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../player.dart';
import 'actionButton.dart';
import 'iventoryButton.dart';

class PlayerMenu extends StatelessWidget {
  final Function()? refresh;
  final Player? player;
  PlayerMenu({Key? key, this.refresh, @required this.player}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final game = Provider.of<Game>(context);

    return Positioned(
      left: player!.location!.dx! - MediaQuery.of(context).size.height * 0.04,
      top: player!.location!.dy! - MediaQuery.of(context).size.height * 0.045,
      child: SizedBox(
        width: MediaQuery.of(context).size.height * 0.08,
        height: MediaQuery.of(context).size.height * 0.08,
        child: Center(
          child: AnimatedContainer(
            curve: Curves.fastLinearToSlowEaseIn,
            duration: Duration(milliseconds: 400),
            height: (player!.mode == 'menu')
                ? MediaQuery.of(context).size.height * 0.08
                : 0.0,
            width: (player!.mode == 'menu')
                ? MediaQuery.of(context).size.height * 0.08
                : 0.0,
            child: Stack(
              children: [
                Align(
                  alignment: Alignment.topCenter,
                  child: ActionButton(
                    player: player,
                    action: 'attack',
                    onTap: () {
                      player!.attackMode();
                      player!.updateMode();
                      refresh!();
                    },
                  ),
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: ActionButton(
                    player: player,
                    action: 'defend',
                    onTap: () {
                      player!.defend();
                      player!.menuMode();

                      try {
                        player!.action!.takeAction(
                          game.id!,
                          player!.id!,
                        );
                      } on EndPlayerTurnException {
                        game.round!.passTurn(game.id!, player!);
                      }
                    },
                  ),
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: ActionButton(
                    player: player,
                    action: 'look',
                    onTap: () {
                      player!.look();
                      player!.menuMode();

                      try {
                        player!.action!.takeAction(
                          game.id!,
                          player!.id!,
                        );
                      } on EndPlayerTurnException {
                        game.round!.passTurn(game.id!, player!);
                      }
                    },
                  ),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: IventoryButton(
                    player: player,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
