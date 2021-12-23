import 'package:dsixv02app/models/gameController.dart';
import 'package:dsixv02app/shared/app_Colors.dart';
import 'package:dsixv02app/shared/app_Icons.dart';
import 'package:dsixv02app/shared/widgets/uiColor.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import '../user.dart';

class Iventory extends StatefulWidget {
  const Iventory({
    Key? key,
  }) : super(key: key);

  @override
  State<Iventory> createState() => _IventoryState();
}

class _IventoryState extends State<Iventory> {
  UIColor _uiColor = UIColor();

  @override
  Widget build(BuildContext context) {
    final gameController = Provider.of<GameController>(context);
    final user = Provider.of<User>(context);

    return AlertDialog(
      contentPadding: EdgeInsets.fromLTRB(0, 0, 0, 0),
      content: Container(
        width: MediaQuery.of(context).size.width * 0.8,
        decoration: BoxDecoration(
          color: AppColors.black00,
          border: Border.all(
            color: _uiColor.setUIColor(user.selectedPlayerID, 'primary'),
            width: 2,
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              color: _uiColor.setUIColor(user.selectedPlayerID, 'primary'),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(30, 5, 30, 7),
                child: Center(
                  child: Text('iventory'.toUpperCase(),
                      style: TextStyle(
                        fontFamily: 'Santana',
                        height: 1,
                        fontSize: 25,
                        color: _uiColor.setUIColor(
                            user.selectedPlayerID, 'secondary'),
                        fontWeight: FontWeight.bold,
                        letterSpacing: 3,
                      )),
                ),
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.75,
              child: Column(
                children: [
                  Container(
                    height: MediaQuery.of(context).size.height * 0.07,
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width * 0.7,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              SvgPicture.asset(
                                AppIcons.pDamage,
                                color: _uiColor.setUIColor(
                                    user.selectedPlayerID, 'primary'),
                                width:
                                    MediaQuery.of(context).size.height * 0.035,
                              ),
                              Padding(
                                padding: const EdgeInsets.fromLTRB(8, 0, 0, 0),
                                child: Text(
                                  '${user.selectedPlayer!.pDamage}',
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
                                color: _uiColor.setUIColor(
                                    user.selectedPlayerID, 'primary'),
                                width:
                                    MediaQuery.of(context).size.height * 0.035,
                              ),
                              Padding(
                                padding: const EdgeInsets.fromLTRB(8, 0, 0, 0),
                                child: Text(
                                  '${user.selectedPlayer!.mDamage}',
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
                                color: _uiColor.setUIColor(
                                    user.selectedPlayerID, 'primary'),
                                width:
                                    MediaQuery.of(context).size.height * 0.035,
                              ),
                              Padding(
                                padding: const EdgeInsets.fromLTRB(8, 0, 0, 0),
                                child: Text(
                                  '${user.selectedPlayer!.pArmor}',
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
                                color: _uiColor.setUIColor(
                                    user.selectedPlayerID, 'primary'),
                                width:
                                    MediaQuery.of(context).size.height * 0.035,
                              ),
                              Padding(
                                padding: const EdgeInsets.fromLTRB(8, 0, 0, 0),
                                child: Text(
                                  '${user.selectedPlayer!.mArmor}',
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
                        ],
                      ),
                    ),
                  ),
                  Divider(
                    height: 0,
                    thickness: 2,
                    color:
                        _uiColor.setUIColor(user.selectedPlayerID, 'primary'),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.8,
                    height: MediaQuery.of(context).size.height * 0.4,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          flex: 1,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                flex: 2,
                                child: GestureDetector(
                                  onDoubleTap: () {
                                    setState(() {
                                      user.selectedPlayer!.unequip(
                                          user.selectedPlayer!.mainHandSlot!,
                                          'mainHandSlot');
                                      user.updateIventory(
                                          gameController.gameID);
                                    });
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        color: _uiColor.setUIColor(
                                            user.selectedPlayerID, 'primary'),
                                        width: 1,
                                      ),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: SvgPicture.asset(
                                        (user.selectedPlayer!.mainHandSlot!
                                                    .name !=
                                                '')
                                            ? user.selectedPlayer!.mainHandSlot!
                                                .icon!
                                            : AppIcons.mainHandSlot,
                                        width: double.infinity,
                                        color: (user.selectedPlayer!
                                                    .mainHandSlot!.name !=
                                                '')
                                            ? AppColors.white00
                                            : _uiColor.setUIColor(
                                                user.selectedPlayerID,
                                                'primary'),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 1,
                                child: GestureDetector(
                                  onDoubleTap: () {
                                    setState(() {
                                      user.selectedPlayer!.unequip(
                                          user.selectedPlayer!.handSlot!,
                                          'handSlot');
                                      user.updateIventory(
                                          gameController.gameID);
                                    });
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        color: _uiColor.setUIColor(
                                            user.selectedPlayerID, 'primary'),
                                        width: 1,
                                      ),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: SvgPicture.asset(
                                        (user.selectedPlayer!.handSlot!.name !=
                                                '')
                                            ? user
                                                .selectedPlayer!.handSlot!.icon!
                                            : AppIcons.handSlot,
                                        width: double.infinity,
                                        color: (user.selectedPlayer!.handSlot!
                                                    .name !=
                                                '')
                                            ? AppColors.white00
                                            : _uiColor.setUIColor(
                                                user.selectedPlayerID,
                                                'primary'),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                flex: 1,
                                child: GestureDetector(
                                  onDoubleTap: () {
                                    setState(() {
                                      user.selectedPlayer!.unequip(
                                          user.selectedPlayer!.headSlot!,
                                          'headSlot');
                                      user.updateIventory(
                                          gameController.gameID);
                                    });
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        color: _uiColor.setUIColor(
                                            user.selectedPlayerID, 'primary'),
                                        width: 1,
                                      ),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: SvgPicture.asset(
                                        (user.selectedPlayer!.headSlot!.name !=
                                                '')
                                            ? user
                                                .selectedPlayer!.headSlot!.icon!
                                            : AppIcons.headSlot,
                                        width: double.infinity,
                                        color: (user.selectedPlayer!.headSlot!
                                                    .name !=
                                                '')
                                            ? AppColors.white00
                                            : _uiColor.setUIColor(
                                                user.selectedPlayerID,
                                                'primary'),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 2,
                                child: GestureDetector(
                                  onDoubleTap: () {
                                    setState(() {
                                      user.selectedPlayer!.unequip(
                                          user.selectedPlayer!.bodySlot!,
                                          'bodySlot');
                                      user.updateIventory(
                                          gameController.gameID);
                                    });
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        color: _uiColor.setUIColor(
                                            user.selectedPlayerID, 'primary'),
                                        width: 1,
                                      ),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: SvgPicture.asset(
                                        (user.selectedPlayer!.bodySlot!.name !=
                                                '')
                                            ? user
                                                .selectedPlayer!.bodySlot!.icon!
                                            : AppIcons.bodySlot,
                                        width: double.infinity,
                                        color: (user.selectedPlayer!.bodySlot!
                                                    .name !=
                                                '')
                                            ? AppColors.white00
                                            : _uiColor.setUIColor(
                                                user.selectedPlayerID,
                                                'primary'),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                flex: 2,
                                child: GestureDetector(
                                  onDoubleTap: () {
                                    setState(() {
                                      user.selectedPlayer!.unequip(
                                          user.selectedPlayer!.offHandSlot!,
                                          'offHandSlot');
                                      user.updateIventory(
                                          gameController.gameID);
                                    });
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        color: _uiColor.setUIColor(
                                            user.selectedPlayerID, 'primary'),
                                        width: 1,
                                      ),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: SvgPicture.asset(
                                        (user.selectedPlayer!.offHandSlot!.name !=
                                                '')
                                            ? user.selectedPlayer!.offHandSlot!
                                                .icon!
                                            : AppIcons.offHandSlot,
                                        width: double.infinity,
                                        color: (user.selectedPlayer!
                                                    .offHandSlot!.name !=
                                                '')
                                            ? AppColors.white00
                                            : _uiColor.setUIColor(
                                                user.selectedPlayerID,
                                                'primary'),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 1,
                                child: GestureDetector(
                                  onDoubleTap: () {
                                    setState(() {
                                      user.selectedPlayer!.unequip(
                                          user.selectedPlayer!.feetSlot!,
                                          'feetSlot');
                                      user.updateIventory(
                                          gameController.gameID);
                                    });
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        color: _uiColor.setUIColor(
                                            user.selectedPlayerID, 'primary'),
                                        width: 1,
                                      ),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: SvgPicture.asset(
                                        (user.selectedPlayer!.feetSlot!.name !=
                                                '')
                                            ? user
                                                .selectedPlayer!.feetSlot!.icon!
                                            : AppIcons.feetSlot,
                                        width: double.infinity,
                                        color: (user.selectedPlayer!.feetSlot!
                                                    .name !=
                                                '')
                                            ? AppColors.white00
                                            : _uiColor.setUIColor(
                                                user.selectedPlayerID,
                                                'primary'),
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
                  ),
                  Container(
                    color:
                        _uiColor.setUIColor(user.selectedPlayerID, 'primary'),
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(30, 5, 30, 7),
                      child: Center(
                        child: Text('bag'.toUpperCase(),
                            style: TextStyle(
                              fontFamily: 'Santana',
                              height: 1,
                              fontSize: 25,
                              color: _uiColor.setUIColor(
                                  user.selectedPlayerID, 'secondary'),
                              fontWeight: FontWeight.bold,
                              letterSpacing: 3,
                            )),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: GridView.count(
                      shrinkWrap: true,
                      crossAxisCount: 6,
                      children: List.generate(user.selectedPlayer!.bag!.length,
                          (index) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 3),
                          child: GestureDetector(
                            onLongPress: () {
                              setState(() {
                                user.selectedPlayer!.destroyItem(
                                    user.selectedPlayer!.bag![index]);
                                user.updateIventory(gameController.gameID);
                              });
                            },
                            onDoubleTap: () {
                              setState(() {
                                user.selectedPlayer!.equipItem(
                                    user.selectedPlayer!.bag![index]);
                                user.updateIventory(gameController.gameID);
                              });
                            },
                            child: SvgPicture.asset(
                              user.selectedPlayer!.bag![index].icon!,
                              color: Colors.white,
                            ),
                          ),
                        );
                      }),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
