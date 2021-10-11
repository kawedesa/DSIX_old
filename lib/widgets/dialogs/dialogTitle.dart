import 'package:dsixv02app/core/app_text_styles.dart';
import 'package:flutter/material.dart';

class DialogTitle extends StatelessWidget {
  const DialogTitle({this.title, this.color});

  final String title;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: this.color,
      width: double.infinity,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(0, 5, 0, 7),
        child: Center(
          child: Text(
            this.title,
            style: AppTextStyles.dialogTitleStyle,
          ),
        ),
      ),
    );
  }
}
