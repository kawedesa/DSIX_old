import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:dsixv02app/models/game/dsix.dart';
import 'package:dsixv02app/models/game/item.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SettingsPage extends StatefulWidget {
  final Function(int index) pageChanged;
  final Function() refresh;
  final Dsix dsix;

  SettingsPage({Key key, this.dsix, this.refresh, this.pageChanged})
      : super(key: key);

  static const String routeName = "/npcPage";

  @override
  _SettingsPageState createState() => new _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  int _layoutIndex = 0;
  List<bool> lootSelection;
  int lootAmount;
  List<String> difficultySetting = [
    'VERY EASY',
    'EASY',
    'NORMAL',
    'HARD',
    'VERY HARD',
  ];

  @override
  Widget build(BuildContext context) {
    lootSelection = [];
    widget.dsix.gm.lootList.forEach((element) {
      if (element == widget.dsix.gm.selectedLoot) {
        lootSelection.add(true);
      } else {
        lootSelection.add(false);
      }
    });

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        // Container(
        //   height: MediaQuery.of(context).size.height * 0.1,
        //   width: double.infinity,
        //   child: Padding(
        //     padding: const EdgeInsets.fromLTRB(5, 2.5, 10, 0),
        //     child: GridView.count(
        //       crossAxisCount: widget.dsix.gm.story.storySettingsList.length,
        //       children: List.generate(
        //           widget.dsix.gm.story.storySettingsList.length, (index) {
        //         return Padding(
        //           padding: const EdgeInsets.symmetric(horizontal: 12),
        //           child: GestureDetector(
        //             onTap: () {
        //               setState(() {
        //                 widget.dsix.gm.story.chooseDifficulty(index);
        //               });
        //             },
        //             child: Container(
        //               child: SvgPicture.asset(
        //                 'assets/gm/settings/${widget.dsix.gm.story.storySettingsList[index].icon}.svg',
        //                 color: Colors.grey[700],
        //               ),
        //             ),
        //           ),
        //         );
        //       }),
        //     ),
        //   ),
        // ),
        Divider(
          height: 0,
          thickness: 2,
          color: Colors.grey[700],
        ),
        Expanded(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                flex: 1,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        widget.dsix.gm.story.chooseDifficulty(-1);
                      });
                    },
                    child: Container(
                      height: 100,
                      color: Colors.amber,
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 3,
                child: Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        '${widget.dsix.gm.story.settings.name}',
                        style: TextStyle(
                          fontFamily: 'Headline',
                          height: 1.3,
                          fontSize: 45,
                          color: Colors.grey[700],
                          letterSpacing: 2,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                        child: Text(
                          '${widget.dsix.gm.story.settings.description}',
                          textAlign: TextAlign.justify,
                          style: TextStyle(
                            height: 1.3,
                            fontSize: 18,
                            fontFamily: 'Calibri',
                            color: Colors.white,
                          ),
                        ),
                      ),
                      TextButton(
                        style: TextButton.styleFrom(
                          padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                        ),
                        onPressed: () {
                          widget.dsix.gm.story.newStory();
                          widget.pageChanged(1);
                          widget.refresh();
                        },
                        child: Container(
                          height: MediaQuery.of(context).size.height * 0.058,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.grey[700],
                              width:
                                  2, //                   <--- border width here
                            ),
                          ),
                          child: Stack(
                            alignment: AlignmentDirectional.centerEnd,
                            children: [
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(0, 0, 10, 0),
                                    child: Icon(
                                      Icons.check,
                                      color: Colors.grey[700],
                                      size: 20,
                                    ),
                                  ),
                                ],
                              ),
                              Center(
                                child: Text(
                                  'CONFIRM',
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    letterSpacing: 1.5,
                                    fontFamily: 'Calibri',
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        widget.dsix.gm.story.chooseDifficulty(1);
                      });
                    },
                    child: Container(
                      height: 100,
                      color: Colors.amber,
                    ),
                  ),
                ),
              ),
            ],
          ),
          // child: IndexedStack(
          //   index: _layoutIndex,
          //   children: [
          //     // Row(
          //     //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //     //   children: [
          //     //     Container(
          //     //       width: 65,
          //     //       child: IconButton(
          //     //         icon: Icon(
          //     //           Icons.keyboard_arrow_left,
          //     //           color: Colors.grey[400],
          //     //           size: 30,
          //     //         ),
          //     //         onPressed: () {},
          //     //       ),
          //     //     ),
          //     //     Padding(
          //     //       padding: const EdgeInsets.fromLTRB(65, 15, 65, 0),
          //     //       child: Column(
          //     //         crossAxisAlignment: CrossAxisAlignment.start,
          //     //         children: [
          //     //           Text(
          //     //             '${widget.dsix.gm.story.settings.name}',
          //     //             style: TextStyle(
          //     //               fontFamily: 'Headline',
          //     //               height: 1.3,
          //     //               fontSize: 45,
          //     //               color: Colors.grey[700],
          //     //               letterSpacing: 2,
          //     //             ),
          //     //           ),
          //     //           Padding(
          //     //             padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
          //     //             child: Text(
          //     //               '${widget.dsix.gm.story.settings.description}',
          //     //               textAlign: TextAlign.justify,
          //     //               style: TextStyle(
          //     //                 height: 1.3,
          //     //                 fontSize: 18,
          //     //                 fontFamily: 'Calibri',
          //     //                 color: Colors.white,
          //     //               ),
          //     //             ),
          //     //           ),
          //     //           TextButton(
          //     //             style: TextButton.styleFrom(
          //     //               padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
          //     //             ),
          //     //             onPressed: () {
          //     //               widget.dsix.gm.story.newStory();
          //     //               widget.pageChanged(1);
          //     //               widget.refresh();
          //     //             },
          //     //             child: Container(
          //     //               height: MediaQuery.of(context).size.height * 0.058,
          //     //               width: double.infinity,
          //     //               decoration: BoxDecoration(
          //     //                 border: Border.all(
          //     //                   color: Colors.grey[700],
          //     //                   width:
          //     //                       2, //                   <--- border width here
          //     //                 ),
          //     //               ),
          //     //               child: Stack(
          //     //                 alignment: AlignmentDirectional.centerEnd,
          //     //                 children: [
          //     //                   Column(
          //     //                     mainAxisAlignment: MainAxisAlignment.center,
          //     //                     crossAxisAlignment: CrossAxisAlignment.start,
          //     //                     children: <Widget>[
          //     //                       Padding(
          //     //                         padding: const EdgeInsets.fromLTRB(
          //     //                             0, 0, 10, 0),
          //     //                         child: Icon(
          //     //                           Icons.check,
          //     //                           color: Colors.grey[700],
          //     //                           size: 20,
          //     //                         ),
          //     //                       ),
          //     //                     ],
          //     //                   ),
          //     //                   Center(
          //     //                     child: Text(
          //     //                       'CONFIRM',
          //     //                       style: TextStyle(
          //     //                         fontSize: 14,
          //     //                         fontWeight: FontWeight.bold,
          //     //                         letterSpacing: 1.5,
          //     //                         fontFamily: 'Calibri',
          //     //                         color: Colors.white,
          //     //                       ),
          //     //                     ),
          //     //                   ),
          //     //                 ],
          //     //               ),
          //     //             ),
          //     //           ),
          //     //         ],
          //     //       ),
          //     //     ),
          //     //     Container(
          //     //       width: 65,
          //     //       child: IconButton(
          //     //         icon: Icon(
          //     //           Icons.keyboard_arrow_right,
          //     //           color: Colors.grey[400],
          //     //           size: 30,
          //     //         ),
          //     //         onPressed: () {},
          //     //       ),
          //     //     ),
          //     //   ],
          //     // ),
          //   ],
          // ),
        ),
      ],
    );
  }
}
