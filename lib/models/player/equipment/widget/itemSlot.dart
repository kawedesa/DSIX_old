// import 'package:dsixv02app/models/shop/item.dart';
// import 'package:dsixv02app/shared/app_Colors.dart';
// import 'package:dsixv02app/shared/widgets/uiColor.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_svg/svg.dart';

// // ignore: must_be_immutable
// class ItemSlot extends StatelessWidget {
//   String? playerID;
//   Item? item;
//   String? slotImage;
//   Function()? onTap;
//   Function()? onDoubleTap;

//   ItemSlot(
//       {Key? key,
//       @required this.playerID,
//       @required this.item,
//       @required this.slotImage,
//       @required this.onTap,
//       @required this.onDoubleTap})
//       : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     UIColor _uiColor = UIColor();
//     return GestureDetector(
//       onTap: () => onTap!(),
//       onDoubleTap: () => onDoubleTap!(),
//       child: Container(
//         decoration: BoxDecoration(
//           border: Border.all(
//             color: _uiColor.setUIColor(playerID, 'primary'),
//             width: 1,
//           ),
//         ),
//         child: Padding(
//           padding: const EdgeInsets.all(10.0),
//           child: SvgPicture.asset(
//             (item!.name != '') ? item!.icon! : slotImage!,
//             width: double.infinity,
//             color: (item!.name != '')
//                 ? AppColors.white00
//                 : _uiColor.setUIColor(playerID, 'primary'),
//           ),
//         ),
//       ),
//     );
//   }
// }
