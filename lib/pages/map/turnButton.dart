import 'package:dsixv02app/shared/app_Icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class TurnButton extends StatelessWidget {
  final Function()? onDoubleTap;
  final Color? color;
  const TurnButton({
    Key? key,
    this.onDoubleTap,
    this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onDoubleTap: () {
        onDoubleTap!();
      },
      child: Container(
        width: MediaQuery.of(context).size.height * 0.03,
        height: MediaQuery.of(context).size.height * 0.03,
        child: SvgPicture.asset(
          AppIcons.turn,
          color: color,
        ),
      ),
    );
  }
}
