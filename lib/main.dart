import 'package:flutter/material.dart';
import 'models/layout/playersPage.dart';
import 'models/player/player.dart';
import 'models/game/dsix.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:firebase_core/firebase_core.dart';

void main() {
  runApp(DsixApp());
}

class DsixApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MainPage(),
    );
  }
}

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();

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

    return FutureBuilder(
      // Initialize FlutterFire:
      future: _initialization,
      builder: (context, snapshot) {
        // Check for errors
        if (snapshot.hasError) {
          return Container(
            child: Text('ERROR'),
          );
        }

        // Once complete, show your application
        if (snapshot.connectionState == ConnectionState.done) {
          return Scaffold(
            backgroundColor: Colors.black,
            body: SafeArea(
              child: Container(
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
                    TextButton(
                      style: TextButton.styleFrom(
                        padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                      ),
                      onPressed: () {
                        Navigator.of(context).push(_createRoute());
                      },
                      child: Container(
                        height: MediaQuery.of(context).size.height * 0.08,
                        width: MediaQuery.of(context).size.width * 0.62,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.grey[600],
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
                  ],
                ),
              ),
            ),
          );
        }

        // Otherwise, show something whilst waiting for initialization to complete
        return Container(
          child: Text('WAITING'),
        );
      },
    );
  }
}
