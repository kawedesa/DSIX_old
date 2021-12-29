import 'package:flutter/material.dart';

class TallGrassArea {
  List<Area>? totalArea;
  TallGrassArea({
    List<Area>? totalArea,
  }) {
    this.totalArea = totalArea;
  }
  factory TallGrassArea.empty() {
    return TallGrassArea(
      totalArea: [],
    );
  }

  factory TallGrassArea.fromMap(Map data) {
    List<Area> totalArea = [];
    List<dynamic> areaMap = data['totalArea'];
    areaMap.forEach((area) {
      totalArea.add(new Area.fromMap(area));
    });
    return TallGrassArea(
      totalArea: totalArea,
    );
  }

  Map<String, dynamic> toMap() {
    var totalArea = this.totalArea?.map((area) => area.toMap()).toList();
    return {
      'totalArea': totalArea,
    };
  }
}

class Area {
  List<Vertex>? area;
  Area({List<Vertex>? area}) {
    this.area = area;
  }
  factory Area.fromMap(Map data) {
    List<Vertex> area = [];
    List<dynamic> areaMap = data['area'];
    areaMap.forEach((vertex) {
      area.add(new Vertex.fromMap(vertex));
    });
    return Area(
      area: area,
    );
  }

  Map<String, dynamic> toMap() {
    var area = this.area?.map((vertex) => vertex.toMap()).toList();
    return {
      'area': area,
    };
  }

  List<Offset> toPoly() {
    List<Offset> poly = [];
    this.area!.forEach((vertex) {
      poly.add(vertex.toOffset());
    });

    return poly;
  }

  bool inHere(Offset location) {
    Path grass = Path();
    grass.addPolygon(toPoly(), true);
    return grass.contains(location);
  }
}

class Vertex {
  double? dx;
  double? dy;
  Vertex({
    double? dx,
    double? dy,
  }) {
    this.dx = dx;
    this.dy = dy;
  }

  factory Vertex.fromMap(Map data) {
    return Vertex(
      dx: data['dx'],
      dy: data['dy'] * 1.0,
    );
  }

  factory Vertex.newVertex(Offset location) {
    return Vertex(
      dx: location.dx,
      dy: location.dy,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'dx': this.dx,
      'dy': this.dy,
    };
  }

  Offset toOffset() {
    return Offset(this.dx!, this.dy!);
  }
}
