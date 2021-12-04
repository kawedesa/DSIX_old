import 'package:flutter/material.dart';

class MapTile extends StatelessWidget {
  const MapTile({
    @required this.name,
    @required this.size,
    @required this.layers,
  });

  final String name;
  final double size;
  final List<Widget> layers;

  MapTile copy() {
    MapTile newMapTile =
        MapTile(name: this.name, layers: this.layers, size: this.size);
    return newMapTile;
  }

  @override
  Widget build(BuildContext context) {
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
