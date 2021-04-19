import 'package:dsixv02app/models/dsixUser.dart';
import 'package:dsixv02app/models/service/auth.dart';
import 'package:flutter/material.dart';
import 'pages/playersPage.dart';
import 'models/player/player.dart';
import 'models/game/dsix.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:dsixv02app/pages/wrapperPage.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(DsixApp());
}

class DsixApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.black,
        body: SafeArea(
          child: StreamProvider<DsixUser>.value(
            initialData: null,
            value: AuthService().user,
            child: FutureBuilder(
              // Initialize FlutterFire:
              future: Firebase.initializeApp(),
              builder: (context, snapshot) {
                // Check for errors
                if (snapshot.hasError) {
                  return Container(
                    child: Text('ERROR'),
                  );
                }

                // Once complete, show your application
                if (snapshot.hasData) {
                  return WrapperPage();
                }

                // Otherwise, show something whilst waiting for initialization to complete
                return Center(
                  child: CircularProgressIndicator(),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}

// class MainPage extends StatefulWidget {
//   @override
//   _MainPageState createState() => _MainPageState();
// }

// class _MainPageState extends State<MainPage> {
//   List<Player> players;
//   Dsix dsix = new Dsix();

//   Route _createRoute() {
//     return PageRouteBuilder(
//       pageBuilder: (context, animation, secondaryAnimation) =>
//           PlayersPage(dsix: dsix),
//       transitionsBuilder: (context, animation, secondaryAnimation, child) {
//         var begin = Offset(1.0, 0.0);
//         var end = Offset(0.0, 0.0);
//         var curve = Curves.ease;
//         var tween =
//             Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

//         return SlideTransition(
//           position: animation.drive(tween),
//           child: child,
//         );
//       },
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     List<PlayerColor> playerColors = [
//       PlayerColor(
//           name: 'PINK',
//           primaryColor: Colors.pinkAccent,
//           secondaryColor: Colors.pink[100],
//           tertiaryColor: Colors.pink[800]),
//       PlayerColor(
//           name: 'BLUE',
//           primaryColor: Colors.indigoAccent,
//           secondaryColor: Colors.indigo[100],
//           tertiaryColor: Colors.indigo[800]),
//       PlayerColor(
//           name: 'GREEN',
//           primaryColor: Colors.teal,
//           secondaryColor: Colors.teal[100],
//           tertiaryColor: Colors.teal[800]),
//       PlayerColor(
//           name: 'YELLOW',
//           primaryColor: Colors.orange,
//           secondaryColor: Colors.orange[100],
//           tertiaryColor: Colors.orange[800]),
//       PlayerColor(
//           name: 'PURPLE',
//           primaryColor: Colors.purple,
//           secondaryColor: Colors.purple[100],
//           tertiaryColor: Colors.purple[800]),
//     ];

//     if (dsix.players.isEmpty == true) {
//       for (PlayerColor playerColor in playerColors) {
//         dsix.players.add(new Player(playerColor));
//       }
//     }

//     return Scaffold(
//       backgroundColor: Colors.black,
//       body: SafeArea(
//         child: StreamProvider<DsixUser>.value(
//           initialData: null,
//           value: AuthService().user,
//           child: FutureBuilder(
//             // Initialize FlutterFire:
//             future: Firebase.initializeApp(),
//             builder: (context, snapshot) {
//               // Check for errors
//               if (snapshot.hasError) {
//                 return Container(
//                   child: Text('ERROR'),
//                 );
//               }

//               // Once complete, show your application
//               if (snapshot.hasData) {
//                 return WrapperPage();
//               }

//               // Otherwise, show something whilst waiting for initialization to complete
//               return Center(
//                 child: CircularProgressIndicator(),
//               );
//             },
//           ),
//         ),
//       ),
//     );
//   }
// }
