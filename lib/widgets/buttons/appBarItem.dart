import 'package:dsixv02app/core/app_images.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AppBarItem extends StatelessWidget {
  final String buttonText;
  final Color textColor;
  final String buttonIcon;

  final Function() onTapAction;

  const AppBarItem(
      {@required this.buttonText,
      @required this.buttonIcon,
      @required this.onTapAction,
      this.textColor});

  @override
  Widget build(BuildContext context) {
    String _icon;

    if (buttonIcon != null) {
      switch (buttonIcon) {
        case 'health':
          _icon = AppImages.health;
          break;
        case 'gold':
          _icon = AppImages.gold;
          break;
      }
    }

    return GestureDetector(
      onTap: () {
        onTapAction();
      },
      child: Row(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.fromLTRB(5, 0, 5, 0),
            child: SvgPicture.asset(
              _icon,
              color: Colors.white,
              width: MediaQuery.of(context).size.width * 0.078,
            ),
          ),
          Text(
            this.buttonText,
            textAlign: TextAlign.left,
            style: TextStyle(
              fontFamily: 'Santana',
              height: 1,
              fontSize: 30,
              color: textColor,
              letterSpacing: 1.2,
            ),
          ),
        ],
      ),
    );
  }
}
