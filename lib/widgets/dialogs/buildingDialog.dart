// import 'package:dsixv02app/core/app_colors.dart';
// import 'package:dsixv02app/core/app_images.dart';
// import 'package:dsixv02app/core/app_text_styles.dart';
// import 'package:dsixv02app/models/dsix/sprite.dart';
// import 'package:dsixv02app/models/gm/building/building.dart';
// import 'package:dsixv02app/models/gm/building/buildingSprite.dart';
// import 'package:dsixv02app/models/gm/gm.dart';
// import 'package:dsixv02app/widgets/buttons/dialogButton.dart';
// import 'package:dsixv02app/widgets/dialogs/dialogTitle.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_svg/flutter_svg.dart';

// class BuildingDialog extends StatefulWidget {
//   const BuildingDialog({@required this.gm, this.refresh});

//   final Gm gm;
//   final Function() refresh;

//   @override
//   State<BuildingDialog> createState() => _BuildingDialogState();
// }

// class _BuildingDialogState extends State<BuildingDialog> {
//   Sprite sprite;
//   int index = 0;
//   List<Building> buildings = [];

//   void changeItem(int value) {
//     if (this.index + value < 0) {
//       this.index = this.buildings.length - 1;
//       return;
//     }

//     if (this.index + value > this.buildings.length - 1) {
//       this.index = 0;
//       return;
//     }
//     this.index += value;
//   }

//   void chooseBuilding() {
//     Offset newOffset = Offset(
//         widget.gm.startLocation.dx / 3 +
//             MediaQuery.of(context).size.width * 0.15,
//         widget.gm.startLocation.dy / 3 +
//             MediaQuery.of(context).size.height * 0.125);

//     Building newBuilding = Building(
//         xp: this.buildings[this.index].xp,
//         availableCharacters: this.buildings[this.index].availableCharacters,
//         sprite: BuildingSprite(
//           layers: this.buildings[this.index].sprite.layers,
//           size: this.buildings[this.index].sprite.size,
//           location: newOffset,
//         ));

//     newBuilding.sprite.delete = () async {
//       widget.gm.deleteBuilding(newBuilding);
//       widget.refresh();
//     };

//     widget.gm.buildings.add(newBuilding);
//     widget.gm.currentXp -= newBuilding.xp;
//     widget.gm.buildCanvas();
//   }

//   @override
//   Widget build(BuildContext context) {
//     widget.gm.quest.objective.target.buildings.forEach((element) {
//       if (element.xp <= widget.gm.currentXp) {
//         this.buildings.add(element);
//       }
//     });
//     this.sprite = Sprite(
//       size: MediaQuery.of(context).size.width * 0.4,
//       layers: this.buildings[index].sprite.layers,
//     );
//     return AlertDialog(
//       contentPadding: EdgeInsets.fromLTRB(0, 0, 0, 0),
//       content: Container(
//         color: AppColors.black01,
//         child: Column(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             Container(
//               decoration: BoxDecoration(
//                 border: Border.all(
//                   color: widget.gm.tertiaryColor,
//                   width: 1.5, //                   <--- border width here
//                 ),
//               ),
//               width: MediaQuery.of(context).size.width * 0.8,
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.start,
//                 children: <Widget>[
//                   DialogTitle(
//                     title: 'choose'.toUpperCase(),
//                     color: widget.gm.tertiaryColor,
//                   ),
//                   Padding(
//                     padding: const EdgeInsets.fromLTRB(25, 15, 25, 20),
//                     child: Container(
//                       height: MediaQuery.of(context).size.height * 0.26,
//                       child: Row(
//                         crossAxisAlignment: CrossAxisAlignment.center,
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           GestureDetector(
//                             onTap: () {
//                               setState(() {
//                                 changeItem(-1);
//                               });
//                             },
//                             child: Container(
//                               width: MediaQuery.of(context).size.width * 0.1,
//                               height: MediaQuery.of(context).size.width * 0.1,
//                               child: SvgPicture.asset(
//                                 AppImages.arrowLeft,
//                                 color: widget.gm.tertiaryColor,
//                               ),
//                             ),
//                           ),
//                           // Text(
//                           //   this.widget.player.health.toString(),
//                           //   textAlign: TextAlign.justify,
//                           //   style: AppTextStyles.healthAndGoldDialogStyle,
//                           // ),

//                           Column(
//                             mainAxisAlignment: MainAxisAlignment.center,
//                             children: [
//                               this.sprite,
//                               Padding(
//                                 padding: const EdgeInsets.fromLTRB(0, 15, 0, 0),
//                                 child: Text(
//                                   'xp: ${this.buildings[this.index].xp}'
//                                       .toUpperCase(),
//                                   style: AppTextStyles.buildingDialogStatStyle,
//                                 ),
//                               ),
//                             ],
//                           ),
//                           GestureDetector(
//                             onTap: () {
//                               setState(() {
//                                 changeItem(1);
//                               });
//                             },
//                             child: Container(
//                               width: MediaQuery.of(context).size.width * 0.1,
//                               height: MediaQuery.of(context).size.width * 0.1,
//                               child: SvgPicture.asset(
//                                 AppImages.arrowRight,
//                                 color: widget.gm.tertiaryColor,
//                               ),
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                   DialogButton(
//                     buttonText: 'confirm',
//                     buttonTextColor: AppColors.white01,
//                     onTapAction: () async {
//                       chooseBuilding();
//                       Navigator.of(context).pop();
//                     },
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
