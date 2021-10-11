import 'package:dsixv02app/core/app_colors.dart';
import 'package:dsixv02app/core/app_text_styles.dart';
import 'package:flutter/material.dart';

class DescriptionDialog extends StatelessWidget {
  const DescriptionDialog(
      {@required this.title, @required this.description, @required this.color});

  final String title;
  final String description;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      contentPadding: EdgeInsets.fromLTRB(0, 0, 0, 0),
      content: Container(
        color: AppColors.black01,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              decoration: BoxDecoration(
                border: Border.all(
                  color: color,
                  width: 1.5, //                   <--- border width here
                ),
              ),
              width: MediaQuery.of(context).size.width * 0.7,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Container(
                    color: color,
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(30, 5, 30, 7),
                      child: Center(
                        child: Text(this.title.toUpperCase(),
                            style: AppTextStyles.dialogTitleStyle),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(35, 15, 25, 20),
                    child: Text(
                      this.description,
                      textAlign: TextAlign.justify,
                      style: AppTextStyles.dialogDescriptionStyle,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
