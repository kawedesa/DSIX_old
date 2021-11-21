import 'package:dsixv02app/core/app_colors.dart';
import 'package:flutter/material.dart';

class Description extends StatelessWidget {
  final String description;

  const Description({this.description});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.65,
      child: Center(
        child: Text(
          this.description,
          textAlign: TextAlign.justify,
          style: TextStyle(
            height: 1.3,
            letterSpacing: 1.1,
            fontSize: 18,
            fontFamily: 'Calibri',
            color: AppColors.white01,
          ),
        ),
      ),
    );
  }
}
