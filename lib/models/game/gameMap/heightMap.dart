import 'package:flutter/material.dart';

import 'totalArea.dart';

class HeightMap {
  List<HeightMapLayer>? layers;
  HeightMap({
    List<HeightMapLayer>? layers,
  }) {
    this.layers = layers;
  }

  factory HeightMap.empty() {
    return HeightMap(
      layers: [],
    );
  }

  factory HeightMap.fromMap(Map data) {
    List<HeightMapLayer> layersFromMap = [];
    List<dynamic> map = data['layers'];
    map.forEach((newTotalArea) {
      layersFromMap.add(new HeightMapLayer.fromMap(newTotalArea));
    });
    return HeightMap(
      layers: layersFromMap,
    );
  }

  Map<String, dynamic> toMap() {
    var layersToMap =
        this.layers?.map((newTotalArea) => newTotalArea.toMap()).toList();
    return {
      'layers': layersToMap,
    };
  }

  int inThisLayer(Offset location) {
    int inThisLayer = 0;

    this.layers!.forEach((layer) {
      if (layer.layer!.inThisArea(location)) {
        inThisLayer = layer.index!;
      }
    });

    return inThisLayer;
  }
}

class HeightMapLayer {
  TotalArea? layer;
  int? index;
  HeightMapLayer({
    TotalArea? layer,
    int? index,
  }) {
    this.layer = layer;
    this.index = index;
  }

  factory HeightMapLayer.fromMap(Map data) {
    return HeightMapLayer(
      index: data['index'],
      layer: TotalArea.fromMap(data['layer']),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'index': this.index,
      'layer': this.layer!.toMap(),
    };
  }
}
