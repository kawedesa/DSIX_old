import 'package:cloud_firestore/cloud_firestore.dart';

class PlayerDamage {
  int? pDamage;
  int? mDamage;
  int? tempDamage;
  PlayerDamage({
    int? pDamage,
    int? mDamage,
    int? tempDamage,
  }) {
    this.pDamage = pDamage;
    this.mDamage = mDamage;
    this.tempDamage = tempDamage;
  }

  Map<String, dynamic> toMap() {
    return {
      'pDamage': this.pDamage,
      'mDamage': this.mDamage,
      'tempDamage': this.tempDamage,
    };
  }

  factory PlayerDamage.fromMap(Map<String, dynamic>? data) {
    return PlayerDamage(
      pDamage: data?['pDamage'],
      mDamage: data?['mDamage'],
      tempDamage: data?['tempDamage'],
    );
  }

  factory PlayerDamage.empty() {
    return PlayerDamage(
      pDamage: 0,
      mDamage: 0,
      tempDamage: 0,
    );
  }

  void increasePDamage(int value) {
    this.pDamage = this.pDamage! + value;
  }

  void decreasePDamage(int value) {
    this.pDamage = this.pDamage! - value;
    if (this.pDamage! < 0) {
      this.pDamage = 0;
    }
  }

  void increaseMDamage(int value) {
    this.mDamage = this.mDamage! + value;
  }

  void decreaseMDamage(int value) {
    this.mDamage = this.mDamage! - value;
    if (this.mDamage! < 0) {
      this.mDamage = 0;
    }
  }

  void increaseTempDamage(int value) {
    this.tempDamage = this.tempDamage! + value;
  }

  void decreaseTempDamage(int value) {
    this.tempDamage = this.tempDamage! - value;
    if (this.tempDamage! < 0) {
      this.tempDamage = 0;
    }
  }

  void resetTempDamage() {
    this.tempDamage = 0;
  }

  void update(String gameID, String playerIndex) async {
    final database = FirebaseFirestore.instance.collection('game');
    await database.doc(gameID).collection('players').doc(playerIndex).update({
      'damage': toMap(),
    });
  }
}
