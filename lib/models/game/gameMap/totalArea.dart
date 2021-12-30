import 'package:flutter/material.dart';

class TotalArea {
  List<Area>? area;
  TotalArea({
    List<Area>? area,
  }) {
    this.area = area;
  }
  factory TotalArea.empty() {
    return TotalArea(
      area: [],
    );
  }

  factory TotalArea.fromMap(Map data) {
    List<Area> areaFromMap = [];
    List<dynamic> areaMap = data['area'];
    areaMap.forEach((newArea) {
      areaFromMap.add(new Area.fromMap(newArea));
    });
    return TotalArea(
      area: areaFromMap,
    );
  }

  Map<String, dynamic> toMap() {
    var areaToMap = this.area?.map((newArea) => newArea.toMap()).toList();
    return {
      'area': areaToMap,
    };
  }

  bool inThisArea(Offset location) {
    bool inHere = false;

    this.area!.forEach((eachArea) {
      if (inHere) {
        return;
      }
      inHere = eachArea.inHere(location);
    });

    return inHere;
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
    Path area = Path();
    area.addPolygon(toPoly(), true);
    return area.contains(location);
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
      dx: data['dx'] * 1.0,
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
