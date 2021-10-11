import 'package:dsixv02app/core/app_images.dart';
import 'package:dsixv02app/models/dsix/dsix.dart';
import 'package:dsixv02app/widgets/buttons/appBarItem.dart';
import 'package:dsixv02app/widgets/buildPageView.dart';
import 'package:dsixv02app/widgets/dialogs/healthDialog.dart';
import 'package:dsixv02app/widgets/buttons/homeButton.dart';
import 'package:dsixv02app/widgets/dialogs/goldDialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'gmUIVM.dart';

class GmUI extends StatefulWidget {
  final Dsix dsix;

  const GmUI({Key key, this.dsix}) : super(key: key);

  static const String routeName = "/gmUI";

  @override
  _GmUIState createState() => new _GmUIState();
}

class _GmUIState extends State<GmUI> {
  GmUIVM _gmUIVM = GmUIVM();

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
            buttonColor: widget.dsix.gm.secondaryColor,
          ),
        ),
        backgroundColor: widget.dsix.gm.primaryColor,
        actions: <Widget>[],
      ),
      body: new SafeArea(
        child: BuildPageView(
          pageController: _gmUIVM.pageController,
          dsix: widget.dsix,
          refresh: () async {
            refresh();
          },
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        onTap: (value) {
          setState(() {
            _gmUIVM.changePage(value);
          });
        },
        showSelectedLabels: false,
        showUnselectedLabels: false,
        currentIndex: _gmUIVM.selectedPage,
        backgroundColor: widget.dsix.gm.primaryColor,
        items: [
          BottomNavigationBarItem(
            label: 'story',
            activeIcon: SvgPicture.asset(
              AppImages.shop,
              color: widget.dsix.gm.secondaryColor,
              width: MediaQuery.of(context).size.width * 0.06,
            ),
            icon: SvgPicture.asset(
              AppImages.shop,
              color: widget.dsix.gm.tertiaryColor,
              width: MediaQuery.of(context).size.width * 0.06,
            ),
          ),
        ],
      ),
    );
  }
}
