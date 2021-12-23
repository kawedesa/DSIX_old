import 'package:dsixv02app/models/player/user.dart';
import 'package:dsixv02app/models/turn.dart';
import 'package:dsixv02app/models/turnOrder/turnController.dart';
import 'package:dsixv02app/shared/app_Exceptions.dart';
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
    // final turnController = Provider.of<TurnController>(context);
    // final turnOrder = Provider.of<List<Turn>>(context);

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
                    onTap: () {},
                    //     onTap: () {
                    //       user.selectedPlayer.defend();
                    //       try {
                    //         turnController.takeTurn(turnOrder);
                    //       } on PlayerTurnException {
                    //         user.walkMode();
                    //       } on NotPlayerTurnException {
                    //         user.endPlayerTurn();
                    //       }
                    //     },
                  ),
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: ActionButton(
                    action: 'look',
                    onTap: () {},
                    // onTap: () {
                    //   refresh!();
                    // },
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
