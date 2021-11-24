import 'package:dsixv02app/core/app_images.dart';
import 'package:dsixv02app/models/dsix/dsix.dart';
import 'package:dsixv02app/pages/player/action/actionPage.dart';
import 'package:dsixv02app/pages/player/inventory/playerInventoryPage.dart';
import 'package:dsixv02app/pages/player/map/playerMapPage.dart';
import 'package:dsixv02app/pages/player/shop/shopPage.dart';
import 'package:dsixv02app/widgets/buttons/appBarItem.dart';
import 'package:dsixv02app/widgets/dialogs/healthDialog.dart';
import 'package:dsixv02app/widgets/buttons/homeButton.dart';
import 'package:dsixv02app/widgets/dialogs/goldDialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'playerUIVM.dart';

class PlayerUI extends StatefulWidget {
  final Dsix dsix;

  const PlayerUI({Key key, this.dsix}) : super(key: key);

  static const String routeName = "/playerUI";

  @override
  _PlayerUIState createState() => new _PlayerUIState();
}

class _PlayerUIState extends State<PlayerUI> {
  PlayerUIVM _playerUIVM = PlayerUIVM();

  refresh() {
    setState(() {});
  }

  // SnackBar displayAlert(String description) {
  //   SnackBar newAlert = new SnackBar(
  //     backgroundColor:
  //         widget.dsix.gm.getCurrentPlayer().playerColor.primaryColor,
  //     content: Container(
  //       height: MediaQuery.of(context).size.height * 0.05,
  //       child: Text(
  //         description,
  //         textAlign: TextAlign.center,
  //         style: TextStyle(
  //           height: 1.25,
  //           fontSize: 22,
  //           fontFamily: 'Calibri',
  //           color: Colors.white,
  //         ),
  //       ),
  //     ),
  //   );
  //   return newAlert;
  // }

  Widget build(BuildContext context) {
    return new Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        leadingWidth: MediaQuery.of(context).size.width * 0.1,
        leading: Padding(
          padding: const EdgeInsets.fromLTRB(16, 0, 0, 0),
          child: HomeButton(
            dsix: widget.dsix,
            buttonColor: widget.dsix.getCurrentPlayer().secondaryColor,
          ),
        ),
        backgroundColor: widget.dsix.getCurrentPlayer().primaryColor,
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 0, 15, 0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                AppBarItem(
                    buttonText: widget.dsix.getCurrentPlayer().gold.toString(),
                    buttonIcon: 'gold',
                    textColor: widget.dsix.getCurrentPlayer().secondaryColor,
                    onTapAction: () async {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return GoldDialog(
                            player: widget.dsix.getCurrentPlayer(),
                            color: widget.dsix.getCurrentPlayer().primaryColor,
                          );
                        },
                      ).then((_) => setState(() {}));
                    }),
                Padding(
                  padding: const EdgeInsets.fromLTRB(15, 0, 0, 0),
                  child: AppBarItem(
                      buttonText:
                          widget.dsix.getCurrentPlayer().health.toString(),
                      buttonIcon: 'health',
                      textColor: widget.dsix.getCurrentPlayer().secondaryColor,
                      onTapAction: () async {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return HealthDialog(
                              dsix: widget.dsix,
                              player: widget.dsix.getCurrentPlayer(),
                              gm: widget.dsix.gm,
                              color:
                                  widget.dsix.getCurrentPlayer().primaryColor,
                            );
                          },
                        ).then((_) => setState(() {}));
                      }),
                ),
                GestureDetector(
                  // onTap: () {
                  //TODO : weight
                  //   showAlertDialogWeight(context);
                  // },
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        SvgPicture.asset(
                          AppImages.weight,
                          color: Colors.white,
                          width: MediaQuery.of(context).size.width * 0.065,
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(7, 1, 0, 5),
                          child: Text(
                            '${widget.dsix.getCurrentPlayer().weight}',
                            textAlign: TextAlign.left,
                            style: TextStyle(
                              fontFamily: 'Santana',
                              height: 1,
                              fontSize: 25,
                              color:
                                  widget.dsix.getCurrentPlayer().secondaryColor,
                              letterSpacing: 1.2,
                            ),
                          ),
                        ),
                        Text(
                          '/',
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            fontFamily: 'Santana',
                            height: 1,
                            fontSize: 25,
                            color:
                                widget.dsix.getCurrentPlayer().secondaryColor,
                            letterSpacing: 1.2,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(1, 6, 5, 0),
                          child: Text(
                            '${widget.dsix.getCurrentPlayer().race.maxWeight}',
                            textAlign: TextAlign.left,
                            style: TextStyle(
                              fontFamily: 'Santana',
                              height: 1,
                              fontSize: 25,
                              color:
                                  widget.dsix.getCurrentPlayer().secondaryColor,
                              letterSpacing: 1.2,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      body: new SafeArea(
        child: PageView(
          controller: _playerUIVM.pageController,
          physics: (_playerUIVM.selectedPage == 3)
              ? NeverScrollableScrollPhysics()
              : ScrollPhysics(),
          onPageChanged: (index) {
            setState(() {
              _playerUIVM.selectedPage = index;
            });
          },
          children: <Widget>[
            ShopPage(
              dsix: this.widget.dsix,
              refresh: refresh,
              // alert: displayAlert,
            ),
            InventoryPage(
              dsix: this.widget.dsix,
              refresh: refresh,
              // alert: displayAlert,
            ),
            ActionPage(
              dsix: this.widget.dsix,
              refresh: refresh,
              // alert: displayAlert,
            ),
            PlayerMapPage(
              dsix: this.widget.dsix,
              refresh: refresh,
              // alert: displayAlert,
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        onTap: (index) {
          setState(() {
            _playerUIVM.changePage(index);
          });
        },
        type: BottomNavigationBarType.fixed,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        currentIndex: _playerUIVM.selectedPage,
        backgroundColor: widget.dsix.getCurrentPlayer().primaryColor,
        items: [
          BottomNavigationBarItem(
            label: 'shop',
            activeIcon: SvgPicture.asset(
              AppImages.shop,
              color: widget.dsix.getCurrentPlayer().secondaryColor,
              width: MediaQuery.of(context).size.width * 0.06,
            ),
            icon: SvgPicture.asset(
              AppImages.shop,
              color: widget.dsix.getCurrentPlayer().tertiaryColor,
              width: MediaQuery.of(context).size.width * 0.06,
            ),
          ),
          BottomNavigationBarItem(
            label: 'inventory',
            activeIcon: SvgPicture.asset(
              AppImages.inventory,
              color: widget.dsix.getCurrentPlayer().secondaryColor,
              width: MediaQuery.of(context).size.width * 0.070,
            ),
            icon: SvgPicture.asset(
              AppImages.inventory,
              color: widget.dsix.getCurrentPlayer().tertiaryColor,
              width: MediaQuery.of(context).size.width * 0.070,
            ),
          ),
          BottomNavigationBarItem(
            label: 'action',
            activeIcon: SvgPicture.asset(
              AppImages.action,
              color: widget.dsix.getCurrentPlayer().secondaryColor,
              width: MediaQuery.of(context).size.width * 0.070,
            ),
            icon: SvgPicture.asset(
              AppImages.action,
              color: widget.dsix.getCurrentPlayer().tertiaryColor,
              width: MediaQuery.of(context).size.width * 0.070,
            ),
          ),
          BottomNavigationBarItem(
            label: 'map',
            activeIcon: SvgPicture.asset(
              AppImages.map,
              color: widget.dsix.getCurrentPlayer().secondaryColor,
              width: MediaQuery.of(context).size.width * 0.095,
            ),
            icon: SvgPicture.asset(
              AppImages.map,
              color: widget.dsix.getCurrentPlayer().tertiaryColor,
              width: MediaQuery.of(context).size.width * 0.095,
            ),
          ),
        ],
      ),
    );
  }
}
