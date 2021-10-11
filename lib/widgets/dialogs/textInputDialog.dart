import 'package:dsixv02app/core/app_colors.dart';
import 'package:dsixv02app/core/app_text_styles.dart';

import 'package:dsixv02app/widgets/buttons/dialogButton.dart';
import 'package:flutter/material.dart';

class TextInputDialog extends StatelessWidget {
  const TextInputDialog(
      {@required this.title,
      @required this.color,
      @required this.confirm,
      @required this.textController});

  final String title;

  final Color color;
  final Function() confirm;
  final TextEditingController textController;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
        contentPadding: EdgeInsets.fromLTRB(0, 0, 0, 0),
        content: Container(
          color: AppColors.black01,
          child: Column(mainAxisSize: MainAxisSize.min, children: [
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
                    padding: const EdgeInsets.fromLTRB(25, 10, 25, 5),
                    child: TextField(
                        autofocus: true,
                        cursorColor: color,
                        textAlign: TextAlign.center,
                        onEditingComplete: () {
                          confirm();
                        },
                        onSubmitted: (value) {
                          confirm();
                        },
                        style: AppTextStyles.textFieldStyle,
                        controller: textController,
                        decoration: InputDecoration(
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: color,
                              width: 1.5,
                            ),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: color,
                              width: 1.5,
                            ),
                          ),
                          border: UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: color,
                              width: 1.5,
                            ),
                          ),
                        )),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 5, 0, 0),
                    child: DialogButton(
                      buttonText: 'confirm',
                      buttonColor: color,
                      buttonTextColor: AppColors.white01,
                      buttonIcon: 'confirm',
                      onTapAction: () {
                        confirm();
                      },
                    ),
                  ),
                ],
              ),
            ),
          ]),
        ));
  }
}
