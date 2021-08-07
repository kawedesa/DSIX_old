class Option {
  String name;
  String description;
  String success;
  String halfSuccess;
  String fail;
  List<String> failOutcome;
  String outcome;
  bool firstRoll = true;
  bool newRoll = false;

  Option copyOption() {
    Option newOption = new Option(
        this.name,
        this.description,
        this.success,
        this.halfSuccess,
        this.fail,
        this.failOutcome,
        this.outcome,
        this.newRoll);

    return newOption;
  }

  Option(this.name, this.description, this.success, this.halfSuccess, this.fail,
      this.failOutcome, this.outcome, this.newRoll);
}
