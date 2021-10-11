import 'package:dsixv02app/core/app_colors.dart';
import 'package:dsixv02app/core/app_images.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class NextButton extends StatelessWidget {
  final Function() onTapAction;

  const NextButton({@required this.onTapAction});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => this.onTapAction(),
      child: SvgPicture.asset(
        AppImages.arrowRight,
        width: MediaQuery.of(context).size.width * 0.06,
        color: AppColors.nextButtonColor,
      ),
    );
  }
}
