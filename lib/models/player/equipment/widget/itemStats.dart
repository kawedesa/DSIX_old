import 'package:dsixv02app/models/shop/item.dart';
import 'package:dsixv02app/shared/app_Colors.dart';
import 'package:dsixv02app/shared/app_Icons.dart';
import 'package:dsixv02app/shared/widgets/uiColor.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

// ignore: must_be_immutable
class ItemStats extends StatelessWidget {
  String? id;
  Item? item;
  ItemStats({
    Key? key,
    @required this.id,
    @required this.item,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    UIColor _uiColor = UIColor();

    return Container(
      height: MediaQuery.of(context).size.height * 0.07,
      child: SizedBox(
          width: MediaQuery.of(context).size.width * 0.7,
          child: (item!.itemSlot != 'consumable')
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        SvgPicture.asset(
                          AppIcons.pDamage,
                          color: _uiColor.setUIColor(id, 'primary'),
                          width: MediaQuery.of(context).size.height * 0.035,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 2),
                          child: Text(
                            '${item!.pDamage}',
                            style: TextStyle(
                              fontFamily: 'Santana',
                              height: 1,
                              fontSize: 25,
                              color: AppColors.white00,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 3,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        SvgPicture.asset(
                          AppIcons.mDamage,
                          color: _uiColor.setUIColor(id, 'primary'),
                          width: MediaQuery.of(context).size.height * 0.035,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 2),
                          child: Text(
                            '${item!.mDamage}',
                            style: TextStyle(
                              fontFamily: 'Santana',
                              height: 1,
                              fontSize: 25,
                              color: AppColors.white00,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 3,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        SvgPicture.asset(
                          AppIcons.pArmor,
                          color: _uiColor.setUIColor(id, 'primary'),
                          width: MediaQuery.of(context).size.height * 0.035,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 2),
                          child: Text(
                            '${item!.pArmor}',
                            style: TextStyle(
                              fontFamily: 'Santana',
                              height: 1,
                              fontSize: 25,
                              color: AppColors.white00,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 3,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        SvgPicture.asset(
                          AppIcons.mArmor,
                          color: _uiColor.setUIColor(id, 'primary'),
                          width: MediaQuery.of(context).size.height * 0.035,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 2),
                          child: Text(
                            '${item!.mArmor}',
                            style: TextStyle(
                              fontFamily: 'Santana',
                              height: 1,
                              fontSize: 25,
                              color: AppColors.white00,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 3,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        SvgPicture.asset(
                          AppIcons.weight,
                          color: _uiColor.setUIColor(id, 'primary'),
                          width: MediaQuery.of(context).size.height * 0.037,
                        ),
                        Text(
                          '${item!.weight!}',
                          style: TextStyle(
                            fontFamily: 'Santana',
                            height: 1,
                            fontSize: 25,
                            color: AppColors.white00,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 3,
                          ),
                        ),
                      ],
                    ),
                  ],
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
    );
  }
}
