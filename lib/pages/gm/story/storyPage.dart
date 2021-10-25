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

import 'storyPageVM.dart';

class StoryPage extends StatefulWidget {
  final Function() refresh;
  final Dsix dsix;
  final GmUIVM controller;

  StoryPage({
    Key key,
    this.dsix,
    this.refresh,
    this.controller,
  }) : super(key: key);

  static const String routeName = "/storyPage";

  @override
  _StoryPageState createState() => new _StoryPageState();
}

class _StoryPageState extends State<StoryPage> {
  StoryPageVM _storyPageVM = StoryPageVM();

  @override
  Widget build(BuildContext context) {
    if (widget.dsix.gm.round == 0) {
      _storyPageVM.layout = 0;
    } else {
      if (widget.dsix.gm.quest.objective == null) {
        _storyPageVM.layout = 2;
      } else {
        _storyPageVM.layout = 1;
      }
    }

    return IndexedStack(
      index: _storyPageVM.layout,
      children: [
        Container(
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: MediaQuery.of(context).size.width * 0.65,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(0, 0, 0, 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                        child: GestureDetector(
                          onTap: () {
                            // setState(() {
                            //   widget.dsix.gm.story.chooseDifficulty(-1);
                            // });
                          },
                          child: SvgPicture.asset(
                            AppImages.arrowLeft,
                            color: widget.dsix.gm.tertiaryColor,
                            width: MediaQuery.of(context).size.width * 0.08,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                        child: Text(
                          _storyPageVM.storySettings.name.toUpperCase(),
                          style: TextStyle(
                            fontFamily: 'Headline',
                            height: 1.1,
                            fontSize: 45,
                            color: widget.dsix.gm.tertiaryColor,
                            letterSpacing: 2,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                        child: GestureDetector(
                          // onTap: () {
                          //   setState(() {

                          //   });
                          // },
                          child: SvgPicture.asset(
                            AppImages.arrowRight,
                            color: widget.dsix.gm.tertiaryColor,
                            width: MediaQuery.of(context).size.width * 0.08,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                child: Description(
                  description: _storyPageVM.storySettings.description,
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 10, 0, 5),
                child: Button(
                  buttonText: 'new game',
                  onTapAction: () async {
                    _storyPageVM.newGame(widget.dsix);
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return QuestDialog(
                          availableQuests: _storyPageVM.availableQuests,
                          gm: widget.dsix.gm,
                        );
                      },
                    ).then((_) => setState(() {
                          widget.refresh();
                        }));
                  },
                ),
              ),
              Button(buttonText: 'load'),
              Container(
                height: MediaQuery.of(context).size.height * 0.05,
                width: 50,
              ),
            ],
          ),
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Stack(
              alignment: Alignment.topCenter,
              children: [
                Column(
                  children: [
                    StoryStats(
                        color: widget.dsix.gm.tertiaryColor,
                        round: widget.dsix.gm.round,
                        xp: widget.dsix.gm.roundXp,
                        gold: widget.dsix.gm.roundGold),
                    Divider(
                      height: 0,
                      thickness: 2,
                      color: widget.dsix.gm.tertiaryColor,
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.65,
                      height: MediaQuery.of(context).size.height * 0.45,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
                            child: Description(
                              description:
                                  'qu est desc ription quest de scription qu est descr iption. que s escription quest descript ion uest desc rip ti onq ue st des crip tion quest description',
                            ),
                          ),
                          (widget.dsix.gm.quest.questStart)
                              ? Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(0, 0, 0, 5),
                                  child: Button(
                                    buttonText: 'finish',
                                    buttonTextColor: AppColors.white01,
                                    buttonIcon: 'confirm',
                                    buttonColor: AppColors.success,
                                    onTapAction: () async {
                                      showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return ConfirmDialog(
                                            title: 'finish quest?',
                                            confirm: () {
                                              _storyPageVM
                                                  .finishQuest(widget.dsix);
                                            },
                                            color: widget.dsix.gm.tertiaryColor,
                                          );
                                        },
                                      ).then((_) => setState(() {
                                            widget.refresh();
                                          }));
                                    },
                                  ),
                                )
                              : Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(0, 0, 0, 5),
                                  child: Button(
                                    buttonText: 'start',
                                    buttonTextColor: AppColors.white01,
                                    buttonIcon: 'confirm',
                                    onTapAction: () async {
                                      setState(() {
                                        _storyPageVM.startQuest(widget.dsix);
                                        widget.controller.changePage(1);
                                      });
                                    },
                                  ),
                                ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(0, 0, 0, 5),
                            child: Button(
                              buttonText: 'cancel',
                              buttonTextColor: AppColors.white01,
                              buttonIcon: 'cancel',
                              onTapAction: () async {
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return ConfirmDialog(
                                      title: 'cancel quest?',
                                      confirm: () {
                                        _storyPageVM
                                            .cancelQuest(widget.dsix.gm);
                                      },
                                      color: widget.dsix.gm.tertiaryColor,
                                    );
                                  },
                                ).then((_) => setState(() {
                                      widget.refresh();
                                    }));
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
            (widget.dsix.gm.quest.objective == null)
                ? Container()
                : Container(
                    height: MediaQuery.of(context).size.height * 0.081 * 3,
                    child: ListView(
                      shrinkWrap: true,
                      physics: AlwaysScrollableScrollPhysics(),
                      scrollDirection: Axis.vertical,
                      children: [
                        Divider(
                          height: 2,
                          thickness: 2,
                          color: widget.dsix.gm.tertiaryColor,
                        ),
                        Container(
                          height: MediaQuery.of(context).size.height * 0.08,
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                            child: ListTile(
                              onTap: () {
                                setState(() {
                                  // widget.dsix.gm.selectedQuest
                                  //     .chooseQuest('objective');
                                  // widget.refresh();
                                });
                              },
                              title: Text(
                                'OBJECTIVE:',
                                style: TextStyle(
                                  fontFamily: 'Calibri',
                                  height: 1,
                                  fontSize: 18,
                                  color: Colors.grey[600],
                                  letterSpacing: 1.5,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              trailing: Text(
                                widget.dsix.gm.quest.objective.objective
                                    .toUpperCase(),
                                style: TextStyle(
                                  height: 1.5,
                                  fontSize: 18,
                                  fontFamily: 'Calibri',
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ),
                        Divider(
                          height: 0,
                          thickness: 2,
                          color: widget.dsix.gm.tertiaryColor,
                        ),
                        Container(
                          height: MediaQuery.of(context).size.height * 0.08,
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                            child: ListTile(
                              onTap: () {
                                setState(() {
                                  // widget.dsix.gm.story.quest
                                  //     .chooseQuest('target');
                                  // widget.refresh();
                                });
                              },
                              title: Text(
                                'TARGET:',
                                style: TextStyle(
                                  fontFamily: 'Calibri',
                                  height: 1,
                                  fontSize: 18,
                                  color: Colors.grey[600],
                                  letterSpacing: 1.5,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              trailing: Text(
                                widget.dsix.gm.quest.objective.target.target
                                    .toUpperCase(),
                                style: TextStyle(
                                  height: 1.5,
                                  fontSize: 18,
                                  fontFamily: 'Calibri',
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ),
                        Divider(
                          height: 0,
                          thickness: 2,
                          color: widget.dsix.gm.tertiaryColor,
                        ),
                        Container(
                          height: MediaQuery.of(context).size.height * 0.08,
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                            child: ListTile(
                              onTap: () {
                                setState(() {
                                  // widget.dsix.gm.story.quest
                                  //     .chooseQuest('location');
                                  // widget.refresh();
                                });
                              },
                              title: Text(
                                'LOCATION:',
                                style: TextStyle(
                                  fontFamily: 'Calibri',
                                  height: 1,
                                  fontSize: 18,
                                  color: Colors.grey[600],
                                  letterSpacing: 1.5,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              trailing: Text(
                                widget.dsix.gm.quest.location.location
                                    .toUpperCase(),
                                style: TextStyle(
                                  height: 1.5,
                                  fontSize: 18,
                                  fontFamily: 'Calibri',
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
          ],
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Stack(
              alignment: Alignment.topCenter,
              children: [
                Column(
                  children: [
                    StoryStats(
                        color: widget.dsix.gm.tertiaryColor,
                        round: widget.dsix.gm.round,
                        xp: widget.dsix.gm.roundXp,
                        gold: widget.dsix.gm.roundGold),
                    Divider(
                      height: 0,
                      thickness: 2,
                      color: widget.dsix.gm.tertiaryColor,
                    ),
                    Container(
                      width: double.infinity,
                      height: MediaQuery.of(context).size.height * 0.6,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.fromLTRB(0, 10, 0, 5),
                            child: Button(
                              buttonText: 'new round',
                              onTapAction: () async {
                                _storyPageVM.newRound(widget.dsix);
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return QuestDialog(
                                      availableQuests:
                                          _storyPageVM.availableQuests,
                                      gm: widget.dsix.gm,
                                    );
                                  },
                                ).then((_) => setState(() {}));
                              },
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(0, 0, 0, 5),
                            child: Button(buttonText: 'save'),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(0, 0, 0, 5),
                            child: Button(
                              buttonText: 'delete',
                              onTapAction: () async {},
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}
