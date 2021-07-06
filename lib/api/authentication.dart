import 'dart:convert';

import 'package:generalshops/api/api_util.dart';
import 'package:generalshops/customer/user.dart';
import 'package:generalshops/exceptions/exceptions.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import 'api_util.dart';

class Authentication {
  Map<String, String> headers = {'Accept': 'application/json'};
  Future<User> register(String first_name, String last_name, String email,
      String password, String mobile) async {
    await checkInternet();
    Map<String, String> body = {
      'first_name': first_name,
      'last_name': last_name,
      'email': email,
      'mobile': mobile,
      'password': password,
    };
    http.Response response = await http.post(Uri.parse(ApiUtl.AUTH_REGISTER),
        headers: headers, body: body);
    switch (response.statusCode) {
      case 201:
        var body = jsonDecode(response.body);
        var data = body['data'];
        User user = User.fromJson(data);
        await _saveUser(user.user_id, user.api_token);
        return user;

        break;
      case 422:
        throw UnProcessedEntity();
        break;
      default:
        return null;
    }
  }

  Future<User> login(String email, String password) async {
    await checkInternet();
    Map<String, String> body = {
      'email': email,
      'password': password,
    };

    http.Response response = await http.post(Uri.parse(ApiUtl.AUTH_LOGIN),
        headers: headers, body: body);
    print(response);
    switch (response.statusCode) {
      case 200:
        var body = jsonDecode(response.body);
        var data = body['data'];
        User user = User.fromJson(data);
        await _saveUser(user.user_id, user.api_token);
        return user;
        break;
      case 404:
        throw ResourceNotFound('User');
        break;
      case 401:
        throw LoginFailed();
        break;
      case 422:
        throw UnProcessedEntity();
        break;
      default:
        return null;
        break;
    }
  }

//دالة لحفظ المستخدم بعد تسجيل الدخول
  Future<void> _saveUser(int userID, String apiToken) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setInt('user_id', userID);
    sharedPreferences.setString('api_token', apiToken);
  }
}
