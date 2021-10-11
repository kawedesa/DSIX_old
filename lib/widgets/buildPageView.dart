import 'package:dsixv02app/models/dsix/dsix.dart';
import 'package:dsixv02app/pages/player/action/actionPage.dart';
import 'package:dsixv02app/pages/player/inventory/playerInventoryPage.dart';
import 'package:dsixv02app/pages/player/shop/shopPage.dart';
import 'package:flutter/material.dart';

class BuildPageView extends StatefulWidget {
  BuildPageView(
      {@required this.pageController, @required this.dsix, this.refresh});

  final PageController pageController;
  final Function() refresh;
  final Dsix dsix;

  @override
  State<BuildPageView> createState() => _BuildPageViewState();
}

class _BuildPageViewState extends State<BuildPageView> {
  @override
  Widget build(BuildContext context) {
    return PageView(
      controller: this.widget.pageController,
      physics: ScrollPhysics(),
      onPageChanged: (index) {
        widget.pageController.animateToPage(index,
            duration: Duration(milliseconds: 500), curve: Curves.ease);
      },
      children: <Widget>[
        ShopPage(
          dsix: this.widget.dsix,
          refresh: this.widget.refresh,
          // alert: displayAlert,
        ),
        InventoryPage(
          dsix: this.widget.dsix,
          refresh: this.widget.refresh,
          // alert: displayAlert,
        ),
        ActionPage(
          dsix: this.widget.dsix,
          refresh: this.widget.refresh,
          // alert: displayAlert,
        ),
        // CharacterPage(
        //   dsix: widget.dsix,
        // ),
        // ShopPage(
        //   dsix: widget.dsix,
        //   refresh: refresh,
        //   alert: displayAlert,
        // ),

        // ActionPage(
        //   dsix: widget.dsix,
        //   refresh: refresh,
        //   alert: displayAlert,
        // ),
        // PlayerMapPage(
        //   dsix: widget.dsix,
        // ),
        // HelpPage(
        //   dsix: widget.dsix,
        // ),
      ],
    );
  }
}
