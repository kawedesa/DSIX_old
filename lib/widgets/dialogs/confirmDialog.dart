import 'dart:ui';

import 'package:dsixv02app/core/app_colors.dart';
import 'package:dsixv02app/core/app_text_styles.dart';
import 'package:dsixv02app/models/player/player.dart';
import 'package:dsixv02app/widgets/buttons/dialogButton.dart';
import 'package:flutter/material.dart';

class ConfirmDialog extends StatelessWidget {
  const ConfirmDialog(
      {@required this.player, @required this.color, @required this.confirm});

  final Player player;
  final Color color;
  final Function() confirm;

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
                        child: Text('are you sure?'.toUpperCase(),
                            style: AppTextStyles.dialogTitleStyle),
                      ),
                    ),
                  ),
                  DialogButton(
                    buttonText: 'confirm',
                    buttonTextColor: AppColors.white01,
                    buttonTextStyle: AppTextStyles.whiteButtonStyle,
                    buttonIcon: 'confirm',
                    buttonColor: this.color,
                    onTapAction: () async {
                      confirm();
                      Navigator.of(context).pop();
                    },
                  ),
                  DialogButton(
                    buttonText: 'cancel',
                    buttonTextColor: AppColors.white01,
                    buttonTextStyle: AppTextStyles.whiteButtonStyle,
                    buttonIcon: 'cancel',
                    buttonColor: this.color,
                    onTapAction: () async {
                      Navigator.of(context).pop();
                    },
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
