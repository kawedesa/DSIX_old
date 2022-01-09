import 'package:dsixv02app/models/shop/damageArmorWeight.dart';
import 'package:dsixv02app/models/shop/item.dart';
import 'package:dsixv02app/shared/app_Colors.dart';
import 'package:dsixv02app/shared/widgets/dialogButton.dart';
import 'package:dsixv02app/shared/widgets/uiColor.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

// ignore: must_be_immutable
class LootDetail extends StatelessWidget {
  String? playerID;

  Item? item;

  LootDetail({
    Key? key,
    @required this.playerID,
    @required this.item,
  }) : super(key: key);

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
            color: _uiColor.setUIColor(playerID, 'primary'),
            width: 2,
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              height: MediaQuery.of(context).size.height * 0.05,
              color: _uiColor.setUIColor(playerID, 'primary'),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(30, 5, 30, 7),
                child: Center(
                  child: Text('${item!.name}'.toUpperCase(),
                      style: TextStyle(
                        fontFamily: 'Santana',
                        height: 1,
                        fontSize: 25,
                        color: _uiColor.setUIColor(playerID, 'secondary'),
                        fontWeight: FontWeight.bold,
                        letterSpacing: 3,
                      )),
                ),
              ),
            ),
            Column(
              children: [
                Divider(
                  height: 0,
                  thickness: 2,
                  color: _uiColor.setUIColor(playerID, 'primary'),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.05,
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
                  height: MediaQuery.of(context).size.height * 0.05,
                ),
                Divider(
                  height: 0,
                  thickness: 2,
                  color: _uiColor.setUIColor(playerID, 'primary'),
                ),
                Container(
                  height: MediaQuery.of(context).size.height * 0.07,
                  child: SizedBox(
                      width: MediaQuery.of(context).size.width * 0.7,
                      child: (item!.itemSlot != 'consumable')
                          ? DamageArmorWeight(
                              playerID: playerID,
                              pDamage: item!.pDamage,
                              mDamage: item!.mDamage,
                              pArmor: item!.pArmor,
                              mArmor: item!.mArmor,
                              weight: item!.weight,
                            )
                          : Center(
                              child: Text(
                                item!.description!,
                                style: TextStyle(
                                  fontSize: 20,
                                  letterSpacing: 1,
                                  fontFamily: 'Calibri',
                                  color: AppColors.white00,
                                ),
                              ),
                            )),
                ),
                Divider(
                  height: 0,
                  thickness: 2,
                  color: _uiColor.setUIColor(playerID, 'primary'),
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
