import 'package:dsixv02app/shared/app_Colors.dart';
import 'package:dsixv02app/shared/app_Icons.dart';
import 'package:dsixv02app/shared/widgets/uiColor.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../player.dart';

class Iventory extends StatefulWidget {
  final Player player;

  const Iventory({@required this.player});

  @override
  State<Iventory> createState() => _IventoryState();
}

class _IventoryState extends State<Iventory> {
  UIColor _uiColor = UIColor();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      contentPadding: EdgeInsets.fromLTRB(0, 0, 0, 0),
      content: Container(
        width: MediaQuery.of(context).size.width * 0.8,
        decoration: BoxDecoration(
          color: AppColors.black00,
          border: Border.all(
            color: _uiColor.setUIColor(widget.player.id, 'primary'),
            width: 2,
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              color: _uiColor.setUIColor(widget.player.id, 'primary'),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(30, 5, 30, 7),
                child: Center(
                  child: Text('iventory'.toUpperCase(),
                      style: TextStyle(
                        fontFamily: 'Santana',
                        height: 1,
                        fontSize: 25,
                        color:
                            _uiColor.setUIColor(widget.player.id, 'secondary'),
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
                                    widget.player.id, 'primary'),
                                width:
                                    MediaQuery.of(context).size.height * 0.035,
                              ),
                              Padding(
                                padding: const EdgeInsets.fromLTRB(8, 0, 0, 0),
                                child: Text(
                                  '${widget.player.pDamage}',
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
                                    widget.player.id, 'primary'),
                                width:
                                    MediaQuery.of(context).size.height * 0.035,
                              ),
                              Padding(
                                padding: const EdgeInsets.fromLTRB(8, 0, 0, 0),
                                child: Text(
                                  '${widget.player.mDamage}',
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
                                    widget.player.id, 'primary'),
                                width:
                                    MediaQuery.of(context).size.height * 0.035,
                              ),
                              Padding(
                                padding: const EdgeInsets.fromLTRB(8, 0, 0, 0),
                                child: Text(
                                  '${widget.player.pArmor}',
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
                                    widget.player.id, 'primary'),
                                width:
                                    MediaQuery.of(context).size.height * 0.035,
                              ),
                              Padding(
                                padding: const EdgeInsets.fromLTRB(8, 0, 0, 0),
                                child: Text(
                                  '${widget.player.mArmor}',
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
                    color: _uiColor.setUIColor(widget.player.id, 'primary'),
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
                                      widget.player.unequip(
                                          widget.player.mainHandSlot,
                                          'mainHandSlot');
                                    });
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        color: _uiColor.setUIColor(
                                            widget.player.id, 'primary'),
                                        width: 1,
                                      ),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: SvgPicture.asset(
                                        (widget.player.mainHandSlot.name != '')
                                            ? widget.player.mainHandSlot.icon
                                            : AppIcons.mainHandSlot,
                                        width: double.infinity,
                                        color: (widget
                                                    .player.mainHandSlot.name !=
                                                '')
                                            ? AppColors.white00
                                            : _uiColor.setUIColor(
                                                widget.player.id, 'primary'),
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
                                      widget.player.unequip(
                                          widget.player.handSlot, 'handSlot');
                                    });
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        color: _uiColor.setUIColor(
                                            widget.player.id, 'primary'),
                                        width: 1,
                                      ),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: SvgPicture.asset(
                                        (widget.player.handSlot.name != '')
                                            ? widget.player.handSlot.icon
                                            : AppIcons.handSlot,
                                        width: double.infinity,
                                        color: (widget.player.handSlot.name !=
                                                '')
                                            ? AppColors.white00
                                            : _uiColor.setUIColor(
                                                widget.player.id, 'primary'),
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
                                      widget.player.unequip(
                                          widget.player.headSlot, 'headSlot');
                                    });
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        color: _uiColor.setUIColor(
                                            widget.player.id, 'primary'),
                                        width: 1,
                                      ),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: SvgPicture.asset(
                                        (widget.player.headSlot.name != '')
                                            ? widget.player.headSlot.icon
                                            : AppIcons.headSlot,
                                        width: double.infinity,
                                        color: (widget.player.headSlot.name !=
                                                '')
                                            ? AppColors.white00
                                            : _uiColor.setUIColor(
                                                widget.player.id, 'primary'),
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
                                      widget.player.unequip(
                                          widget.player.bodySlot, 'bodySlot');
                                    });
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        color: _uiColor.setUIColor(
                                            widget.player.id, 'primary'),
                                        width: 1,
                                      ),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: SvgPicture.asset(
                                        (widget.player.bodySlot.name != '')
                                            ? widget.player.bodySlot.icon
                                            : AppIcons.bodySlot,
                                        width: double.infinity,
                                        color: (widget.player.bodySlot.name !=
                                                '')
                                            ? AppColors.white00
                                            : _uiColor.setUIColor(
                                                widget.player.id, 'primary'),
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
                                      widget.player.unequip(
                                          widget.player.offHandSlot,
                                          'offHandSlot');
                                    });
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        color: _uiColor.setUIColor(
                                            widget.player.id, 'primary'),
                                        width: 1,
                                      ),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: SvgPicture.asset(
                                        (widget.player.offHandSlot.name != '')
                                            ? widget.player.offHandSlot.icon
                                            : AppIcons.offHandSlot,
                                        width: double.infinity,
                                        color: (widget
                                                    .player.offHandSlot.name !=
                                                '')
                                            ? AppColors.white00
                                            : _uiColor.setUIColor(
                                                widget.player.id, 'primary'),
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
                                      widget.player.unequip(
                                          widget.player.feetSlot, 'feetSlot');
                                    });
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        color: _uiColor.setUIColor(
                                            widget.player.id, 'primary'),
                                        width: 1,
                                      ),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: SvgPicture.asset(
                                        (widget.player.feetSlot.name != '')
                                            ? widget.player.feetSlot.icon
                                            : AppIcons.feetSlot,
                                        width: double.infinity,
                                        color: (widget.player.feetSlot.name !=
                                                '')
                                            ? AppColors.white00
                                            : _uiColor.setUIColor(
                                                widget.player.id, 'primary'),
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
                    color: _uiColor.setUIColor(widget.player.id, 'primary'),
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(30, 5, 30, 7),
                      child: Center(
                        child: Text('bag'.toUpperCase(),
                            style: TextStyle(
                              fontFamily: 'Santana',
                              height: 1,
                              fontSize: 25,
                              color: _uiColor.setUIColor(
                                  widget.player.id, 'secondary'),
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
                      children:
                          List.generate(widget.player.bag.length, (index) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 3),
                          child: GestureDetector(
                            onDoubleTap: () {
                              setState(() {
                                widget.player
                                    .equipItem(widget.player.bag[index]);
                              });
                            },
                            child: SvgPicture.asset(
                              widget.player.bag[index].icon,
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
