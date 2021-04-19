import 'package:dsixv02app/models/service/auth.dart';
import 'package:flutter/material.dart';
import 'playersPage.dart';
import 'package:dsixv02app/models/player/player.dart';
import 'package:dsixv02app/models/game/dsix.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:firebase_core/firebase_core.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final AuthService _auth = AuthService();
  List<Player> players;
  Dsix dsix = new Dsix();

  Route _createRoute() {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) =>
          PlayersPage(dsix: dsix),
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

  @override
  Widget build(BuildContext context) {
    List<PlayerColor> playerColors = [
      PlayerColor(
          name: 'PINK',
          primaryColor: Colors.pinkAccent,
          secondaryColor: Colors.pink[100],
          tertiaryColor: Colors.pink[800]),
      PlayerColor(
          name: 'BLUE',
          primaryColor: Colors.indigoAccent,
          secondaryColor: Colors.indigo[100],
          tertiaryColor: Colors.indigo[800]),
      PlayerColor(
          name: 'GREEN',
          primaryColor: Colors.teal,
          secondaryColor: Colors.teal[100],
          tertiaryColor: Colors.teal[800]),
      PlayerColor(
          name: 'YELLOW',
          primaryColor: Colors.orange,
          secondaryColor: Colors.orange[100],
          tertiaryColor: Colors.orange[800]),
      PlayerColor(
          name: 'PURPLE',
          primaryColor: Colors.purple,
          secondaryColor: Colors.purple[100],
          tertiaryColor: Colors.purple[800]),
    ];

    if (dsix.players.isEmpty == true) {
      for (PlayerColor playerColor in playerColors) {
        dsix.players.add(new Player(playerColor));
      }
    }

    return Container(
      width: double.infinity,
      height: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 0, 0, 50),
            child: Container(
              width: MediaQuery.of(context).size.width * 0.6,
              height: MediaQuery.of(context).size.width * 0.6,
              child: SvgPicture.asset(
                'assets/logo/logo.svg',
                color: Colors.grey[500],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 0, 0, 15),
            child: TextButton(
              style: TextButton.styleFrom(
                padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
              ),
              onPressed: () async {
                Navigator.of(context).push(_createRoute());
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
                          'PLAY',
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
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
            child: TextButton(
              style: TextButton.styleFrom(
                padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
              ),
              onPressed: () async {
                await _auth.signOut();
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
                          'SIGN OUT',
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
          ),
        ],
      ),
    );
  }
}
