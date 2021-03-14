import 'package:flutter/material.dart';
import 'playersPage.dart';
import 'models/player/player.dart';
import 'models/game/game.dart';

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
  List<Player> players;
  Dsix dsix = new Dsix();

  Route _createRoute() {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) =>
          PlayersPage(dsix: dsix),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        var begin = Offset(0.0, 1.0);
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
          'PINK', Colors.pinkAccent, Colors.pink[800], Colors.pink[100]),
      PlayerColor(
          'BLUE', Colors.indigoAccent, Colors.indigo[800], Colors.indigo[100]),
      PlayerColor('GREEN', Colors.teal, Colors.teal[800], Colors.teal[100]),
      PlayerColor(
          'YELLOW', Colors.orange, Colors.orange[800], Colors.orange[100]),
      PlayerColor(
          'PURPLE', Colors.purple, Colors.purple[800], Colors.purple[100]),
    ];

    for (PlayerColor playerColor in playerColors) {
      dsix.players.add(new Player(playerColor));
    }

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
                padding: const EdgeInsets.fromLTRB(0, 0, 0, 30),
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.66,
                  height: MediaQuery.of(context).size.width * 0.66,
                  child: Image(
                    image: AssetImage('images/dice/logo.png'),
                  ),
                ),
              ),
              TextButton(
                style: TextButton.styleFrom(
                  padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                ),
                onPressed: () {
                  Navigator.of(context).push(_createRoute());

//                  Navigator.push(
//                    context,
//                    new MaterialPageRoute(
//                      builder: (context) => new PlayersPage(
//                        player: player,
//                      ),
//                    ),
//                  );
                },
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.white,
                      width: 2.5, //                   <--- border width here
                    ),
                  ),
                  width: MediaQuery.of(context).size.width * 0.62,
                  height: MediaQuery.of(context).size.height * 0.1,
                  child: Center(
                    child: Text(
                      'PLAY',
                      style: TextStyle(
                        fontFamily: 'Headline',
                        color: Colors.white,
                        height: 1,
                        fontSize: 25,
                        letterSpacing: 3,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
