import 'package:flutter/material.dart';

class Situation {
  Widget image;
  String name;
  String description;

  Situation({Widget image, String name, String description}) {
    this.image = image;
    this.name = name;
    this.description = description;
  }

  Situation newSituation() {
    Situation newSituation = Situation(
      name: '',
      description: '',
    );
    return newSituation;
  }

  Situation copySituation() {
    Situation newSituation = Situation(
      image: this.image,
      name: this.name,
      description: this.description,
    );
    return newSituation;
  }
}
