import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'playersPage.dart';
import 'playerInventoryPage.dart';

import 'playerShopPage.dart';
import 'playerActionPage.dart';
import 'playerHelpPage.dart';
import 'package:dsixv02app/models/game/dsix.dart';
import 'npcPage.dart';

class GmUI extends StatefulWidget {
  final Dsix dsix;

  const GmUI({
    Key key,
    this.dsix,
  }) : super(key: key);

  static const String routeName = "/gmUI";

  @override
  _GmUIState createState() => new _GmUIState();
}

class _GmUIState extends State<GmUI> {
  refreshPage() {
    setState(() {});
  }

  int bottomSelectedIndex = 0;
  String pageTitle = 'STORY';

  void pageChanged(int index) {
    setState(() {
      bottomSelectedIndex = index;
      switch (index) {
        case 0:
          {
            pageTitle = 'STORY';
          }
          break;
        case 1:
          {
            pageTitle = 'NPC';
          }
          break;
        case 2:
          {
            pageTitle = 'LOOT';
          }
          break;
        case 3:
          {
            pageTitle = 'ACTION';
          }
          break;
        case 4:
          {
            pageTitle = 'MAP';
          }
          break;
        case 5:
          {
            pageTitle = 'HELP';
          }
          break;
      }
    });
  }

  void bottomTapped(int index) {
    setState(() {
      switch (index) {
        case 0:
          {
            pageTitle = 'STORY';
          }
          break;
        case 1:
          {
            pageTitle = 'NPC';
          }
          break;
        case 2:
          {
            pageTitle = 'LOOT';
          }
          break;
        case 3:
          {
            pageTitle = 'ACTION';
          }
          break;
        case 4:
          {
            pageTitle = 'MAP';
          }
          break;
        case 5:
          {
            pageTitle = 'HELP';
          }
          break;
      }
      bottomSelectedIndex = index;
      pageController.animateToPage(index,
          duration: Duration(milliseconds: 500), curve: Curves.ease);
    });
  }

  List<BottomNavigationBarItem> buildBottomNavBarItems() {
    return [
      BottomNavigationBarItem(
        activeIcon: new SvgPicture.asset(
          'assets/item/book.svg',
          color: Colors.white,
          width: MediaQuery.of(context).size.width * 0.1,
        ),
        icon: new SvgPicture.asset(
          'assets/item/book.svg',
          color: Colors.grey[600],
          width: MediaQuery.of(context).size.width * 0.1,
        ),
        label: '',
      ),
      BottomNavigationBarItem(
        activeIcon: new SvgPicture.asset(
          'assets/player/shop.svg',
          color: Colors.white,
          width: MediaQuery.of(context).size.width * 0.060,
        ),
        icon: new SvgPicture.asset(
          'assets/player/shop.svg',
          color: Colors.grey[600],
          width: MediaQuery.of(context).size.width * 0.060,
        ),
        label: 'SHOP',
      ),
      BottomNavigationBarItem(
        activeIcon: new SvgPicture.asset(
          'assets/player/inventory.svg',
          color: Colors.white,
          width: MediaQuery.of(context).size.width * 0.070,
        ),
        icon: new SvgPicture.asset(
          'assets/player/inventory.svg',
          color: Colors.grey[600],
          width: MediaQuery.of(context).size.width * 0.070,
        ),
        label: 'INVENTORY',
      ),
      BottomNavigationBarItem(
        activeIcon: new SvgPicture.asset(
          'assets/player/action.svg',
          color: Colors.white,
          width: MediaQuery.of(context).size.width * 0.075,
        ),
        icon: new SvgPicture.asset(
          'assets/player/action.svg',
          color: Colors.grey[600],
          width: MediaQuery.of(context).size.width * 0.065,
        ),
        label: '',
      ),
      BottomNavigationBarItem(
        activeIcon: new SvgPicture.asset(
          'assets/player/map.svg',
          color: Colors.white,
          width: MediaQuery.of(context).size.width * 0.1,
        ),
        icon: new SvgPicture.asset(
          'assets/player/map.svg',
          color: Colors.grey[600],
          width: MediaQuery.of(context).size.width * 0.1,
        ),
        label: '',
      ),
      BottomNavigationBarItem(
        activeIcon: new SvgPicture.asset(
          'assets/player/help.svg',
          color: Colors.white,
          width: MediaQuery.of(context).size.width * 0.085,
        ),
        icon: new SvgPicture.asset(
          'assets/player/help.svg',
          color: Colors.grey[600],
          width: MediaQuery.of(context).size.width * 0.075,
        ),
        label: '',
      ),
    ];
  }

  PageController pageController = PageController(
    initialPage: 0,
    keepPage: true,
  );

  Widget buildPageView() {
    return PageView(
      controller: pageController,
      onPageChanged: (index) {
        pageChanged(index);
      },
      children: <Widget>[
        NpcPage(dsix: widget.dsix, refresh: refreshPage),
        NpcPage(dsix: widget.dsix, refresh: refreshPage),
        NpcPage(dsix: widget.dsix, refresh: refreshPage),
        NpcPage(dsix: widget.dsix, refresh: refreshPage),
        NpcPage(dsix: widget.dsix, refresh: refreshPage),
        NpcPage(dsix: widget.dsix, refresh: refreshPage),
      ],
    );
  }

  Route _createRouteHome() {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) =>
          PlayersPage(dsix: widget.dsix),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        var begin = Offset(-1, 0);
        var end = Offset(0.0, 0.0);
        var curve = Curves.ease;
        var tween =
            Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

        return SlideTransition(
          position: animation.drive(tween),
          child: child,
        );
      },
    );
  }

  @override
  void initState() {
    super.initState();
  }

  Widget build(BuildContext context) {
    return new Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.fromLTRB(5, 2, 0, 0),
          child: IconButton(
            icon: Icon(
              Icons.exit_to_app,
              color: Colors.grey[400],
              size: 32,
            ),
            onPressed: () {
              Navigator.of(context).push(_createRouteHome());
            },
          ),
        ),
        titleSpacing: 10,
        backgroundColor: Colors.grey[900],
        title: new Text(
          '$pageTitle',
          textAlign: TextAlign.left,
          style: TextStyle(
            fontFamily: 'Headline',
            height: 1.3,
            fontSize: 24.0,
            color: Colors.grey[600],
            letterSpacing: 2,
          ),
        ),
        actions: [],
      ),
      body: new SafeArea(
        child: buildPageView(),
      ),
      bottomNavigationBar: BottomNavigationBar(
        selectedLabelStyle: TextStyle(
          color: Colors.grey[600],
        ),
        unselectedLabelStyle: TextStyle(
          color: Colors.grey[600],
        ),
        type: BottomNavigationBarType.fixed,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        backgroundColor: Colors.grey[900],
        currentIndex: bottomSelectedIndex,
        onTap: (index) {
          bottomTapped(index);
        },
        items: buildBottomNavBarItems(),
      ),
    );
  }
}
