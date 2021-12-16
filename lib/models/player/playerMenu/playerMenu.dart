import 'package:dsixv02app/models/player/user.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'actionButton.dart';
import 'iventoryButton.dart';

class PlayerMenu extends StatelessWidget {
  final Function() refresh;
  PlayerMenu({Key key, this.refresh}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);

    return Positioned(
      left: user.selectedPlayer.dx - MediaQuery.of(context).size.height * 0.05,
      top: user.selectedPlayer.dy - MediaQuery.of(context).size.height * 0.05,
      child: SizedBox(
        width: MediaQuery.of(context).size.height * 0.1,
        height: MediaQuery.of(context).size.height * 0.1,
        child: Center(
          child: AnimatedContainer(
            curve: Curves.fastLinearToSlowEaseIn,
            duration: Duration(milliseconds: 400),
            height: (user.playerMode == 'menu')
                ? MediaQuery.of(context).size.height * 0.1
                : 0.0,
            width: (user.playerMode == 'menu')
                ? MediaQuery.of(context).size.height * 0.1
                : 0.0,
            child: Stack(
              children: [
                Align(
                  alignment: Alignment.topCenter,
                  child: ActionButton(
                    action: 'attack',
                    playerMode: user.playerMode,
                    onTap: () {
                      user.attackMode();
                      refresh();
                    },
                  ),
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: ActionButton(
                    action: 'defend',
                    playerMode: user.playerMode,
                    onTap: () {
                      refresh();
                    },
                  ),
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: ActionButton(
                    action: 'look',
                    playerMode: user.playerMode,
                    onTap: () {
                      refresh();
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
