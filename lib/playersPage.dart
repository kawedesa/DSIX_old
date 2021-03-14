import 'package:dsixv02app/main.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'playerRacePage.dart';
import 'gmPage.dart';
import 'playerUI.dart';
import 'package:dsixv02app/models/game/game.dart';

class PlayersPage extends StatefulWidget {
  final Dsix dsix;

  const PlayersPage({Key key, this.dsix}) : super(key: key);

  static const String routeName = "/playersPage";

  @override
  _PlayersPageState createState() => new _PlayersPageState();
}

class _PlayersPageState extends State<PlayersPage> {
  Route _createRouteMain() {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => MainPage(),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        var begin = Offset(0.0, -1.0);
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

  Route _createRouteRace() {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => PlayerRacePage(
        dsix: widget.dsix,
      ),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        var begin = Offset(1.0, 0.0);
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

  // Route _createRouteUI() {
  //   return PageRouteBuilder(
  //     pageBuilder: (context, animation, secondaryAnimation) => PlayerUI(
  //       dsix: widget.dsix,
  //     ),
  //     transitionsBuilder: (context, animation, secondaryAnimation, child) {
  //       var begin = Offset(1, 0);
  //       var end = Offset(0.0, 0.0);
  //       var curve = Curves.ease;
  //       var tween =
  //           Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

  //       return SlideTransition(
  //         position: animation.drive(tween),
  //         child: child,
  //       );
  //     },
  //   );
  // }

  void navigation() {
    if (widget.dsix.getCurrentPlayer().name != '') {
      // Navigator.of(context).push(_createRouteUI());
    } else {
      Navigator.of(context).push(_createRouteRace());
    }
  }

  void initState() {
    super.initState();
  }

  Widget build(BuildContext context) {
    return new Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        titleSpacing: 0,
        backgroundColor: Colors.grey[800],
        centerTitle: true,
        title: new Text(
          'Choose your player',
          textAlign: TextAlign.left,
          style: TextStyle(
            fontFamily: 'Headline',
            height: 1.1,
            fontSize: 25.0,
            color: Colors.black,
            letterSpacing: 2,
          ),
        ),
      ),
      body: new SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(0, 55, 0, 0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Container(
                width: MediaQuery.of(context).size.width * 1,
                height: MediaQuery.of(context).size.height * 0.7,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      height: 400,
                      child: ListView.builder(
                        padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                        itemCount: widget.dsix.players.length,
                        itemBuilder: (BuildContext context, int index) {
                          return TextButton(
                            onPressed: () {
                              widget.dsix.setCurrentPlayer(index);

                              navigation();
                            },
                            style: TextButton.styleFrom(
                              padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                            ),
                            child: Stack(
                              children: <Widget>[
                                Container(
                                  height:
                                      MediaQuery.of(context).size.height * 0.1,
                                  width:
                                      MediaQuery.of(context).size.width * 0.62,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: <Widget>[
                                      Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                            0, 0, 20, 0),
                                        child: Icon(
                                          Icons.keyboard_arrow_right,
                                          color: widget.dsix.players[index]
                                              .playerColor.primaryColor,
                                          size: 40,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  height:
                                      MediaQuery.of(context).size.height * 0.1,
                                  width:
                                      MediaQuery.of(context).size.width * 0.62,
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: widget.dsix.players[index]
                                          .playerColor.primaryColor,
                                      width:
                                          2.5, //                   <--- border width here
                                    ),
                                  ),
                                  child: Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(0, 8, 0, 8),
                                    child: Center(
                                      child: Text(
                                        '${widget.dsix.players[index].playerColor.name}',
                                        style: TextStyle(
                                          fontSize: 17,
                                          fontWeight: FontWeight.bold,
                                          letterSpacing: 1.5,
                                          fontFamily: 'Calibri',
                                          color: widget.dsix.players[index]
                                              .playerColor.primaryColor,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),

                    TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          new MaterialPageRoute(
                            builder: (context) => new GmPage(),
                          ),
                        );
                      },
                      style: TextButton.styleFrom(
                        padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                      ),
                      child: Stack(
                        children: <Widget>[
                          Container(
                            height: MediaQuery.of(context).size.height * 0.1,
                            width: MediaQuery.of(context).size.width * 0.62,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: <Widget>[
                                Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(0, 0, 20, 0),
                                  child: Icon(
                                    Icons.keyboard_arrow_right,
                                    color: Colors.grey[800],
                                    size: 40,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            height: MediaQuery.of(context).size.height * 0.1,
                            width: MediaQuery.of(context).size.width * 0.62,
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Colors.grey[800],
                                width:
                                    2.5, //                   <--- border width here
                              ),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(0, 8, 0, 8),
                              child: Center(
                                child: Text(
                                  'GM',
                                  style: TextStyle(
                                    fontSize: 17,
                                    fontWeight: FontWeight.bold,
                                    letterSpacing: 1.5,
                                    fontFamily: 'Calibri',
                                    color: Colors.grey[800],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ), //   GM GREY
                  ],
                ),
              ),
              IconButton(
                onPressed: () {
                  Navigator.of(context).push(_createRouteMain());
                },
                padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                icon: Icon(
                  Icons.keyboard_arrow_down,
                  color: Colors.white,
                  size: 40,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
//Navigator.of(context).push(_createRoute());
