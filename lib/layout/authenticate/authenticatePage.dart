import 'package:flutter/material.dart';
import 'package:dsixv02app/pages/playersPage.dart';
import 'package:dsixv02app/models/player/player.dart';
import 'package:dsixv02app/models/game/dsix.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:firebase_core/firebase_core.dart';

class AuthenticatePage extends StatefulWidget {
  @override
  _AuthenticatePageState createState() => _AuthenticatePageState();
}

class _AuthenticatePageState extends State<AuthenticatePage> {
// Route _createRoute() {
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

  @override
  Widget build(BuildContext context) {
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
          TextButton(
            style: TextButton.styleFrom(
              padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
            ),
            onPressed: () {
              // Navigator.of(context).push(_createRoute());
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
                        'SIGN IN',
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
    );
  }
}
