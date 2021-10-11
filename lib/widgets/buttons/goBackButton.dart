import 'package:dsixv02app/core/app_colors.dart';
import 'package:dsixv02app/core/app_images.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class GoBackButton extends StatelessWidget {
  final Color buttonColor;

  const GoBackButton({this.buttonColor});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.of(context).pop(),
      child: SvgPicture.asset(
        AppImages.arrowLeft,
        color:
            (this.buttonColor != null) ? this.buttonColor : AppColors.neutral01,
      ),
    );
  }
}
