import 'package:dsixv02app/main.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'playerRacePage.dart';
import 'gmPage.dart';
import 'playerUI.dart';
import 'package:dsixv02app/models/game/dsix.dart';

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

  void checkPlayer() {
    if (widget.dsix.getCurrentPlayer().characterFinished == false) {
      Navigator.of(context).push(_createRouteRace());
    } else {
      Navigator.of(context).push(_createRouteUI());
    }
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

  Route _createRouteUI() {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => PlayerUI(
        dsix: widget.dsix,
      ),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        var begin = Offset(1, 0);
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

  void initState() {
    super.initState();
  }

  Widget build(BuildContext context) {
    return new Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            Icons.keyboard_arrow_left,
            color: Colors.grey[500],
            size: 40,
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
        automaticallyImplyLeading: false,
        titleSpacing: 0,
        backgroundColor: Colors.grey[800],
        centerTitle: true,
        title: new Text(
          'Players',
          textAlign: TextAlign.left,
          style: TextStyle(
            fontFamily: 'Headline',
            height: 1.1,
            fontSize: 25.0,
            color: Colors.grey[500],
            letterSpacing: 2,
          ),
        ),
      ),
      body: new SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 0, 35),
                child: Text(
                  'Choose your player:',
                  textAlign: TextAlign.justify,
                  style: TextStyle(
                    height: 1.3,
                    fontSize: 18,
                    fontFamily: 'Calibri',
                    color: Colors.white,
                  ),
                ),
              ),
              ListView.builder(
                shrinkWrap: true,
                padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                itemCount: widget.dsix.players.length,
                itemBuilder: (BuildContext context, int index) {
                  return TextButton(
                    onPressed: () {
                      widget.dsix.setCurrentPlayer(index);
                      checkPlayer();
                    },
                    style: TextButton.styleFrom(
                      padding: const EdgeInsets.fromLTRB(0, 0, 0, 15),
                    ),

                    child: Container(
                      height: MediaQuery.of(context).size.height * 0.08,
                      width: MediaQuery.of(context).size.width * 0.62,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: widget
                              .dsix.players[index].playerColor.primaryColor,
                          width:
                              2.5, //                   <--- border width here
                        ),
                      ),
                      child: Stack(
                        alignment: AlignmentDirectional.centerEnd,
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.fromLTRB(0, 0, 15, 0),
                                child: Icon(
                                  Icons.keyboard_arrow_right,
                                  color: widget.dsix.players[index].playerColor
                                      .primaryColor,
                                  size: 30,
                                ),
                              ),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(0, 8, 0, 8),
                            child: Center(
                              child: Text(
                                '${widget.dsix.players[index].playerColor.name}',
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 1.5,
                                  fontFamily: 'Calibri',
                                  color: widget.dsix.players[index].playerColor
                                      .primaryColor,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    // child: Stack(
                    //   children: <Widget>[
                    //     Container(
                    //       height:
                    //           MediaQuery.of(context).size.height * 0.1,
                    //       width:
                    //           MediaQuery.of(context).size.width * 0.62,
                    //       child: Column(
                    //         mainAxisAlignment: MainAxisAlignment.center,
                    //         crossAxisAlignment: CrossAxisAlignment.end,
                    //         children: <Widget>[
                    //           Padding(
                    //             padding: const EdgeInsets.fromLTRB(
                    //                 0, 0, 20, 0),
                    //             child: Icon(
                    //               Icons.keyboard_arrow_right,
                    //               color: widget.dsix.players[index]
                    //                   .playerColor.primaryColor,
                    //               size: 40,
                    //             ),
                    //           ),
                    //         ],
                    //       ),
                    //     ),
                    //     Container(
                    //       height:
                    //           MediaQuery.of(context).size.height * 0.1,
                    //       width:
                    //           MediaQuery.of(context).size.width * 0.62,
                    //       decoration: BoxDecoration(
                    //         border: Border.all(
                    //           color: widget.dsix.players[index]
                    //               .playerColor.primaryColor,
                    //           width:
                    //               2.5, //                   <--- border width here
                    //         ),
                    //       ),
                    //       child: Padding(
                    //         padding:
                    //             const EdgeInsets.fromLTRB(0, 8, 0, 8),
                    //         child: Center(
                    //           child: Text(
                    //             '${widget.dsix.players[index].playerColor.name}',
                    //             style: TextStyle(
                    //               fontSize: 17,
                    //               fontWeight: FontWeight.bold,
                    //               letterSpacing: 1.5,
                    //               fontFamily: 'Calibri',
                    //               color: widget.dsix.players[index]
                    //                   .playerColor.primaryColor,
                    //             ),
                    //           ),
                    //         ),
                    //       ),
                    //     ),
                    //   ],
                    // ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
