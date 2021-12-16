import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class PlayerTempLocation extends ChangeNotifier {
  double dx = 0;
  double dy = 0;

  void walk(double dx, double dy) {
    this.dx += dx;
    this.dy += dy;
    notifyListeners();
  }

  void endWalk(String id) async {
    final db = FirebaseFirestore.instance;
    final batch = db.batch();
    final document = db.collection('players').doc(id);
    batch.update(document, {'dx': this.dx, 'dy': this.dy});
    await batch.commit();
  }

  void updatePlayerLocation(
    double dx,
    double dy,
  ) {
    this.dx = dx;
    this.dy = dy;
    notifyListeners();
  }
}
