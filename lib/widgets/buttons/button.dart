import 'package:dsixv02app/core/app_colors.dart';
import 'package:dsixv02app/core/app_images.dart';
import 'package:dsixv02app/core/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Button extends StatelessWidget {
  final String buttonText;
  final Color buttonTextColor;
  final Color buttonColor;
  final String buttonIcon;
  final TextStyle buttonTextStyle;
  final Function() onTapAction;
  final Function() onLongPressAction;

  const Button({
    @required this.buttonText,
    this.buttonTextColor,
    this.buttonColor,
    this.buttonIcon,
    this.buttonTextStyle,
    this.onTapAction,
    this.onLongPressAction,
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
      }
    }

    return GestureDetector(
      onLongPress: () => this.onLongPressAction(),
      onTap: () => this.onTapAction(),
      child: Container(
        height: MediaQuery.of(context).size.height * 0.09,
        width: MediaQuery.of(context).size.width * 0.65,
        decoration: BoxDecoration(
          border: Border.all(
            color: (this.buttonColor != null)
                ? this.buttonColor
                : AppColors.neutral02,
            width: 2.5, //                   <--- border width here
          ),
        ),
        child: Stack(
          alignment: AlignmentDirectional.centerEnd,
          children: [
            Align(
              alignment: Alignment.centerRight,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 25, 0),
                child: (this.buttonIcon != null)
                    ? Container(
                        width: MediaQuery.of(context).size.width * 0.04,
                        child: SvgPicture.asset(
                          _icon,
                          color: (this.buttonColor != null)
                              ? this.buttonColor
                              : AppColors.neutral02,
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
                          fontSize: 15,
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
    );
  }
}
