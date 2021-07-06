import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:generalshops/product/product.dart';
import 'package:http/http.dart' as http;

List<Product> parseProduct(String responseBody) {
  var list = json.decode(responseBody)['data'] as List<dynamic>;
  var product = list.map((model) => Product.fromJson(model)).toList();
  return product;
}

Future<List<Product>> fetchProduct() async {
  final responce = await http
      .get(Uri.parse('http://shop.myadeentrading.com/api/showProduct'));
  if (responce.statusCode == 200) {
    return compute(parseProduct, responce.body);
  } else {
    throw Exception('Requset Api Error');
  }
}
