// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:dsixv02app/models/dsix/dsix.dart';
// import 'package:dsixv02app/models/shared/exceptions.dart';
// import 'package:flutter_svg/flutter_svg.dart';

// class StoryPage extends StatefulWidget {
//   final Function(String) alert;
//   final Function() refresh;
//   final Dsix dsix;

//   StoryPage({Key key, this.dsix, this.refresh, this.alert}) : super(key: key);

//   static const String routeName = "/npcPage";

//   @override
//   _StoryPageState createState() => new _StoryPageState();
// }

// class _StoryPageState extends State<StoryPage> {
//   int _layoutIndex = 1;
//   List<bool> questSelection;

//   void selectQuest(int index) {
//     widget.dsix.gm.story.selectQuest(index);
//     _layoutIndex = 1;
//   }

//   void quest() {
//     try {
//       if (widget.dsix.gm.story.quest.onGoing) {
//         widget.dsix.gm.finishQuest();
//       } else {
//         widget.dsix.gm.startQuest();
//       }
//     } on NoPlayersException catch (e) {
//       ScaffoldMessenger.of(context).showSnackBar(widget.alert(e.message));
//       return;
//     } on AcceptQuestException catch (e) {
//       ScaffoldMessenger.of(context).showSnackBar(widget.alert(e.message));
//       return;
//     } on FinishQuestException catch (e) {
//       ScaffoldMessenger.of(context).showSnackBar(widget.alert(e.message));

//       widget.refresh();
//       return;
//     }
//   }

//   void deleteQuest() {
//     widget.dsix.gm.story.deleteQuest();

//     _layoutIndex = 0;
//   }

//   @override
//   void initState() {
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     questSelection = [];
//     widget.dsix.gm.story.questList.forEach((element) {
//       if (element == widget.dsix.gm.story.quest) {
//         questSelection.add(true);
//       } else {
//         questSelection.add(false);
//       }
//     });

//     if (widget.dsix.gm.story.questList.isEmpty) {
//       _layoutIndex = 0;
//     } else {
//       _layoutIndex = 1;
//     }

//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.stretch,
//       children: <Widget>[
//         Container(
//           height: MediaQuery.of(context).size.height * 0.1,
//           child: Row(
//             children: [
//               Padding(
//                 padding: const EdgeInsets.fromLTRB(18, 0, 0, 0),
//                 child: GestureDetector(
//                   onTap: () {
//                     setState(() {
//                       widget.dsix.gm.story.newRandomQuest();
//                       _layoutIndex = 1;

//                       widget.refresh();
//                     });
//                   },
//                   child: Container(
//                     width: 23,
//                     height: 23,
//                     child: SvgPicture.asset(
//                       'assets/gm/add.svg',
//                       color: Colors.grey[400],
//                     ),
//                   ),
//                 ),
//               ),
//               Expanded(
//                 child: Padding(
//                   padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
//                   child: ListView.separated(
//                     shrinkWrap: true,
//                     physics: ScrollPhysics(),
//                     scrollDirection: Axis.horizontal,
//                     padding: const EdgeInsets.fromLTRB(13, 0, 0, 0),
//                     itemCount: widget.dsix.gm.story.questList.length,
//                     itemBuilder: (BuildContext context, int index) {
//                       return GestureDetector(
//                         onTap: () {
//                           setState(() {
//                             selectQuest(index);
//                           });
//                         },
//                         child: Container(
//                           height: 35,
//                           width: 35,
//                           child: SvgPicture.asset(
//                             'assets/gm/story/quest/${widget.dsix.gm.story.questList[index].icon}.svg',
//                             color: questSelection[index]
//                                 ? Colors.grey[400]
//                                 : Colors.grey[700],
//                           ),
//                         ),
//                       );
//                     },
//                     separatorBuilder: (BuildContext context, int index) {
//                       return SizedBox(
//                         width: 5,
//                       );
//                     },
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//         Divider(
//           height: 0,
//           thickness: 2,
//           color: Colors.grey[700],
//         ),
//         Expanded(
//           child: IndexedStack(
//             index: _layoutIndex,
//             children: [
//               Padding(
//                 padding: const EdgeInsets.fromLTRB(65, 15, 65, 0),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(
//                       'QUEST',
//                       style: TextStyle(
//                         fontFamily: 'Headline',
//                         height: 1.3,
//                         fontSize: 45,
//                         color: Colors.grey[700],
//                         letterSpacing: 2,
//                       ),
//                     ),
//                     Padding(
//                       padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
//                       child: Text(
//                         'Every game starts with a story. It could be the tale of a fallen prince, or the rise of a evil necromancer. Its hard to come up with something on the fly, so this page is dedicated to help you with that task. Here you can create quests, scenes, or settings with a few steps.',
//                         textAlign: TextAlign.justify,
//                         style: TextStyle(
//                           height: 1.3,
//                           fontSize: 18,
//                           fontFamily: 'Calibri',
//                           color: Colors.white,
//                         ),
//                       ),
//                     ),
//                     GestureDetector(
//                       onTap: () {
//                         setState(() {
//                           widget.dsix.gm.story.newRandomQuest();
//                           _layoutIndex = 1;

//                           widget.refresh();
//                         });
//                       },
//                       child: Container(
//                         height: MediaQuery.of(context).size.height * 0.058,
//                         width: double.infinity,
//                         decoration: BoxDecoration(
//                           border: Border.all(
//                             color: Colors.grey[700],
//                             width:
//                                 2, //                   <--- border width here
//                           ),
//                         ),
//                         child: Stack(
//                           alignment: AlignmentDirectional.centerEnd,
//                           children: [
//                             Column(
//                               mainAxisAlignment: MainAxisAlignment.center,
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: <Widget>[
//                                 Padding(
//                                   padding:
//                                       const EdgeInsets.fromLTRB(0, 0, 10, 0),
//                                   child: Icon(
//                                     Icons.check,
//                                     color: Colors.grey[700],
//                                     size: 20,
//                                   ),
//                                 ),
//                               ],
//                             ),
//                             Center(
//                               child: Text(
//                                 'NEW QUEST',
//                                 style: TextStyle(
//                                   fontSize: 14,
//                                   fontWeight: FontWeight.bold,
//                                   letterSpacing: 1.5,
//                                   fontFamily: 'Calibri',
//                                   color: Colors.white,
//                                 ),
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//               Container(
//                 height: MediaQuery.of(context).size.height * 0.678,
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Row(
//                       children: [
//                         Container(
//                           width: MediaQuery.of(context).size.width * 0.2,
//                         ),
//                         Container(
//                           width: MediaQuery.of(context).size.width * 0.6,
//                           child: Padding(
//                             padding: const EdgeInsets.fromLTRB(0, 15, 0, 0),
//                             child: Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 Row(
//                                   crossAxisAlignment: CrossAxisAlignment.start,
//                                   mainAxisAlignment:
//                                       MainAxisAlignment.spaceBetween,
//                                   children: [
//                                     Text(
//                                       '${widget.dsix.gm.story.quest.name}',
//                                       style: TextStyle(
//                                         fontFamily: 'Headline',
//                                         height: 1.3,
//                                         fontSize: 45,
//                                         color: Colors.grey[700],
//                                         letterSpacing: 2,
//                                       ),
//                                     ),
//                                     Padding(
//                                       padding: const EdgeInsets.fromLTRB(
//                                           0, 10, 0, 0),
//                                       child: GestureDetector(
//                                         onTap: () {
//                                           setState(() {
//                                             deleteQuest();
//                                           });
//                                         },
//                                         child: Icon(
//                                           Icons.clear,
//                                           color: Colors.red,
//                                           size: 40,
//                                         ),
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                                 Padding(
//                                   padding:
//                                       const EdgeInsets.fromLTRB(0, 10, 0, 10),
//                                   child: Text(
//                                     '${widget.dsix.gm.story.quest.questDescription}',
//                                     textAlign: TextAlign.justify,
//                                     style: TextStyle(
//                                       height: 1.3,
//                                       fontSize: 18,
//                                       fontFamily: 'Calibri',
//                                       color: Colors.white,
//                                     ),
//                                   ),
//                                 ),
//                                 GestureDetector(
//                                   onTap: () {
//                                     setState(() {
//                                       quest();
//                                     });
//                                     widget.refresh();
//                                   },
//                                   child: Container(
//                                     height: MediaQuery.of(context).size.height *
//                                         0.058,
//                                     width: double.infinity,
//                                     decoration: BoxDecoration(
//                                       border: Border.all(
//                                         color:
//                                             (widget.dsix.gm.story.quest.onGoing)
//                                                 ? Colors.green
//                                                 : Colors.grey[700],
//                                         width:
//                                             2, //                   <--- border width here
//                                       ),
//                                     ),
//                                     child: Stack(
//                                       alignment: AlignmentDirectional.centerEnd,
//                                       children: [
//                                         Column(
//                                           mainAxisAlignment:
//                                               MainAxisAlignment.center,
//                                           crossAxisAlignment:
//                                               CrossAxisAlignment.start,
//                                           children: <Widget>[
//                                             Padding(
//                                               padding:
//                                                   const EdgeInsets.fromLTRB(
//                                                       0, 0, 10, 0),
//                                               child: Icon(
//                                                 Icons.check,
//                                                 color: (widget.dsix.gm.story
//                                                         .quest.onGoing)
//                                                     ? Colors.green
//                                                     : Colors.grey[700],
//                                                 size: 20,
//                                               ),
//                                             ),
//                                           ],
//                                         ),
//                                         Center(
//                                           child: (widget
//                                                   .dsix.gm.story.quest.onGoing)
//                                               ? Text(
//                                                   'FINISH',
//                                                   style: TextStyle(
//                                                     fontSize: 14,
//                                                     fontWeight: FontWeight.bold,
//                                                     letterSpacing: 1.5,
//                                                     fontFamily: 'Calibri',
//                                                     color: Colors.white,
//                                                   ),
//                                                 )
//                                               : Text(
//                                                   '${widget.dsix.gm.story.quest.reward}',
//                                                   style: TextStyle(
//                                                     fontSize: 14,
//                                                     fontWeight: FontWeight.bold,
//                                                     letterSpacing: 1.5,
//                                                     fontFamily: 'Calibri',
//                                                     color: Colors.white,
//                                                   ),
//                                                 ),
//                                         ),
//                                       ],
//                                     ),
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ),
//                         Container(
//                           width: MediaQuery.of(context).size.width * 0.2,
//                         ),
//                       ],
//                     ),
//                     ListView(
//                       shrinkWrap: true,
//                       physics: AlwaysScrollableScrollPhysics(),
//                       scrollDirection: Axis.vertical,
//                       children: [
//                         Divider(
//                           height: 2,
//                           thickness: 2,
//                           color: Colors.grey[700],
//                         ),
//                         Padding(
//                           padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
//                           child: ListTile(
//                             onTap: () {
//                               setState(() {
//                                 widget.dsix.gm.story.quest
//                                     .chooseQuest('character');
//                                 widget.refresh();
//                               });
//                             },
//                             title: Text(
//                               'Character:',
//                               style: TextStyle(
//                                 fontFamily: 'Headliner',
//                                 height: 1.5,
//                                 fontSize: 20.0,
//                                 color: Colors.grey[300],
//                                 letterSpacing: 2.5,
//                               ),
//                             ),
//                             trailing: Text(
//                               widget.dsix.gm.story.quest.character,
//                               style: TextStyle(
//                                 height: 1.5,
//                                 fontSize: 18,
//                                 fontFamily: 'Calibri',
//                                 color: Colors.white,
//                               ),
//                             ),
//                           ),
//                         ),
//                         Divider(
//                           height: 0,
//                           thickness: 2,
//                           color: Colors.grey[700],
//                         ),
//                         Padding(
//                           padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
//                           child: ListTile(
//                             onTap: () {
//                               setState(() {
//                                 // widget.dsix.gm.selectedQuest
//                                 //     .chooseQuest('objective');
//                                 // widget.refresh();
//                               });
//                             },
//                             title: Text(
//                               'Objective:',
//                               style: TextStyle(
//                                 fontFamily: 'Headliner',
//                                 height: 1.5,
//                                 fontSize: 20.0,
//                                 color: Colors.grey[300],
//                                 letterSpacing: 2.5,
//                               ),
//                             ),
//                             trailing: Text(
//                               widget.dsix.gm.story.quest.objective,
//                               style: TextStyle(
//                                 height: 1.5,
//                                 fontSize: 18,
//                                 fontFamily: 'Calibri',
//                                 color: Colors.white,
//                               ),
//                             ),
//                           ),
//                         ),
//                         Divider(
//                           height: 0,
//                           thickness: 2,
//                           color: Colors.grey[700],
//                         ),
//                         Padding(
//                           padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
//                           child: ListTile(
//                             onTap: () {
//                               setState(() {
//                                 // widget.dsix.gm.story.quest
//                                 //     .chooseQuest('target');
//                                 // widget.refresh();
//                               });
//                             },
//                             title: Text(
//                               'Target:',
//                               style: TextStyle(
//                                 fontFamily: 'Headliner',
//                                 height: 1.5,
//                                 fontSize: 20.0,
//                                 color: Colors.grey[300],
//                                 letterSpacing: 2.5,
//                               ),
//                             ),
//                             trailing: Text(
//                               widget.dsix.gm.story.quest.target,
//                               style: TextStyle(
//                                 height: 1.5,
//                                 fontSize: 18,
//                                 fontFamily: 'Calibri',
//                                 color: Colors.white,
//                               ),
//                             ),
//                           ),
//                         ),
//                         Divider(
//                           height: 0,
//                           thickness: 2,
//                           color: Colors.grey[700],
//                         ),
//                         Padding(
//                           padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
//                           child: ListTile(
//                             onTap: () {
//                               setState(() {
//                                 // widget.dsix.gm.story.quest
//                                 //     .chooseQuest('location');
//                                 // widget.refresh();
//                               });
//                             },
//                             title: Text(
//                               'Location:',
//                               style: TextStyle(
//                                 fontFamily: 'Headliner',
//                                 height: 1.5,
//                                 fontSize: 20.0,
//                                 color: Colors.grey[300],
//                                 letterSpacing: 2.5,
//                               ),
//                             ),
//                             trailing: Text(
//                               widget.dsix.gm.story.quest.location,
//                               style: TextStyle(
//                                 height: 1.5,
//                                 fontSize: 18,
//                                 fontFamily: 'Calibri',
//                                 color: Colors.white,
//                               ),
//                             ),
//                           ),
//                         ),
//                         // Divider(
//                         //   height: 0,
//                         //   thickness: 2,
//                         //   color: Colors.grey[700],
//                         // ),
//                         // Padding(
//                         //   padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
//                         //   child: ListTile(
//                         //     onTap: () {
//                         //       setState(() {
//                         //         widget.dsix.gm.story.quest
//                         //             .chooseQuest('reward');
//                         //         widget.refresh();
//                         //       });
//                         //     },
//                         //     title: Text(
//                         //       'Reward:',
//                         //       style: TextStyle(
//                         //         fontFamily: 'Headliner',
//                         //         height: 1.5,
//                         //         fontSize: 20.0,
//                         //         color: Colors.grey[300],
//                         //         letterSpacing: 2.5,
//                         //       ),
//                         //     ),
//                         //     trailing: Text(
//                         //       widget.dsix.gm.story.quest.reward,
//                         //       style: TextStyle(
//                         //         height: 1.5,
//                         //         fontSize: 18,
//                         //         fontFamily: 'Calibri',
//                         //         color: Colors.white,
//                         //       ),
//                         //     ),
//                         //   ),
//                         // ),
//                       ],
//                     ),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ],
//     );
//   }
// }