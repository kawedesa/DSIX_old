class Option {
  String name;
  String description;
  int value;

  Option copyOption() {
    Option newOption = new Option(
        name: this.name, description: this.description, value: this.value);

    return newOption;
  }

  Option({
    String name,
    String description,
    int value,
  }) {
    this.name = name;
    this.description = description;
    this.value = value;
  }
}
