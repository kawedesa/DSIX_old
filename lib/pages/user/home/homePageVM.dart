import 'package:dsixv02app/pages/user/players/playersPage.dart';
import 'package:flutter/material.dart';
import 'package:dsixv02app/models/dsix/dsix.dart';

class HomePageVM {
  Dsix dsix = new Dsix();

  goToPlayersPage(context) {
    dsix.newGame();

    Route newRoute = PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => PlayersPage(
        dsix: dsix,
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

    Navigator.of(context).push(newRoute);
  }
}
