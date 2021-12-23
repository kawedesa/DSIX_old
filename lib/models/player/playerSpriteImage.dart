import 'package:dsixv02app/shared/app_Colors.dart';
import 'package:dsixv02app/shared/app_Images.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

// ignore: must_be_immutable
class PlayerSpriteImage extends StatelessWidget {
  String? image;
  bool? isDead;
  double size = 15;
  List<Widget>? layers;
  PlayerSpriteImage({
    @required this.image,
    @required this.isDead,
  });

  @override
  Widget build(BuildContext context) {
    if (isDead!) {
      this.layers = AppImages.grave;
    } else {
      switch (this.image) {
        case 'dwarf':
          this.layers = AppImages.dwarf;
          break;
        case 'orc':
          this.layers = AppImages.orc;
          break;

        case 'elf':
          this.layers = AppImages.elf;
          break;
      }
    }

    return Container(
      width: size,
      height: size,
      child: Stack(
        alignment: Alignment.topLeft,
        children: this.layers!,
      ),
    );
  }
}
