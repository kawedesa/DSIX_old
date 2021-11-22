import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AppIcon extends StatelessWidget {
  const AppIcon({@required this.icon, @required this.color});
  final String icon;
  final Color color;
  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      this.icon,
      color: this.color,
    );
  }
}
