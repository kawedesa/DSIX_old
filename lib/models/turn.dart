class Turn {
  String? id;
  int? index;
  Turn({String? id, int? index}) {
    this.id = id;
    this.index = index;
  }

  factory Turn.fromMap(Map data) {
    return Turn(
      id: data['id'],
      index: data['index'],
    );
  }
  Map<String, dynamic> toMap() {
    return {
      'id': this.id,
      'index': this.index,
    };
  }

  factory Turn.newTurn(
    String? id,
    int? index,
  ) {
    return Turn(
      id: id,
      index: index,
    );
  }
}
