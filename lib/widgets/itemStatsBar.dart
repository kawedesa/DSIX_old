import 'package:dsixv02app/models/dsix/item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ItemStatsBar extends StatelessWidget {
  const ItemStatsBar({this.color, this.item});

  final Item item;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.05,
      width: double.infinity,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(15, 3, 15, 10),
        child: (item.inventorySpace == 'consumable')
            ? Container(
                width: double.infinity,
                child: Text(
                  item.description,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    height: 1.2,
                    fontSize: 16,
                    fontFamily: 'Calibri',
                    color: Colors.white,
                  ),
                ),
              )
            : Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      SvgPicture.asset(
                        'assets/icon/ui/pDamage.svg',
                        color: color,
                        width: MediaQuery.of(context).size.width * 0.055,
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(5, 0, 3, 0),
                        child: Text(
                          '${item.pDamage}',
                          style: TextStyle(
                            fontFamily: 'Santana',
                            fontWeight: FontWeight.bold,
                            height: 1,
                            fontSize: 18,
                            color: Colors.white,
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
                        'assets/icon/ui/mDamage.svg',
                        color: color,
                        width: MediaQuery.of(context).size.width * 0.065,
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(5, 0, 3, 0),
                        child: Text(
                          '${item.mDamage}',
                          style: TextStyle(
                            fontFamily: 'Santana',
                            fontWeight: FontWeight.bold,
                            height: 1,
                            fontSize: 18,
                            color: Colors.white,
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
                        'assets/icon/ui/pArmor.svg',
                        color: color,
                        width: MediaQuery.of(context).size.width * 0.055,
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(5, 0, 3, 0),
                        child: Text(
                          '${item.pArmor}',
                          style: TextStyle(
                            fontFamily: 'Santana',
                            fontWeight: FontWeight.bold,
                            height: 1,
                            fontSize: 18,
                            color: Colors.white,
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
                        'assets/icon/ui/mArmor.svg',
                        color: color,
                        width: MediaQuery.of(context).size.width * 0.055,
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(5, 0, 3, 0),
                        child: Text(
                          '${item.mArmor}',
                          style: TextStyle(
                            fontFamily: 'Santana',
                            fontWeight: FontWeight.bold,
                            height: 1,
                            fontSize: 18,
                            color: Colors.white,
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
                        'assets/icon/ui/weight.svg',
                        color: color,
                        width: MediaQuery.of(context).size.width * 0.04,
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(5, 0, 0, 0),
                        child: Text(
                          '${item.weight}',
                          style: TextStyle(
                            fontFamily: 'Santana',
                            fontWeight: FontWeight.bold,
                            height: 1,
                            fontSize: 18,
                            color: Colors.white,
                            letterSpacing: 3,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
      ),
    );
  }
}
