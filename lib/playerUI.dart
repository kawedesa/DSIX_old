import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'playersPage.dart';
import 'playerInventory.dart';
import 'playerCharacter.dart';
import 'playerShopPage.dart';
import 'playerActionPage.dart';
import 'playerHelp.dart';
import 'package:dsixv02app/models/game/game.dart';

class PlayerUI extends StatefulWidget {
  final Dsix dsix;

  const PlayerUI({Key key, this.dsix}) : super(key: key);

  static const String routeName = "/playerUI";

  @override
  _PlayerUIState createState() => new _PlayerUIState();
}

class _PlayerUIState extends State<PlayerUI> {
  showAlertDialogHealth(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              backgroundColor: Colors.black,
              contentPadding: EdgeInsets.fromLTRB(0, 0, 0, 0),
              content: Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    color:
                        widget.dsix.getCurrentPlayer().playerColor.primaryColor,
                    width: 1.5, //                   <--- border width here
                  ),
                ),
                width: 100,
                height: 250,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      color: widget.dsix
                          .getCurrentPlayer()
                          .playerColor
                          .primaryColor,
                      width: double.infinity,
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(0, 5, 0, 5),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              'HEALTH',
                              style: TextStyle(
                                fontFamily: 'Headline',
                                height: 1.3,
                                fontSize: 30.0,
                                color: Colors.white,
                                letterSpacing: 3,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(35, 25, 35, 10),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          GestureDetector(
                              onTap: () {
                                setState(() {
                                  if (widget.dsix
                                          .getCurrentPlayer()
                                          .currentHealth <
                                      widget.dsix
                                          .getCurrentPlayer()
                                          .maxHealth) {
                                    widget.dsix
                                        .getCurrentPlayer()
                                        .currentHealth += 1;
                                  }
                                });
                                refreshPage();
                              },
                              child: Icon(
                                Icons.keyboard_arrow_up,
                                color: Colors.white,
                                size: 32,
                              )),
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Text(
                              '${widget.dsix.getCurrentPlayer().currentHealth}',
                              style: TextStyle(
                                height: 1.25,
                                fontSize: 50,
                                fontFamily: 'Calibri',
                                color: Colors.white,
                              ),
                            ),
                          ),
                          GestureDetector(
                              onTap: () {
                                setState(() {
                                  if (widget.dsix
                                          .getCurrentPlayer()
                                          .currentHealth >
                                      0) {
                                    widget.dsix
                                        .getCurrentPlayer()
                                        .currentHealth -= 1;
                                  }
                                });
                                refreshPage();
                              },
                              child: Icon(
                                Icons.keyboard_arrow_down,
                                color: Colors.white,
                                size: 32,
                              )),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  showAlertDialogMoney(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              backgroundColor: Colors.black,
              contentPadding: EdgeInsets.fromLTRB(0, 0, 0, 0),
              content: Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    color:
                        widget.dsix.getCurrentPlayer().playerColor.primaryColor,
                    width: 1.5, //                   <--- border width here
                  ),
                ),
                width: 100,
                height: 250,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      color: widget.dsix
                          .getCurrentPlayer()
                          .playerColor
                          .primaryColor,
                      width: double.infinity,
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(0, 5, 0, 5),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              'MONEY',
                              style: TextStyle(
                                fontFamily: 'Headline',
                                height: 1.3,
                                fontSize: 30.0,
                                color: Colors.white,
                                letterSpacing: 3,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(35, 25, 35, 10),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          GestureDetector(
                              onTap: () {
                                setState(() {
                                  widget.dsix.getCurrentPlayer().gold += 100;
                                });
                                refreshPage();
                              },
                              child: Icon(
                                Icons.keyboard_arrow_up,
                                color: Colors.white,
                                size: 32,
                              )),
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Text(
                              '${widget.dsix.getCurrentPlayer().gold}',
                              style: TextStyle(
                                height: 1.25,
                                fontSize: 50,
                                fontFamily: 'Calibri',
                                color: Colors.white,
                              ),
                            ),
                          ),
                          GestureDetector(
                              onTap: () {
                                setState(() {
                                  if (widget.dsix.getCurrentPlayer().gold > 0) {
                                    widget.dsix.getCurrentPlayer().gold -= 100;
                                  }
                                });
                                refreshPage();
                              },
                              child: Icon(
                                Icons.keyboard_arrow_down,
                                color: Colors.white,
                                size: 32,
                              )),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  // showAlertDialogWeight(BuildContext context)
  // {
  //
  //   AlertDialog alerta = AlertDialog(
  //     backgroundColor: Colors.black,
  //     contentPadding: EdgeInsets.fromLTRB(0,0,0,0),
  //     content: Container(
  //       decoration: BoxDecoration(
  //         border: Border.all(
  //           color: widget.dsix.getCurrentPlayer().playerColor.primaryColor,
  //           width: 1.5, //                   <--- border width here
  //         ),
  //       ),
  //       width: 300,
  //       height: 200,
  //       child: Column(
  //         crossAxisAlignment: CrossAxisAlignment.stretch,
  //         mainAxisAlignment: MainAxisAlignment.start,
  //         children: <Widget>[
  //           Container(
  //             color: widget.dsix.getCurrentPlayer().playerColor.primaryColor,
  //             width: double.infinity,
  //             child: Padding(
  //               padding: const EdgeInsets.fromLTRB(30,10,30,10),
  //               child: Row(
  //                 mainAxisAlignment: MainAxisAlignment.start,
  //                 children: <Widget>[
  //                   Text('WEIGHT: ${widget.dsix.getCurrentPlayer().currentWeight}/${widget.dsix.getCurrentPlayer().maxWeight} ',
  //                     style: TextStyle(
  //                       fontFamily: 'Headline',
  //                       height: 1.3,
  //                       fontSize: 30.0,
  //                       color: Colors.white,
  //                       letterSpacing: 3,
  //                     ),
  //                   ),
  //
  //                 ],
  //               ),
  //
  //             ),
  //           ),
  //           Padding(
  //             padding: const EdgeInsets.fromLTRB(35,25,25,15),
  //             child: Text('This represents the maximum weight you can carry.',
  //               style: TextStyle(
  //                 height: 1.25,
  //                 fontSize: 22,
  //                 fontFamily: 'Calibri',
  //                 color: Colors.white,
  //               ),
  //             ),
  //
  //           ),
  //         ],
  //       ),
  //     ),
  //   );
  //
  //   showDialog(
  //     context: context,
  //     builder: (BuildContext context) {
  //       return alerta;
  //     },
  //   );
  // }

  refreshPage() {
    setState(() {});
  }

  int bottomSelectedIndex = 0;
  String pageTitle = 'CHARACTER';

  void pageChanged(int index) {
    setState(() {
      bottomSelectedIndex = index;
      switch (index) {
        case 0:
          {
            pageTitle = 'CHARACTER';
          }
          break;
        case 1:
          {
            pageTitle = 'SHOP';
          }
          break;
        case 2:
          {
            pageTitle = 'INVENTORY';
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
            pageTitle = 'CHARACTER';
          }
          break;
        case 1:
          {
            pageTitle = 'SHOP';
          }
          break;
        case 2:
          {
            pageTitle = 'INVENTORY';
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
          'assets/race/${widget.dsix.getCurrentPlayer().race.icon}.svg',
          color: widget.dsix.getCurrentPlayer().playerColor.tertiaryColor,
          width: MediaQuery.of(context).size.width * 0.1,
        ),
        icon: new SvgPicture.asset(
          'assets/race/${widget.dsix.getCurrentPlayer().race.icon}.svg',
          color: widget.dsix.getCurrentPlayer().playerColor.secondaryColor,
          width: MediaQuery.of(context).size.width * 0.1,
        ),
        label: '',
      ),
      BottomNavigationBarItem(
        activeIcon: new SvgPicture.asset(
          'assets/player/shop.svg',
          color: widget.dsix.getCurrentPlayer().playerColor.tertiaryColor,
          width: MediaQuery.of(context).size.width * 0.060,
        ),
        icon: new SvgPicture.asset(
          'assets/player/shop.svg',
          color: widget.dsix.getCurrentPlayer().playerColor.secondaryColor,
          width: MediaQuery.of(context).size.width * 0.060,
        ),
        label: 'SHOP',
      ),
      BottomNavigationBarItem(
        activeIcon: new SvgPicture.asset(
          'assets/player/inventory.svg',
          color: widget.dsix.getCurrentPlayer().playerColor.tertiaryColor,
          width: MediaQuery.of(context).size.width * 0.070,
        ),
        icon: new SvgPicture.asset(
          'assets/player/inventory.svg',
          color: widget.dsix.getCurrentPlayer().playerColor.secondaryColor,
          width: MediaQuery.of(context).size.width * 0.070,
        ),
        label: 'INVENTORY',
      ),
      BottomNavigationBarItem(
        activeIcon: new SvgPicture.asset(
          'assets/player/action.svg',
          color: widget.dsix.getCurrentPlayer().playerColor.tertiaryColor,
          width: MediaQuery.of(context).size.width * 0.075,
        ),
        icon: new SvgPicture.asset(
          'assets/player/action.svg',
          color: widget.dsix.getCurrentPlayer().playerColor.secondaryColor,
          width: MediaQuery.of(context).size.width * 0.065,
        ),
        label: '',
      ),
      BottomNavigationBarItem(
        activeIcon: new SvgPicture.asset(
          'assets/player/map.svg',
          color: widget.dsix.getCurrentPlayer().playerColor.tertiaryColor,
          width: MediaQuery.of(context).size.width * 0.1,
        ),
        icon: new SvgPicture.asset(
          'assets/player/map.svg',
          color: widget.dsix.getCurrentPlayer().playerColor.secondaryColor,
          width: MediaQuery.of(context).size.width * 0.1,
        ),
        label: '',
      ),
      BottomNavigationBarItem(
        activeIcon: new SvgPicture.asset(
          'assets/player/help.svg',
          color: widget.dsix.getCurrentPlayer().playerColor.tertiaryColor,
          width: MediaQuery.of(context).size.width * 0.085,
        ),
        icon: new SvgPicture.asset(
          'assets/player/help.svg',
          color: widget.dsix.getCurrentPlayer().playerColor.secondaryColor,
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
        CharacterPage(
          dsix: widget.dsix,
        ),
        ShopPage(dsix: widget.dsix, refresh: refreshPage),
        InventoryPage(
          dsix: widget.dsix,
          refresh: refreshPage,
        ),
        ActionPage(
          dsix: widget.dsix,
          refresh: refreshPage,
        ),
        HelpPage(
          dsix: widget.dsix,
        ),
        HelpPage(
          dsix: widget.dsix,
        ),
      ],
    );
  }

  Route _createRouteHome() {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => PlayersPage(
          //dsix: widget.dsix,
          ),
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
              Icons.home,
              color: Colors.white,
              size: 32,
            ),
            onPressed: () {
              Navigator.of(context).push(_createRouteHome());
            },
          ),
        ),
        titleSpacing: 10,
        backgroundColor:
            widget.dsix.getCurrentPlayer().playerColor.primaryColor,
        title: new Text(
          '$pageTitle',
          textAlign: TextAlign.left,
          style: TextStyle(
            fontFamily: 'Headline',
            height: 1.3,
            fontSize: 24.0,
            color: Colors.white,
            letterSpacing: 2,
          ),
        ),
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 0, 15, 0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                GestureDetector(
                  onTap: () {},
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(0, 0, 15, 0),
                    child: Row(
                      children: <Widget>[
                        SvgPicture.asset(
                          'assets/player/action.svg',
                          color: Colors.white,
                          width: MediaQuery.of(context).size.width * 0.05,
                        ),
                        Text(
                          ' ${widget.dsix.getCurrentPlayer().actionsTaken}',
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            fontFamily: 'Headline',
                            height: 1.1,
                            fontSize: 25,
                            color: Colors.white,
                            letterSpacing: 2,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    showAlertDialogHealth(context);
                  },
                  child: Row(
                    children: <Widget>[
                      SvgPicture.asset(
                        'assets/player/health.svg',
                        color: Colors.white,
                        width: MediaQuery.of(context).size.width * 0.08,
                      ),
                      Text(
                        '${widget.dsix.getCurrentPlayer().currentHealth}',
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          fontFamily: 'Headline',
                          height: 1.1,
                          fontSize: 25,
                          color: Colors.white,
                          letterSpacing: 2,
                        ),
                      ),
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    showAlertDialogMoney(context);
                  },
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(15, 0, 0, 0),
                    child: Row(
                      children: <Widget>[
                        SvgPicture.asset(
                          'assets/player/money.svg',
                          color: Colors.white,
                          width: MediaQuery.of(context).size.width * 0.055,
                        ),
                        Text(
                          '${widget.dsix.getCurrentPlayer().gold}',
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            fontFamily: 'Headline',
                            height: 1.1,
                            fontSize: 25,
                            color: Colors.white,
                            letterSpacing: 2,
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
        child: buildPageView(),
      ),
      bottomNavigationBar: BottomNavigationBar(
        selectedLabelStyle: TextStyle(
          color: widget.dsix.getCurrentPlayer().playerColor.secondaryColor,
        ),
        unselectedLabelStyle: TextStyle(
          color: widget.dsix.getCurrentPlayer().playerColor.secondaryColor,
        ),
        type: BottomNavigationBarType.fixed,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        backgroundColor:
            widget.dsix.getCurrentPlayer().playerColor.primaryColor,
        currentIndex: bottomSelectedIndex,
        onTap: (index) {
          bottomTapped(index);
        },
        items: buildBottomNavBarItems(),
      ),
    );
  }
}
