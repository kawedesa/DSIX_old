import 'package:dsixv02app/core/app_colors.dart';
import 'package:dsixv02app/core/app_images.dart';
import 'package:dsixv02app/pages/gm/gmUI/gmUIVM.dart';
import 'package:dsixv02app/pages/gm/story/storyStats.dart';
import 'package:dsixv02app/widgets/buttons/button.dart';
import 'package:dsixv02app/widgets/description.dart';
import 'package:dsixv02app/widgets/dialogs/buildingDialog.dart';
import 'package:dsixv02app/widgets/dialogs/confirmDialog.dart';
import 'package:dsixv02app/widgets/dialogs/questDialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:dsixv02app/models/dsix/dsix.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'gameModePageVM.dart';

class GameModePage extends StatefulWidget {
  final Function() refresh;
  final Dsix dsix;
  final GmUIVM controller;

  GameModePage({
    Key key,
    this.dsix,
    this.refresh,
    this.controller,
  }) : super(key: key);

  static const String routeName = "/gameModePage";

  @override
  _GameModePageState createState() => new _GameModePageState();
}

class _GameModePageState extends State<GameModePage> {
  GameModePageVM _gameModePageVM = GameModePageVM();

  @override
  Widget build(BuildContext context) {
    // if (widget.dsix.gm.round == 0) {
    //   _storyPageVM.layout = 0;
    // } else {
    //   if (widget.dsix.gm.quest.objective == null) {
    //     _storyPageVM.layout = 2;
    //   } else {
    //     _storyPageVM.layout = 1;
    //   }
    // }

    return IndexedStack(
      index: 0,
      children: [
        Container(
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 10, 0, 5),
                child: Button(
                    buttonText: 'battle royale',
                    onTapAction: () async {
                      _gameModePageVM.newBattleRoyaleGame(widget.dsix);
                      widget.controller.changePage(1);
                    }),
              ),
              Button(buttonText: 'quick game'),
              Container(
                height: MediaQuery.of(context).size.height * 0.05,
                width: 50,
              ),
            ],
          ),
        ),
      ],
    );
  }
}

  // child: Button(
  //                 buttonText: 'new game',
  //                 onTapAction: () async {
  //                   _storyPageVM.newGame(widget.dsix);
  //                   showDialog(
  //                     context: context,
  //                     builder: (BuildContext context) {
  //                       return QuestDialog(
  //                         availableQuests: _storyPageVM.availableQuests,
  //                         gm: widget.dsix.gm,
  //                       );
  //                     },
  //                   ).then((_) => setState(() {
  //                         widget.refresh();
  //                       }));
  //                 },
  //               ),