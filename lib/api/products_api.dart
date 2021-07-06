import 'dart:convert';

import 'package:generalshops/api/api_util.dart';
import 'package:generalshops/exceptions/exceptions.dart';
import 'package:generalshops/product/product.dart';
import 'package:http/http.dart' as http;

class ProductsApi {
  Map<String, String> headers = {'Accept': 'application/json'};

  Future<List<Product>> fetchProducts() async {
    await checkInternet();
    String url = ApiUtl.PRODUCTS;
    http.Response response = await http.get(Uri.parse(url), headers: headers);

    List<Product> products = [];
    if (response.statusCode == 200) {
      // print(response.statusCode);
      var body = jsonDecode(response.body);
      for (var item in body['data']) {
        //  print(item);
        products.add(Product.fromJson(item));
      }
      return products;
    }
    return null;
  }

  Future<List<Product>> fetchProductsByCategory(int category) async {
    await checkInternet();
    String url = ApiUtl.CATEGORY_PRODUCTS(category);
    http.Response response = await http.get(Uri.parse(url), headers: headers);

    List<Product> products = [];
    switch (response.statusCode) {
      case 404:
        throw ResourceNotFound('Products');
        break;
      case 301:
      case 302:
      case 303:
        throw RedirectionNotFound();
        break;
      case 200:
        var body = jsonDecode(response.body);
        for (var item in body['data']) {
          // print(item);
          products.add(Product.fromJson(item));
        }
        return products;
        break;
      default:
        return null;
        break;
    }
  }

  Future<Product> fetchProduct(int product_id) async {
    await checkInternet();
    String url = ApiUtl.PRODUCT + product_id.toString();
    http.Response response = await http.get(Uri.parse(url), headers: headers);
    if (response.statusCode == 200) {
      var body = jsonDecode(response.body);
      return Product.fromJson(body['data']);
    }
    return null;
  }
}
