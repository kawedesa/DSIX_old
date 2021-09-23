import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class MapTile {
  Widget mapTile = Container();

  MapTile createNewMap(double mapSize) {
    MapTile newTile = MapTile(
        mapTile: Stack(
      children: [
        //water
        Container(
          width: mapSize,
          height: mapSize,
          color: Color(0xff4BB8E8),
        ),
        Container(
          width: mapSize,
          height: mapSize,
          child: SvgPicture.asset(
            'assets/map/grassland/1_grass.svg',
            color: Color(0xff88E259),
          ),
        ),
        Container(
          width: mapSize,
          height: mapSize,
          child: SvgPicture.asset(
            'assets/map/grassland/1_mountain.svg',
            color: Color(0xffB75955),
          ),
        ),
        Container(
          width: mapSize,
          height: mapSize,
          child: SvgPicture.asset(
            'assets/map/grassland/1_vegetation.svg',
            color: Color(0xff538E40),
          ),
        ),
        Container(
          width: mapSize,
          height: mapSize,
          child: SvgPicture.asset(
            'assets/map/grassland/1_forest.svg',
            color: Color(0xff2B5114),
          ),
        ),
        Container(
          width: mapSize,
          height: mapSize,
          child: SvgPicture.asset(
            'assets/map/grassland/1_road.svg',
            color: Color(0xffBA8E54),
          ),
        ),
      ],
    ));

    return newTile;
  }

  MapTile({Widget mapTile}) {
    this.mapTile = mapTile;
  }
}
