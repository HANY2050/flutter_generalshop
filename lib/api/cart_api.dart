import 'dart:convert';

import 'package:generalshops/cart/cart.dart';
import 'package:generalshops/exceptions/exceptions.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import 'api_util.dart';

class CartApi {
  Future<Cart> fetchCart() async {
    await checkInternet();

    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String apiToken = sharedPreferences.get('api_token');
    Map<String, String> authHeaders = {
      'Accept': 'application/json',
      'Authorization': 'Bearer ' + apiToken
    };
    String cartApi = ApiUtl.CART;
    http.Response response =
        await http.get(Uri.parse(cartApi), headers: authHeaders);

    switch (response.statusCode) {
      case 200:
        var body = jsonDecode(response.body);

        return Cart.fromJson(body);

        break;
      default:
        throw ResourceNotFound('Cart');
        break;
    }
  }

  Future<bool> removeProductFromCart(int productID) async {
    await checkInternet();
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String apiToken = sharedPreferences.get('api_token');
    String cartApi =
        ApiUtl.REMOVE_FROM_CART + '/' + productID.toString() + '/remove';
    Map<String, String> authHeaders = {
      'Accept': 'application/json',
      'Authorization': 'Bearer ' + apiToken
    };
    Map<String, dynamic> body = {
      'product_id': productID.toString(),
      'qty': 1.toString()
    };

    http.Response response =
        await http.post(Uri.parse(cartApi), headers: authHeaders, body: body);

    switch (response.statusCode) {
      case 200:
      case 201:
        return true;
        break;
      default:
        break;
    }
  }

  Future<bool> DeleteAllCarts(int id) async {
    await checkInternet();
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String apiToken = sharedPreferences.get('api_token');
    String cartApi = ApiUtl.DELETE_ALL_CART +
        '/' +
        id.toString() +
        '/delete?product_id=' +
        id.toString();

    Map<String, String> authHeaders = {
      'Accept': 'application/json',
      'Authorization': 'Bearer ' + apiToken
    };
    Map<String, dynamic> body = {
      'product_id': id.toString(),
      /*'qty': 1.toString()*/
    };

    http.Response response =
        await http.delete(Uri.parse(cartApi), headers: authHeaders);

    switch (response.statusCode) {
      case 200:
      case 201:
        return true;
        break;
      default:
        break;
    }
  }

  Future<bool> DeleteOneCarts(int id) async {
    await checkInternet();
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String apiToken = sharedPreferences.get('api_token');
    String cartApi = ApiUtl.DELETE_One_CART + '/' + id.toString() + '/deleteOn';
    print(cartApi);
    Map<String, String> authHeaders = {
      'Accept': 'application/json',
      'Authorization': 'Bearer ' + apiToken
    };
    Map<String, dynamic> body = {
      'product_id': id.toString(),
      /*'qty': 1.toString()*/
    };

    http.Response response =
        await http.delete(Uri.parse(cartApi), headers: authHeaders);

    switch (response.statusCode) {
      case 200:
      case 201:
        return true;
        break;
      default:
        break;
    }
  }

  Future<bool> addProductToCart(int productID) async {
    await checkInternet();

    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String apiToken = sharedPreferences.get('api_token');
    String cartApi = ApiUtl.CART;
    Map<String, String> authHeaders = {
      'Accept': 'application/json',
      'Authorization': 'Bearer ' + apiToken
    };
    Map<String, dynamic> body = {
      'product_id': productID.toString(),
      'qty': 1.toString()
    };

    http.Response response =
        await http.post(Uri.parse(cartApi), headers: authHeaders, body: body);

    switch (response.statusCode) {
      case 200:
      case 201:
        return true;
        break;
      default:
        throw ResourceNotFound('Cart');
        break;
    }
  }
}
