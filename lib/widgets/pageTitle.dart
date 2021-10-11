import 'package:flutter/material.dart';

class PageTitle extends StatelessWidget {
  const PageTitle({
    this.color,
    this.title,
  });
  final Color color;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Text(
      this.title.toUpperCase(),
      textAlign: TextAlign.center,
      style: TextStyle(
        fontFamily: 'Santana',
        height: 1,
        fontSize: 30,
        letterSpacing: 1.2,
        color: this.color,
      ),
    );
  }
}
