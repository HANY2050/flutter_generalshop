import 'package:generalshops/exceptions/exceptions.dart';

class Reviewer {
  String first_name, last_name, email, formattedName;
  // String mobile;
  Reviewer(
    this.first_name,
    this.last_name,
    this.email,
    this.formattedName,
    // this.mobile
  );

  Reviewer.fromJson(Map<String, dynamic> jsonObject) {
    assert(jsonObject['first_name'] != null, 'Reviewer First Name is null');
    assert(jsonObject['last_name'] != null, 'Reviewer Last Name is null');
    assert(jsonObject['email'] != null, 'Reviewer Email is null');
    assert(
        jsonObject['formattedName'] != null, 'Reviewer Formatted Name is null');

    if (jsonObject['first_name'] == null) {
      throw PropertyIsRequired('Reviewer First Name');
    }
    if (jsonObject['last_name'] == null) {
      throw PropertyIsRequired('Reviewer Last Name');
    }
    if (jsonObject['email'] == null) {
      throw PropertyIsRequired('Reviewer Email');
    }
    if (jsonObject['formattedName'] == null) {
      throw PropertyIsRequired('Reviewer  Formatted Name');
    }

    this.first_name = jsonObject['first_name'];
    this.last_name = jsonObject['last_name'];
    this.email = jsonObject['email'];
    this.formattedName = jsonObject['formattedName'];
    // this.mobile = jsonObject['mobile'];
  }
}
