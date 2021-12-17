import 'package:dsixv02app/shared/app_Colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

// ignore: must_be_immutable
class PlayerSpriteImage extends StatelessWidget {
  String image;
  double size;
  List<Widget> layers;
  PlayerSpriteImage({
    @required this.image,
    this.size,
    this.layers,
  });

  @override
  Widget build(BuildContext context) {
    switch (this.image) {
      case 'dwarf':
        this.size = 15;
        this.layers = [
          SvgPicture.asset(
            'assets/image/sprite/dwarf/armor00.svg',
            color: AppColors.dwarfArmor00,
            width: double.infinity,
            height: double.infinity,
          ),
          SvgPicture.asset(
            'assets/image/sprite/dwarf/armor01.svg',
            color: AppColors.dwarfArmor01,
            width: double.infinity,
            height: double.infinity,
          ),
          SvgPicture.asset(
            'assets/image/sprite/dwarf/skin00.svg',
            color: AppColors.dwarfSkin00,
            width: double.infinity,
            height: double.infinity,
          ),
          SvgPicture.asset(
            'assets/image/sprite/dwarf/skin01.svg',
            color: AppColors.dwarfSkin01,
            width: double.infinity,
            height: double.infinity,
          ),
          SvgPicture.asset(
            'assets/image/sprite/dwarf/detail00.svg',
            color: AppColors.dwarfDetail00,
            width: double.infinity,
            height: double.infinity,
          ),
          SvgPicture.asset(
            'assets/image/sprite/dwarf/detail01.svg',
            color: AppColors.dwarfDetail01,
            width: double.infinity,
            height: double.infinity,
          ),
          SvgPicture.asset(
            'assets/image/sprite/dwarf/beard00.svg',
            color: AppColors.dwarfBeard00,
            width: double.infinity,
            height: double.infinity,
          ),
        ];
        break;
      case 'orc':
        this.size = 15;
        this.layers = [
          SvgPicture.asset(
            'assets/image/sprite/orc/armor00.svg',
            color: AppColors.orcArmor00,
            width: double.infinity,
            height: double.infinity,
          ),
          SvgPicture.asset(
            'assets/image/sprite/orc/armor01.svg',
            color: AppColors.orcArmor01,
            width: double.infinity,
            height: double.infinity,
          ),
          SvgPicture.asset(
            'assets/image/sprite/orc/skin00.svg',
            color: AppColors.orcSkin00,
            width: double.infinity,
            height: double.infinity,
          ),
          SvgPicture.asset(
            'assets/image/sprite/orc/skin01.svg',
            color: AppColors.orcSkin01,
            width: double.infinity,
            height: double.infinity,
          ),
          SvgPicture.asset(
            'assets/image/sprite/orc/detail00.svg',
            color: AppColors.orcDetail00,
            width: double.infinity,
            height: double.infinity,
          ),
          SvgPicture.asset(
            'assets/image/sprite/orc/detail01.svg',
            color: AppColors.orcDetail01,
            width: double.infinity,
            height: double.infinity,
          ),
        ];
        break;

      case 'elf':
        this.size = 15;
        this.layers = [
          SvgPicture.asset(
            'assets/image/sprite/elf/armor00.svg',
            color: AppColors.elfArmor00,
            width: double.infinity,
            height: double.infinity,
          ),
          SvgPicture.asset(
            'assets/image/sprite/elf/armor01.svg',
            color: AppColors.elfArmor01,
            width: double.infinity,
            height: double.infinity,
          ),
          SvgPicture.asset(
            'assets/image/sprite/elf/skin00.svg',
            color: AppColors.elfSkin00,
            width: double.infinity,
            height: double.infinity,
          ),
          SvgPicture.asset(
            'assets/image/sprite/elf/skin01.svg',
            color: AppColors.elfSkin01,
            width: double.infinity,
            height: double.infinity,
          ),
          SvgPicture.asset(
            'assets/image/sprite/elf/clothes00.svg',
            color: AppColors.elfClothes00,
            width: double.infinity,
            height: double.infinity,
          ),
          SvgPicture.asset(
            'assets/image/sprite/elf/clothes01.svg',
            color: AppColors.elfClothes01,
            width: double.infinity,
            height: double.infinity,
          ),
          SvgPicture.asset(
            'assets/image/sprite/elf/detail01.svg',
            color: AppColors.elfDetail01,
            width: double.infinity,
            height: double.infinity,
          ),
          SvgPicture.asset(
            'assets/image/sprite/elf/hair00.svg',
            color: AppColors.elfHair00,
            width: double.infinity,
            height: double.infinity,
          ),
        ];
        break;

      case 'grave':
        this.size = 16;
        this.layers = [
          SvgPicture.asset(
            'assets/image/sprite/grave/grave00.svg',
            color: AppColors.grave00,
            width: double.infinity,
            height: double.infinity,
          ),
          SvgPicture.asset(
            'assets/image/sprite/grave/grave01.svg',
            color: AppColors.grave01,
            width: double.infinity,
            height: double.infinity,
          ),
          SvgPicture.asset(
            'assets/image/sprite/grave/grave02.svg',
            color: AppColors.grave02,
            width: double.infinity,
            height: double.infinity,
          ),
          SvgPicture.asset(
            'assets/image/sprite/grave/grave03.svg',
            color: AppColors.grave03,
            width: double.infinity,
            height: double.infinity,
          ),
        ];
        break;
    }

    return Container(
      width: this.size,
      height: this.size,
      child: Stack(
        alignment: Alignment.topLeft,
        children: this.layers,
      ),
    );
  }
}
