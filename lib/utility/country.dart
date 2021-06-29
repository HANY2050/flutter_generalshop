import 'package:generalshops/exceptions/exceptions.dart';

class Country {
  int country_id;
  String country_name, country_capital, currency;

  Country(
      this.country_id, this.country_name, this.country_capital, this.currency);

  Country.fromJson(Map<String, dynamic> jsonObject) {
    assert(jsonObject['country_id'] != null, 'Country ID is null');
    assert(jsonObject['country_name'] != null, 'Country Name is null');
    assert(jsonObject['country_capital'] != null, 'Country Capital is null');
    assert(jsonObject['currency'] != null, 'Country Currency is null');

    if (jsonObject['country_id'] == null) {
      throw PropertyIsRequired('Country ID');
    }
    if (jsonObject['country_name'] == null) {
      throw PropertyIsRequired('Country Name');
    }
    if (jsonObject['country_capital'] == null) {
      throw PropertyIsRequired('Country Capital');
    }
    if (jsonObject['currency'] == null) {
      throw PropertyIsRequired('Country Currency');
    }

    this.country_id = jsonObject['country_id'];
    this.country_name = jsonObject['country_name'];
    this.country_capital = jsonObject['country_capital'];
    this.currency = jsonObject['currency'];
  }
}
