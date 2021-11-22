import 'package:dsixv02app/core/app_colors.dart';
import 'package:dsixv02app/core/app_images.dart';
import 'package:dsixv02app/core/app_text_styles.dart';
import 'package:dsixv02app/models/player/player.dart';
import 'package:dsixv02app/widgets/buttons/dialogButton.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AmountDialog extends StatefulWidget {
  const AmountDialog({@required this.color, @required this.confirm});
  final Function(int) confirm;
  final Color color;

  @override
  State<AmountDialog> createState() => _AmountDialogState();
}

class _AmountDialogState extends State<AmountDialog> {
  int amount = 0;

  void changeAmount(int value) {
    if (this.amount + value < 0) {
      amount = 0;
    } else {
      this.amount += value;
    }
  }

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
                  color: widget.color,
                  width: 1.5, //                   <--- border width here
                ),
              ),
              width: MediaQuery.of(context).size.width * 0.7,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Container(
                    color: widget.color,
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(30, 5, 30, 7),
                      child: Center(
                        child: Text('amount',
                            style: AppTextStyles.dialogTitleStyle),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(25, 15, 25, 20),
                    child: Container(
                      height: MediaQuery.of(context).size.height * 0.2,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                changeAmount(-1);
                              });
                            },
                            onLongPress: () {
                              setState(() {
                                changeAmount(-10);
                              });
                            },
                            child: Container(
                              width: 50,
                              height: 50,
                              child: SvgPicture.asset(
                                AppImages.arrowLeft,
                                color: widget.color,
                              ),
                            ),
                          ),
                          Text(
                            this.amount.toString(),
                            textAlign: TextAlign.justify,
                            style: AppTextStyles.amountDialogStyle,
                          ),
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                changeAmount(1);
                              });
                            },
                            onLongPress: () {
                              setState(() {
                                changeAmount(10);
                              });
                            },
                            child: Container(
                              width: 50,
                              height: 50,
                              child: SvgPicture.asset(
                                AppImages.arrowRight,
                                color: widget.color,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 5, 0, 0),
                    child: DialogButton(
                      buttonText: 'confirm',
                      buttonColor: widget.color,
                      buttonTextColor: AppColors.white01,
                      buttonIcon: 'confirm',
                      onTapAction: () {
                        widget.confirm(this.amount);
                        Navigator.pop(context);
                      },
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
