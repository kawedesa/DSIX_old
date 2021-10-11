import 'package:dsixv02app/core/app_colors.dart';
import 'package:dsixv02app/widgets/description.dart';
import 'package:dsixv02app/widgets/descriptionTitle.dart';
import 'package:dsixv02app/widgets/dialogs/itemDialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:dsixv02app/models/dsix/dsix.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'shopPageVM.dart';

class ShopPage extends StatefulWidget {
  final Function() refresh;
  final Function(String) alert;
  final Dsix dsix;

  const ShopPage({Key key, this.dsix, this.refresh, this.alert})
      : super(key: key);

  @override
  _ShopPageState createState() => _ShopPageState();
}

class _ShopPageState extends State<ShopPage> {
  ShopPageVM _shopPageVM = ShopPageVM();

  @override
  Widget build(BuildContext context) {
    if (_shopPageVM.selector.items.isEmpty) {
      _shopPageVM.selector.newSelection(_shopPageVM.menu.length);
    }

    return Column(
      children: [
        Container(
          height: MediaQuery.of(context).size.height * 0.1,
          width: double.infinity,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(5, 2.5, 10, 0),
            child: GridView.count(
              crossAxisCount: 6,
              children: List.generate(6, (index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        _shopPageVM.menuSelection(widget.dsix.shop, index);
                        // nextButtonSize =
                        //     MediaQuery.of(context).size.width * 0.06;
                      });
                    },
                    child: SvgPicture.asset(
                      'assets/icon/ui/${_shopPageVM.menu[index]}.svg',
                      color: _shopPageVM.selector.items[index]
                          ? widget.dsix.getCurrentPlayer().primaryColor
                          : AppColors.white01,
                    ),
                  ),
                );
              }),
            ),
          ),
        ),
        Divider(
          height: 0,
          thickness: 2,
          color: widget.dsix.getCurrentPlayer().primaryColor,
        ),
        Expanded(
          child: Container(
            width: MediaQuery.of(context).size.width * 0.8,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 15, 0, 0),
                  child: DescriptionTitle(
                    title: _shopPageVM.title,
                    color: widget.dsix.getCurrentPlayer().primaryColor,
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                    child: (_shopPageVM.selectedMenu.isEmpty)
                        ? Description(description: _shopPageVM.description)
                        : Container(
                            child: GridView.count(
                              crossAxisCount: 4,
                              mainAxisSpacing: 20,
                              children: List.generate(
                                  _shopPageVM.selectedMenu.length, (index) {
                                return GestureDetector(
                                  onTap: () async {
                                    showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return ItemDialog(
                                          menu: 'shop',
                                          item: _shopPageVM.selectedMenu[index],
                                          player:
                                              widget.dsix.getCurrentPlayer(),
                                        );
                                      },
                                    ).then((_) => setState(() {
                                          widget.refresh();
                                        }));
                                  },
                                  child: Container(
                                    width: double.infinity,
                                    height: 80,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        SvgPicture.asset(
                                          'assets/icon/item/${_shopPageVM.selectedMenu[index].icon}.svg',
                                          color: Colors.white,
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.125,
                                        ),
                                        Text(
                                          '${_shopPageVM.selectedMenu[index].value}',
                                          style: TextStyle(
                                            height: 1,
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                            letterSpacing: 2,
                                            fontFamily: 'Calibri',
                                            color: widget.dsix
                                                .getCurrentPlayer()
                                                .primaryColor,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              }),
                            ),
                          ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
