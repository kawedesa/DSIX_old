import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'playersPage.dart';
import 'playerInventoryPage.dart';
import 'playerCharacterPage.dart';
import 'playerShopPage.dart';
import 'playerActionPage.dart';
import 'playerHelpPage.dart';
import 'package:dsixv02app/models/game/dsix.dart';
import 'package:dsixv02app/models/shared/exceptions.dart';

class PlayerUI extends StatefulWidget {
  final Dsix dsix;

  const PlayerUI({Key key, this.dsix}) : super(key: key);

  static const String routeName = "/playerUI";

  @override
  _PlayerUIState createState() => new _PlayerUIState();
}

class _PlayerUIState extends State<PlayerUI> {
  void newTurn() {
    try {
      widget.dsix.gm.newTurn();
    } on NewTurnException catch (e) {
      refresh();
      ScaffoldMessenger.of(context).showSnackBar(displayAlert(e.message));
      return;
    }
  }

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
                    color: widget.dsix.gm
                        .getCurrentPlayer()
                        .playerColor
                        .primaryColor,
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
                      color: widget.dsix.gm
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
                                  if (widget.dsix.gm
                                          .getCurrentPlayer()
                                          .currentHealth <
                                      widget.dsix.gm
                                          .getCurrentPlayer()
                                          .race
                                          .maxHealth) {
                                    widget.dsix.gm
                                        .getCurrentPlayer()
                                        .currentHealth += 1;
                                  }
                                });
                                refresh();
                              },
                              child: Icon(
                                Icons.keyboard_arrow_up,
                                color: Colors.white,
                                size: 32,
                              )),
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Text(
                              '${widget.dsix.gm.getCurrentPlayer().currentHealth}',
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
                                  if (widget.dsix.gm
                                          .getCurrentPlayer()
                                          .currentHealth >
                                      0) {
                                    widget.dsix.gm
                                        .getCurrentPlayer()
                                        .currentHealth -= 1;
                                  }
                                });
                                refresh();
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

  showAlertDialogWeight(BuildContext context) {
    AlertDialog alerta = AlertDialog(
      backgroundColor: Colors.black,
      contentPadding: EdgeInsets.fromLTRB(0, 0, 0, 0),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            decoration: BoxDecoration(
              border: Border.all(
                color:
                    widget.dsix.gm.getCurrentPlayer().playerColor.primaryColor,
                width: 1.5, //                   <--- border width here
              ),
            ),
            width: 300,
            // height: 200,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Container(
                  color: widget.dsix.gm
                      .getCurrentPlayer()
                      .playerColor
                      .primaryColor,
                  width: double.infinity,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(30, 10, 30, 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          'WEIGHT: ${widget.dsix.gm.getCurrentPlayer().currentWeight}/${widget.dsix.gm.getCurrentPlayer().race.maxWeight} ',
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
                  padding: const EdgeInsets.fromLTRB(35, 15, 25, 20),
                  child: Text(
                    'This represents the maximum weight you can carry.',
                    style: TextStyle(
                      height: 1.25,
                      fontSize: 19,
                      fontFamily: 'Calibri',
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alerta;
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
                    color: widget.dsix.gm
                        .getCurrentPlayer()
                        .playerColor
                        .primaryColor,
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
                      color: widget.dsix.gm
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
                              onLongPress: () {
                                setState(() {
                                  widget.dsix.gm.getCurrentPlayer().gold += 500;
                                });
                                refresh();
                              },
                              onTap: () {
                                setState(() {
                                  widget.dsix.gm.getCurrentPlayer().gold += 50;
                                });
                                refresh();
                              },
                              child: Icon(
                                Icons.keyboard_arrow_up,
                                color: Colors.white,
                                size: 32,
                              )),
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Text(
                              '${widget.dsix.gm.getCurrentPlayer().gold}',
                              style: TextStyle(
                                height: 1.25,
                                fontSize: 50,
                                fontFamily: 'Calibri',
                                color: Colors.white,
                              ),
                            ),
                          ),
                          GestureDetector(
                              onLongPress: () {
                                setState(() {
                                  widget.dsix.gm.getCurrentPlayer().gold -= 500;
                                });
                                refresh();
                              },
                              onTap: () {
                                setState(() {
                                  if (widget.dsix.gm.getCurrentPlayer().gold >
                                      0) {
                                    widget.dsix.gm.getCurrentPlayer().gold -=
                                        50;
                                  }
                                });
                                refresh();
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

  String alertTitle;
  String alertDescription;

  showAlertDialogAlert(
    BuildContext context,
  ) {
    AlertDialog alerta = AlertDialog(
      backgroundColor: Colors.black,
      contentPadding: EdgeInsets.fromLTRB(0, 0, 0, 0),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            decoration: BoxDecoration(
              border: Border.all(
                color:
                    widget.dsix.gm.getCurrentPlayer().playerColor.primaryColor,
                width: 1.5, //                   <--- border width here
              ),
            ),
            width: 300,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Container(
                  color: widget.dsix.gm
                      .getCurrentPlayer()
                      .playerColor
                      .primaryColor,
                  width: double.infinity,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(30, 5, 30, 7),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          alertTitle,
                          style: TextStyle(
                            fontFamily: 'Headline',
                            height: 1.3,
                            fontSize: 25.0,
                            color: Colors.white,
                            letterSpacing: 2,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(35, 15, 25, 20),
                  child: Text(
                    alertDescription,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      height: 1.25,
                      fontSize: 19,
                      fontFamily: 'Calibri',
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alerta;
      },
    );
  }

  refresh() {
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
          'assets/player/race/${widget.dsix.gm.getCurrentPlayer().race.icon}.svg',
          color: widget.dsix.gm.getCurrentPlayer().playerColor.secondaryColor,
          width: MediaQuery.of(context).size.width * 0.1,
        ),
        icon: new SvgPicture.asset(
          'assets/player/race/${widget.dsix.gm.getCurrentPlayer().race.icon}.svg',
          color: widget.dsix.gm.getCurrentPlayer().playerColor.tertiaryColor,
          width: MediaQuery.of(context).size.width * 0.1,
        ),
        label: '',
      ),
      BottomNavigationBarItem(
        activeIcon: new SvgPicture.asset(
          'assets/player/shop.svg',
          color: widget.dsix.gm.getCurrentPlayer().playerColor.secondaryColor,
          width: MediaQuery.of(context).size.width * 0.060,
        ),
        icon: new SvgPicture.asset(
          'assets/player/shop.svg',
          color: widget.dsix.gm.getCurrentPlayer().playerColor.tertiaryColor,
          width: MediaQuery.of(context).size.width * 0.060,
        ),
        label: 'SHOP',
      ),
      BottomNavigationBarItem(
        activeIcon: new SvgPicture.asset(
          'assets/player/inventory.svg',
          color: widget.dsix.gm.getCurrentPlayer().playerColor.secondaryColor,
          width: MediaQuery.of(context).size.width * 0.070,
        ),
        icon: new SvgPicture.asset(
          'assets/player/inventory.svg',
          color: widget.dsix.gm.getCurrentPlayer().playerColor.tertiaryColor,
          width: MediaQuery.of(context).size.width * 0.070,
        ),
        label: 'INVENTORY',
      ),
      BottomNavigationBarItem(
        activeIcon: new SvgPicture.asset(
          'assets/player/action.svg',
          color: widget.dsix.gm.getCurrentPlayer().playerColor.secondaryColor,
          width: MediaQuery.of(context).size.width * 0.075,
        ),
        icon: new SvgPicture.asset(
          'assets/player/action.svg',
          color: widget.dsix.gm.getCurrentPlayer().playerColor.tertiaryColor,
          width: MediaQuery.of(context).size.width * 0.065,
        ),
        label: '',
      ),
      BottomNavigationBarItem(
        activeIcon: new SvgPicture.asset(
          'assets/player/map.svg',
          color: widget.dsix.gm.getCurrentPlayer().playerColor.secondaryColor,
          width: MediaQuery.of(context).size.width * 0.1,
        ),
        icon: new SvgPicture.asset(
          'assets/player/map.svg',
          color: widget.dsix.gm.getCurrentPlayer().playerColor.tertiaryColor,
          width: MediaQuery.of(context).size.width * 0.1,
        ),
        label: '',
      ),
      BottomNavigationBarItem(
        activeIcon: new SvgPicture.asset(
          'assets/player/help.svg',
          color: widget.dsix.gm.getCurrentPlayer().playerColor.secondaryColor,
          width: MediaQuery.of(context).size.width * 0.085,
        ),
        icon: new SvgPicture.asset(
          'assets/player/help.svg',
          color: widget.dsix.gm.getCurrentPlayer().playerColor.tertiaryColor,
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
        ShopPage(
          dsix: widget.dsix,
          refresh: refresh,
          alert: displayAlert,
        ),
        InventoryPage(
          dsix: widget.dsix,
          refresh: refresh,
          alert: displayAlert,
        ),
        ActionPage(
          dsix: widget.dsix,
          refresh: refresh,
          alert: displayAlert,
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

  SnackBar displayAlert(String description) {
    SnackBar newAlert = new SnackBar(
      backgroundColor:
          widget.dsix.gm.getCurrentPlayer().playerColor.primaryColor,
      content: Container(
        height: MediaQuery.of(context).size.height * 0.05,
        child: Text(
          description,
          textAlign: TextAlign.center,
          style: TextStyle(
            height: 1.25,
            fontSize: 22,
            fontFamily: 'Calibri',
            color: Colors.white,
          ),
        ),
      ),
    );
    return newAlert;
  }

  @override
  void initState() {
    super.initState();
  }

  Widget build(BuildContext context) {
    List<bool> turn = widget.dsix.gm.getCurrentPlayer().turn;

    return new Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.fromLTRB(5, 2, 0, 0),
          child: IconButton(
            icon: Icon(
              Icons.exit_to_app,
              color: Colors.white,
              size: 30,
            ),
            onPressed: () {
              Navigator.of(context).push(_createRouteHome());
            },
          ),
        ),
        titleSpacing: 10,
        backgroundColor:
            widget.dsix.gm.getCurrentPlayer().playerColor.primaryColor,
        // title: new Text(
        //   '$pageTitle',
        //   textAlign: TextAlign.left,
        //   style: TextStyle(
        //     fontFamily: 'Headline',
        //     height: 1.3,
        //     fontSize: 24.0,
        //     color: widget.dsix.gm.getCurrentPlayer().playerColor.secondaryColor,
        //     letterSpacing: 2,
        //   ),
        // ),
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 0, 15, 0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 0, 2.5, 0),
                  child: GestureDetector(
                    onLongPress: () {
                      newTurn();
                    },
                    onTap: () {
                      widget.dsix.gm.getCurrentPlayer().changeTurn(0);
                      turn = widget.dsix.gm.getCurrentPlayer().turn;
                      refresh();
                    },
                    child: SvgPicture.asset(
                      'assets/player/action.svg',
                      color: turn[0]
                          ? widget.dsix.gm
                              .getCurrentPlayer()
                              .playerColor
                              .tertiaryColor
                          : Colors.white,
                      width: MediaQuery.of(context).size.width * 0.05,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(2.5, 0, 15, 0),
                  child: GestureDetector(
                    onLongPress: () {
                      newTurn();
                    },
                    onTap: () {
                      widget.dsix.gm.getCurrentPlayer().changeTurn(1);
                      turn = widget.dsix.gm.getCurrentPlayer().turn;
                      refresh();
                    },
                    child: SvgPicture.asset(
                      'assets/player/action.svg',
                      color: turn[1]
                          ? widget.dsix.gm
                              .getCurrentPlayer()
                              .playerColor
                              .tertiaryColor
                          : Colors.white,
                      width: MediaQuery.of(context).size.width * 0.05,
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
                        '${widget.dsix.gm.getCurrentPlayer().currentHealth}',
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          fontFamily: 'Headline',
                          height: 1.1,
                          fontSize: 25,
                          color: widget.dsix.gm
                              .getCurrentPlayer()
                              .playerColor
                              .secondaryColor,
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
                          '${widget.dsix.gm.getCurrentPlayer().gold}',
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            fontFamily: 'Headline',
                            height: 1.1,
                            fontSize: 25,
                            color: widget.dsix.gm
                                .getCurrentPlayer()
                                .playerColor
                                .secondaryColor,
                            letterSpacing: 2,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    showAlertDialogWeight(context);
                  },
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(15, 0, 0, 0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        SvgPicture.asset(
                          'assets/item/weight.svg',
                          color: Colors.white,
                          width: MediaQuery.of(context).size.width * 0.055,
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(7, 1, 0, 5),
                          child: Text(
                            '${widget.dsix.gm.getCurrentPlayer().currentWeight}',
                            textAlign: TextAlign.left,
                            style: TextStyle(
                              fontFamily: 'Headline',
                              height: 1.1,
                              fontSize: 20.0,
                              color: widget.dsix.gm
                                  .getCurrentPlayer()
                                  .playerColor
                                  .secondaryColor,
                              letterSpacing: 2,
                            ),
                          ),
                        ),
                        Text(
                          '/',
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            fontFamily: 'Headline',
                            height: 1.1,
                            fontSize: 23.0,
                            fontWeight: FontWeight.bold,
                            color: widget.dsix.gm
                                .getCurrentPlayer()
                                .playerColor
                                .secondaryColor,
                            letterSpacing: 2,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(1, 6, 5, 0),
                          child: Text(
                            '${widget.dsix.gm.getCurrentPlayer().race.maxWeight}',
                            textAlign: TextAlign.left,
                            style: TextStyle(
                              fontFamily: 'Headline',
                              height: 1.1,
                              fontSize: 20.0,
                              color: widget.dsix.gm
                                  .getCurrentPlayer()
                                  .playerColor
                                  .secondaryColor,
                              letterSpacing: 2,
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
        child: buildPageView(),
      ),
      bottomNavigationBar: BottomNavigationBar(
        selectedLabelStyle: TextStyle(
          color: widget.dsix.gm.getCurrentPlayer().playerColor.secondaryColor,
        ),
        unselectedLabelStyle: TextStyle(
          color: widget.dsix.gm.getCurrentPlayer().playerColor.secondaryColor,
        ),
        type: BottomNavigationBarType.fixed,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        backgroundColor:
            widget.dsix.gm.getCurrentPlayer().playerColor.primaryColor,
        currentIndex: bottomSelectedIndex,
        onTap: (index) {
          bottomTapped(index);
        },
        items: buildBottomNavBarItems(),
      ),
    );
  }
}
