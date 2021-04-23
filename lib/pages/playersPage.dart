// import 'package:dsixv02app/main.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'playerRacePage.dart';
import 'gmUI.dart';

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
  void checkPlayer() {
    if (widget.dsix.getCurrentPlayer().characterFinished == false) {
      Navigator.of(context).push(_createRouteRace());
    } else {
      Navigator.of(context).push(_createRoutePlayerUI());
    }
  }

//ROUTES

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

  // Route _createRouteMainPage() {
  //   return PageRouteBuilder(
  //     pageBuilder: (context, animation, secondaryAnimation) => MainPage(),
  //     transitionsBuilder: (context, animation, secondaryAnimation, child) {
  //       var begin = Offset(-1, 0);
  //       var end = Offset(0, 0);
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

  Route _createRoutePlayerUI() {
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

  Route _createRouteGmUI() {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => GmUI(
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

  showAlertDialogDeletePlayer(BuildContext context, int index) {
    AlertDialog alerta = AlertDialog(
      backgroundColor: Colors.black,
      contentPadding: EdgeInsets.fromLTRB(0, 0, 0, 0),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            decoration: BoxDecoration(
              border: Border.all(
                color: widget.dsix.getCurrentPlayer().playerColor.primaryColor,
                width: 2.5, //                   <--- border width here
              ),
            ),
            width: 300,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Container(
                  color:
                      widget.dsix.getCurrentPlayer().playerColor.primaryColor,
                  width: double.infinity,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(0, 5, 0, 5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          'DELETE PLAYER',
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
                ), //ITEM NAME

                Container(
                  width: double.infinity,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(35, 15, 35, 20),
                    child: Text(
                      'This player will be deleted! Are you sure you want to continue?',
                      textAlign: TextAlign.justify,
                      style: TextStyle(
                        height: 1.25,
                        fontSize: 19,
                        fontFamily: 'Calibri',
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
                  child: TextButton(
                    onPressed: () {
                      setState(() {
                        widget.dsix.deleteCurrentPlayer(index);
                        Navigator.of(context).pop(true);
                      });
                    },
                    style: TextButton.styleFrom(
                      padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
                    ),
                    child: Container(
                      height: MediaQuery.of(context).size.height * 0.058,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: widget.dsix
                              .getCurrentPlayer()
                              .playerColor
                              .primaryColor,
                          width: 2, //                   <--- border width here
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
                                padding: const EdgeInsets.fromLTRB(0, 0, 10, 0),
                                child: Icon(
                                  Icons.check,
                                  color: widget.dsix
                                      .getCurrentPlayer()
                                      .playerColor
                                      .primaryColor,
                                  size: 20,
                                ),
                              ),
                            ],
                          ),
                          Center(
                            child: Text(
                              'CONFIRM',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 1.5,
                                fontFamily: 'Calibri',
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(30, 0, 30, 15),
                  child: TextButton(
                    onPressed: () {
                      Navigator.of(context).pop(true);
                    },
                    style: TextButton.styleFrom(
                      padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
                    ),
                    child: Container(
                      height: MediaQuery.of(context).size.height * 0.058,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: widget.dsix
                              .getCurrentPlayer()
                              .playerColor
                              .primaryColor,
                          width: 2, //                   <--- border width here
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
                                padding: const EdgeInsets.fromLTRB(0, 0, 10, 0),
                                child: Icon(
                                  Icons.clear,
                                  color: widget.dsix
                                      .getCurrentPlayer()
                                      .playerColor
                                      .primaryColor,
                                  size: 20,
                                ),
                              ),
                            ],
                          ),
                          Center(
                            child: Text(
                              'CANCEL',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 1.5,
                                fontFamily: 'Calibri',
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
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

  Widget build(BuildContext context) {
    return new Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        // leading: IconButton(
        //     icon: Icon(
        //       Icons.keyboard_arrow_left,
        //       color: Colors.grey[600],
        //       size: 40,
        //     ),
        //     onPressed: () {
        //       Navigator.of(context).push(_createRouteMainPage());
        //     }),
        automaticallyImplyLeading: false,
        titleSpacing: 0,
        backgroundColor: Colors.grey[900],
        centerTitle: true,
        title: new Text(
          'Choose your Player',
          textAlign: TextAlign.left,
          style: TextStyle(
            fontFamily: 'Headline',
            height: 1.1,
            fontSize: 25.0,
            color: Colors.grey[600],
            letterSpacing: 2,
          ),
        ),
      ),
      body: new SafeArea(
        child: Center(
          child: Container(
            width: MediaQuery.of(context).size.width * 0.62,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ListView.builder(
                  shrinkWrap: true,
                  padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                  itemCount: widget.dsix.players.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Padding(
                      padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
                      child: GestureDetector(
                        onLongPress: () {
                          setState(() {
                            widget.dsix.setCurrentPlayer(index);
                            showAlertDialogDeletePlayer(context, index);
                          });
                        },
                        onTap: () {
                          widget.dsix.setCurrentPlayer(index);
                          checkPlayer();
                        },
                        child: Container(
                          height: MediaQuery.of(context).size.height * 0.08,
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
                                    padding:
                                        const EdgeInsets.fromLTRB(0, 0, 15, 0),
                                    child: Icon(
                                      Icons.keyboard_arrow_right,
                                      color: widget.dsix.players[index]
                                          .playerColor.primaryColor,
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
                                      color: widget.dsix.players[index]
                                          .playerColor.primaryColor,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(_createRouteGmUI());
                  },
                  child: Container(
                    height: MediaQuery.of(context).size.height * 0.08,
                    width: MediaQuery.of(context).size.width * 0.62,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.grey[600],
                        width: 2.5, //                   <--- border width here
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
                                color: Colors.grey[600],
                                size: 30,
                              ),
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(0, 8, 0, 8),
                          child: Center(
                            child: Text(
                              'GM',
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 1.5,
                                fontFamily: 'Calibri',
                                color: Colors.grey[600],
                              ),
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
        ),
      ),
    );
  }
}
