class Option {
  String optionName;

  List<String> options;
  Option(this.optionName, this.options);
  Option.fromJson(Map<String, dynamic> jsonObject) {
    this.options = jsonObject['options'];
    this.optionName = jsonObject['optionName'];
  }
}
