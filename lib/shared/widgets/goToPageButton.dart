import 'package:dsixv02app/shared/app_Colors.dart';
import 'package:flutter/material.dart';

class GoToPagePageButton extends StatelessWidget {
  final Widget goToPage;
  final Color buttonColor;
  const GoToPagePageButton({Key key, @required this.goToPage, this.buttonColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Route newRoute = PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) => goToPage,
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
        color: (this.buttonColor != null) ? this.buttonColor : AppColors.grey03,
        size: MediaQuery.of(context).size.height * 0.05,
      ),
    );
  }
}
