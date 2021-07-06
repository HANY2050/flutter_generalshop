import 'dart:convert';

import 'package:generalshops/api/api_util.dart';
import 'package:generalshops/exceptions/exceptions.dart';
import 'package:generalshops/product/product_category.dart';
import 'package:generalshops/product/product_tag.dart';
import 'package:generalshops/utility/country.dart';
import 'package:generalshops/utility/country_city.dart';
import 'package:generalshops/utility/country_state.dart';
import 'package:http/http.dart' as http;

class HelpersApi {
  Map<String, String> headers = {'Accept': 'application/json'};

  Future<List<ProductCategory>> fetchCategories() async {
    await checkInternet();
    String url = ApiUtl.CATEGORIES;
    http.Response response = await http.get(Uri.parse(url), headers: headers);
    //print(url);
    switch (response.statusCode) {
      case 200:
        List<ProductCategory> categories = [];
        if (response.statusCode == 200) {
          var body = jsonDecode(response.body);

          for (var item in body['data']) {
            categories.add(ProductCategory.fromJson(item));
          }
        }
        return categories;
        break;
      case 404:
        throw ResourceNotFound('categories');
        break;
      case 301:
      case 302:
      case 303:
        throw RedirectionNotFound();
        break;
      default:
        return null;
        break;
    }
  }

  Future<List<ProductTag>> fetchTags(int page) async {
    await checkInternet();
    String url = ApiUtl.TAGS + '?page=' + page.toString();

    http.Response response = await http.get(Uri.parse(url), headers: headers);

    switch (response.statusCode) {
      case 200:
        List<ProductTag> tags = [];
        if (response.statusCode == 200) {
          var body = jsonDecode(response.body);
          for (var item in body['data']) {
            tags.add(ProductTag.fromJson(item));
          }
        }
        return tags;
        break;
      case 404:
        throw ResourceNotFound('tags');
        break;

      case 301:
      case 302:
      case 303:
        throw RedirectionNotFound();
        break;
      default:
        return null;
        break;
    }
  }

  Future<List<Country>> fetchCountries(int page) async {
    await checkInternet();
    String url = ApiUtl.COUNTRIES + '?page=' + page.toString();
    http.Response response = await http.get(Uri.parse(url), headers: headers);

    switch (response.statusCode) {
      case 200:
        List<Country> countries = [];
        if (response.statusCode == 200) {
          var body = jsonDecode(response.body);
          for (var item in body['data']) {
            countries.add(Country.fromJson(item));
          }
        }
        return countries;
        break;
      case 404:
        throw ResourceNotFound('countries');
        break;
      case 301:
      case 302:
      case 303:
        throw RedirectionNotFound();
        break;
      default:
        return null;
        break;
    }
  }

  Future<List<CountryState>> fetchStates(int country, int page) async {
    await checkInternet();
    String url = ApiUtl.STATES(country) + '?page=' + page.toString();

    http.Response response = await http.get(Uri.parse(url), headers: headers);

    switch (response.statusCode) {
      case 200:
        List<CountryState> states = [];
        if (response.statusCode == 200) {
          var body = jsonDecode(response.body);
          for (var item in body['data']) {
            states.add(CountryState.fromJson(item));
          }
        }
        return states;
        break;
      case 404:
        throw ResourceNotFound('states');
        break;
      case 301:
      case 302:
      case 303:
        throw RedirectionNotFound();
        break;
      default:
        return null;
        break;
    }
  }

  Future<List<CountryCity>> fetchCities(int country, int page) async {
    await checkInternet();
    String url = ApiUtl.CITIES(country) + '?page=' + page.toString();
    http.Response response = await http.get(Uri.parse(url), headers: headers);

    switch (response.statusCode) {
      case 200:
        List<CountryCity> cities = [];
        if (response.statusCode == 200) {
          var body = jsonDecode(response.body);
          for (var item in body['data']) {
            cities.add(CountryCity.fromJson(item));
          }
        }
        return cities;
        break;
      case 404:
        throw ResourceNotFound('cities');
        break;
      case 301:
      case 302:
      case 303:
        throw RedirectionNotFound();
        break;
      default:
        return null;
        break;
    }
  }
}
