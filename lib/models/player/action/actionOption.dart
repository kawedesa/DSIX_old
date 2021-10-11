class ActionOption {
  String name;
  String description;
  int value;

  ActionOption copyOption() {
    ActionOption newOption = new ActionOption(
        name: this.name, description: this.description, value: this.value);

    return newOption;
  }

  ActionOption({
    String name,
    String description,
    int value,
  }) {
    this.name = name;
    this.description = description;
    this.value = value;
  }
}
