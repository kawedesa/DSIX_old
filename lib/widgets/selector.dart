class Selector {
  List<bool> items = [];

  void newSelection(int lenght) {
    for (int i = 0; i < lenght; i++) {
      this.items.add(false);
    }
  }

  void reset() {
    int temp = this.items.length;
    this.items = [];

    for (int i = 0; i < temp; i++) {
      this.items.add(false);
    }
  }

  void select(int index) {
    if (this.items.length < 1) {
      return;
    }
    reset();
    this.items[index] = true;
  }
}
