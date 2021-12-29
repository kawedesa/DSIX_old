class PlayerWalkRange {
  double? min;
  double? max;
  PlayerWalkRange({double? min, double? max}) {
    this.min = min;
    this.max = max;
  }
  Map<String, dynamic> toMap() {
    return {
      'min': this.min,
      'max': this.max,
    };
  }

  factory PlayerWalkRange.fromMap(Map<String, dynamic>? data) {
    return PlayerWalkRange(
      min: data?['min'] * 1.0,
      max: data?['max'] * 1.0,
    );
  }
  factory PlayerWalkRange.set(String race) {
    return PlayerWalkRange(min: 0, max: 60);
  }
}
