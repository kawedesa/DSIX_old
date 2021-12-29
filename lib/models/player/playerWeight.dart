class PlayerWeight {
  int? max;
  int? current;
  PlayerWeight({int? max, int? current}) {
    this.max = max;
    this.current = current;
  }
  Map<String, dynamic> toMap() {
    return {
      'max': this.max,
      'current': this.current,
    };
  }

  factory PlayerWeight.fromMap(Map<String, dynamic>? data) {
    return PlayerWeight(
      max: data?['max'],
      current: data?['current'],
    );
  }

  factory PlayerWeight.set(String race) {
    int max;
    if (race == 'orc') {
      max = 18;
    } else {
      max = 14;
    }
    return PlayerWeight(max: max, current: 0);
  }

  bool cantCarry(int newWeight) {
    if (this.current! + newWeight > this.max!) {
      return true;
    } else {
      return false;
    }
  }
}
