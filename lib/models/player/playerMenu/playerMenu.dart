import 'package:dsixv02app/models/game/gameController.dart';
import 'package:dsixv02app/models/player/user.dart';
import 'package:dsixv02app/models/turn/turnController.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'actionButton.dart';
import 'iventoryButton.dart';

class PlayerMenu extends StatelessWidget {
  final Function()? refresh;
  PlayerMenu({Key? key, this.refresh}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    final turnController = Provider.of<TurnController>(context);
    final gameController = Provider.of<GameController>(context);

    return Positioned(
      left: user.selectedPlayer!.location!.dx! -
          MediaQuery.of(context).size.height * 0.04,
      top: user.selectedPlayer!.location!.dy! -
          MediaQuery.of(context).size.height * 0.045,
      child: SizedBox(
        width: MediaQuery.of(context).size.height * 0.08,
        height: MediaQuery.of(context).size.height * 0.08,
        child: Center(
          child: AnimatedContainer(
            curve: Curves.fastLinearToSlowEaseIn,
            duration: Duration(milliseconds: 400),
            height: (user.menuIsOpen)
                ? MediaQuery.of(context).size.height * 0.08
                : 0.0,
            width: (user.menuIsOpen)
                ? MediaQuery.of(context).size.height * 0.08
                : 0.0,
            child: Stack(
              children: [
                Align(
                  alignment: Alignment.topCenter,
                  child: ActionButton(
                    action: 'attack',
                    onTap: () {
                      user.attackMode();
                      refresh!();
                    },
                  ),
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: ActionButton(
                    action: 'defend',
                    onTap: () {
                      user.defend(
                        gameController.gameID,
                      );
                      user.openCloseMenu();

                      user.takeAction(
                        gameController.gameID,
                      );
                      if (user.selectedPlayer!.action!.outOfActions()) {
                        turnController.passTurnWhere(
                            gameController.gameID, user.selectedPlayer!.id!);
                      }
                    },
                  ),
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: ActionButton(
                    action: 'look',
                    onTap: () {
                      user.look(
                        gameController.gameID,
                      );

                      user.openCloseMenu();

                      user.takeAction(
                        gameController.gameID,
                      );
                      if (user.selectedPlayer!.action!.outOfActions()) {
                        turnController.passTurnWhere(
                            gameController.gameID, user.selectedPlayer!.id!);
                      }
                      // refresh!();
                    },
                  ),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: IventoryButton(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
