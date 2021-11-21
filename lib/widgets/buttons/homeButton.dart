import 'package:dsixv02app/core/app_colors.dart';
import 'package:dsixv02app/core/app_images.dart';
import 'package:dsixv02app/models/dsix/dsix.dart';
import 'package:dsixv02app/pages/user/players/playersPage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class HomeButton extends StatelessWidget {
  final Color buttonColor;
  final Dsix dsix;

  const HomeButton({this.buttonColor, @required this.dsix});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Route newRoute = PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) => PlayersPage(
            dsix: this.dsix,
          ),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            var begin = Offset(-1.0, 0.0);
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
      },
      child: Icon(
        Icons.exit_to_app,
        color:
            (this.buttonColor != null) ? this.buttonColor : AppColors.neutral01,
        size: 35,
      ),

      // SvgPicture.asset(
      //   AppImages.arrowLeft,
      //   color:
      //       (this.buttonColor != null) ? this.buttonColor : AppColors.neutral01,
      // ),
    );
  }
}
