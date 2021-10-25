import 'package:dsixv02app/core/app_text_styles.dart';
import 'package:flutter/material.dart';

class SubTitle extends StatelessWidget {
  const SubTitle({@required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      this.text,
      textAlign: TextAlign.justify,
      style: AppTextStyles.subTitle,
    );
  }
}
