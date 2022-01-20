class PlayerArmor {
  int? pArmor;
  int? mArmor;
  int? tempArmor;
  PlayerArmor({
    int? pArmor,
    int? mArmor,
    int? tempArmor,
  }) {
    this.pArmor = pArmor;
    this.mArmor = mArmor;
    this.tempArmor = tempArmor;
  }

  Map<String, dynamic> toMap() {
    return {
      'pArmor': this.pArmor,
      'mArmor': this.mArmor,
      'tempArmor': this.tempArmor,
    };
  }

  factory PlayerArmor.fromMap(Map<String, dynamic>? data) {
    return PlayerArmor(
      pArmor: data?['pArmor'],
      mArmor: data?['mArmor'],
      tempArmor: data?['tempArmor'],
    );
  }

  factory PlayerArmor.empty() {
    return PlayerArmor(
      pArmor: 0,
      mArmor: 0,
      tempArmor: 0,
    );
  }

  void increasePArmor(int value) {
    this.pArmor = this.pArmor! + value;
  }

  void decreasePArmor(int value) {
    this.pArmor = this.pArmor! - value;
    if (this.pArmor! < 0) {
      this.pArmor = 0;
    }
  }

  void increaseMArmor(int value) {
    this.mArmor = this.mArmor! + value;
  }

  void decreaseMArmor(int value) {
    this.mArmor = this.mArmor! - value;
    if (this.mArmor! < 0) {
      this.mArmor = 0;
    }
  }

  void increaseTempArmor(int value) {
    this.tempArmor = this.tempArmor! + value;
  }

  void decreaseTempArmor(int value) {
    this.tempArmor = this.tempArmor! - value;
    if (this.tempArmor! < 0) {
      this.tempArmor = 0;
    }
  }

  int calculateTempArmor(int damage) {
    int totalDamageReceived =
        damage - this.tempArmor! - this.pArmor! - this.mArmor!;

    decreaseTempArmor(damage);

    if (totalDamageReceived < 0) {
      totalDamageReceived = 0;
    }

    return totalDamageReceived;
  }

  void resetTempArmor() {
    this.tempArmor = 0;
  }

  int calculateDamageReceived(int damageRoll, int pDamage, int mDamage) {
    int damageLeftOver = 0;
    int protectionLeftOver = 0;

    int pDamageCalculation = pDamage - this.pArmor!;
    if (pDamageCalculation >= 0) {
      damageLeftOver += pDamageCalculation;
    } else {
      protectionLeftOver -= pDamageCalculation;
    }

    int mDamageCalculation = mDamage - this.mArmor!;
    if (mDamageCalculation >= 0) {
      damageLeftOver += mDamageCalculation;
    } else {
      protectionLeftOver -= mDamageCalculation;
    }

    int partialDamage = damageRoll - protectionLeftOver;
    if (partialDamage < 1) {
      partialDamage = 0;
    }

    int totalDamageReceived = partialDamage + damageLeftOver;

    if (totalDamageReceived < 0) {
      totalDamageReceived = 0;
    }
    return totalDamageReceived;
  }
}
