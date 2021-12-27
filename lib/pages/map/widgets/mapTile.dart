import 'package:dsixv02app/shared/app_Images.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class MapTile extends StatelessWidget {
  String? name;
  List<Widget>? layers;
  MapTile({
    @required this.name,
  });

  @override
  Widget build(BuildContext context) {
    switch (this.name) {
      case 'ruins':
        this.layers = AppImages.ruins;
        break;
    }

    return Stack(
      alignment: Alignment.topLeft,
      children: this.layers!,
    );
  }
}
