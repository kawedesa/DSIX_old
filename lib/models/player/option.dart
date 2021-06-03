class Option {
  String name;
  String description;
  String success;
  String halfSuccess;
  String fail;
  String outcome;
  bool firstRoll = true;
  bool newRoll = false;

  Option copyOption() {
    Option newOption = new Option(this.name, this.description, this.success,
        this.halfSuccess, this.fail, this.outcome, this.newRoll);

    return newOption;
  }

  Option(this.name, this.description, this.success, this.halfSuccess, this.fail,
      this.outcome, this.newRoll);
}
