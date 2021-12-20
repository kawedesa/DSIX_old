import 'package:dsixv02app/shared/app_Colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

// ignore: must_be_immutable
class MapTile extends StatelessWidget {
  String name;
  List<Widget> layers;
  MapTile({
    @required this.name,
    this.layers,
  });

  @override
  Widget build(BuildContext context) {
    switch (this.name) {
      case 'ruins':
        this.layers = [
          SvgPicture.asset(
            'assets/image/map/ruins/grass00.svg',
            color: AppColors.crossroadsGrass00,
            width: double.infinity,
            height: double.infinity,
          ),
          SvgPicture.asset(
            'assets/image/map/ruins/grass01.svg',
            color: AppColors.crossroadsGrass01,
            width: double.infinity,
            height: double.infinity,
          ),
          SvgPicture.asset(
            'assets/image/map/ruins/hill00.svg',
            color: AppColors.crossroadsHill00,
            width: double.infinity,
            height: double.infinity,
          ),
          SvgPicture.asset(
            'assets/image/map/ruins/hill01.svg',
            color: AppColors.crossroadsHill01,
            width: double.infinity,
            height: double.infinity,
          ),
          SvgPicture.asset(
            'assets/image/map/ruins/river00.svg',
            color: AppColors.crossroadsRiver00,
            width: double.infinity,
            height: double.infinity,
          ),
          SvgPicture.asset(
            'assets/image/map/ruins/river01.svg',
            color: AppColors.crossroadsRiver01,
            width: double.infinity,
            height: double.infinity,
          ),
          SvgPicture.asset(
            'assets/image/map/ruins/structure00.svg',
            color: AppColors.crossroadsStructure00,
            width: double.infinity,
            height: double.infinity,
          ),
          SvgPicture.asset(
            'assets/image/map/ruins/structure01.svg',
            color: AppColors.crossroadsStructure01,
            width: double.infinity,
            height: double.infinity,
          ),
          SvgPicture.asset(
            'assets/image/map/ruins/structure02.svg',
            color: AppColors.crossroadsStructure02,
            width: double.infinity,
            height: double.infinity,
          ),
          SvgPicture.asset(
            'assets/image/map/ruins/structure03.svg',
            color: AppColors.crossroadsStructure03,
            width: double.infinity,
            height: double.infinity,
          ),
          SvgPicture.asset(
            'assets/image/map/ruins/tree00.svg',
            color: AppColors.crossroadsTree00,
            width: double.infinity,
            height: double.infinity,
          ),
          SvgPicture.asset(
            'assets/image/map/ruins/tree01.svg',
            color: AppColors.crossroadsTree01,
            width: double.infinity,
            height: double.infinity,
          ),
          SvgPicture.asset(
            'assets/image/map/ruins/tree02.svg',
            color: AppColors.crossroadsTree02,
            width: double.infinity,
            height: double.infinity,
          ),
        ];
        break;
    }

    return Stack(
      alignment: Alignment.topLeft,
      children: this.layers,
    );
  }
}
