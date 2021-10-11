import 'package:flutter/material.dart';

class DescriptionTitle extends StatelessWidget {
  final Color color;

  final String title;

  const DescriptionTitle({this.color, this.title});

  @override
  Widget build(BuildContext context) {
    return Text(
      this.title,
      style: TextStyle(
        fontFamily: 'Headline',
        height: 1.3,
        fontSize: 45,
        letterSpacing: 2,
        color: this.color,
      ),
    );
  }
}
