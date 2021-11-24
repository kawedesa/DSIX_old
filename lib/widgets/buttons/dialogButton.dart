import 'package:dsixv02app/core/app_colors.dart';
import 'package:dsixv02app/core/app_images.dart';
import 'package:dsixv02app/core/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class DialogButton extends StatelessWidget {
  final String buttonText;
  final Color buttonTextColor;
  final Color buttonColor;
  final Color buttonFillColor;
  final Color iconFillColor;
  final String buttonIcon;

  final TextStyle buttonTextStyle;
  final Function() onTapAction;
  final int value;

  const DialogButton({
    @required this.buttonText,
    this.buttonTextColor,
    this.buttonColor,
    this.buttonFillColor,
    this.iconFillColor,
    this.buttonIcon,
    this.buttonTextStyle,
    this.onTapAction,
    this.value,
  });

  @override
  Widget build(BuildContext context) {
    String _icon;

    if (buttonIcon != null) {
      switch (buttonIcon) {
        case 'up':
          _icon = AppImages.arrowUp;

          break;
        case 'down':
          _icon = AppImages.arrowDown;

          break;
        case 'right':
          _icon = AppImages.arrowRight;
          break;
        case 'help':
          _icon = AppImages.help;
          break;
        case 'confirm':
          _icon = AppImages.confirm;
          break;
        case 'cancel':
          _icon = AppImages.cancel;
          break;
        case 'gold':
          _icon = AppImages.goldButton;
          break;
        case 'action':
          _icon = AppImages.action;
          break;
        case 'weight':
          _icon = AppImages.weight;
          break;
      }
    }

    return GestureDetector(
      onTap: () => this.onTapAction(),
      child: Container(
        color: (this.buttonFillColor != null)
            ? this.buttonFillColor
            : AppColors.black01,
        child: Container(
          height: MediaQuery.of(context).size.height * 0.08,
          width: double.infinity,
          decoration: BoxDecoration(
            border: Border.all(
              color: (this.buttonColor != null)
                  ? this.buttonColor
                  : AppColors.neutral01,
              width: 1.5, //                   <--- border width here
            ),
          ),
          child: Stack(
            alignment: AlignmentDirectional.centerEnd,
            children: [
              Align(
                alignment: Alignment.centerRight,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(0, 3, 40, 0),
                  child: (this.value != null)
                      ? Container(
                          width: MediaQuery.of(context).size.width * 0.04,
                          child: Text(
                            '${this.value}',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 1.5,
                              fontFamily: 'Calibri',
                              color: this.buttonTextColor,
                            ),
                          ),
                        )
                      : Container(),
                ),
              ),
              Align(
                alignment: Alignment.centerRight,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(0, 0, 25, 0),
                  child: (this.buttonIcon != null)
                      ? Container(
                          width: MediaQuery.of(context).size.width * 0.04,
                          child: SvgPicture.asset(
                            _icon,
                            color: (this.iconFillColor != null)
                                ? this.iconFillColor
                                : this.buttonFillColor,
                          ),
                        )
                      : Container(),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 8, 0, 8),
                child: Center(
                  child: Text(
                    '${this.buttonText}'.toUpperCase(),
                    style: (this.buttonTextColor != null)
                        ? TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1.5,
                            fontFamily: 'Calibri',
                            color: this.buttonTextColor,
                          )
                        : AppTextStyles.neutralButtonStyle,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
