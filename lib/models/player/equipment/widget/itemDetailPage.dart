import 'package:dsixv02app/models/player/equipment/widget/equipmentPage.dart';
import 'package:dsixv02app/models/shop/item.dart';
import 'package:dsixv02app/shared/app_Colors.dart';
import 'package:dsixv02app/shared/widgets/dialogButton.dart';
import 'package:dsixv02app/shared/widgets/uiColor.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'itemStats.dart';

// ignore: must_be_immutable
class ItemDetailPage extends StatelessWidget {
  String? id;
  Item? item;
  ItemDetailPage({Key? key, @required this.id, @required this.item})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    UIColor _uiColor = UIColor();

    return AlertDialog(
      contentPadding: EdgeInsets.fromLTRB(0, 0, 0, 0),
      content: Container(
        width: MediaQuery.of(context).size.width * 0.8,
        decoration: BoxDecoration(
          color: AppColors.black00,
          border: Border.all(
            color: _uiColor.setUIColor(id, 'primary'),
            width: 2,
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            DialogTitle(id: id, tittle: '${item!.name}'),
            Column(
              children: [
                Divider(
                  height: 0,
                  thickness: 2,
                  color: _uiColor.setUIColor(id, 'primary'),
                ),
                ItemStats(id: id, item: item),
                Divider(
                  height: 0,
                  thickness: 2,
                  color: _uiColor.setUIColor(id, 'primary'),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.1,
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.3,
                  width: MediaQuery.of(context).size.height * 0.3,
                  child: SvgPicture.asset(
                    item!.icon!,
                    color: AppColors.white00,
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.1,
                ),
                Divider(
                  height: 0,
                  thickness: 2,
                  color: _uiColor.setUIColor(id, 'primary'),
                ),
                DialogButton(
                  buttonText: 'close',
                  onTapAction: () async {
                    Navigator.pop(context);
                  },
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
