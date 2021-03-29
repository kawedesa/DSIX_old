class Option {
  String name;
  String description;
  String success;
  String halfSuccess;
  String fail;
  String result;
  String resultText = '';
  int value;

  void useOption(int result) {
    if (this.resultText != '') {
      return;
    }

    if (result < 7) {
      this.name = 'FAIL';
      this.resultText = '${this.fail}';
    } else if (result > 9) {
      if (this.result == '') {
        this.name = 'SUCCESS';
        this.resultText = '${this.success}';
      } else {
        this.name = 'SUCCESS';
        this.resultText = '';
      }
    } else {
      if (this.result == '') {
        this.name = 'HALF SUCCESS';
        this.resultText = '${this.halfSuccess}';
      } else {
        this.name = 'HALF SUCCESS';
        this.resultText = '';
      }
    }
  }

  Option copyOption() {
    Option newOption = new Option(this.name, this.description, this.success,
        this.halfSuccess, this.fail, this.result, this.value);

    return newOption;
  }

  Option(this.name, this.description, this.success, this.halfSuccess, this.fail,
      this.result, this.value);
}
