import 'dart:convert';

import 'package:generalshops/exceptions/exceptions.dart';
import 'package:generalshops/info_shop/info_shop.dart';
import 'package:http/http.dart' as http;

import 'api_util.dart';

class InfoShopApi {
  Map<String, String> headers = {'Accept': 'application/json'};

  Future<List<InfoShop>> fetchInfoShop(int page) async {
    await checkInternet();
    String url = ApiUtl.INFO_SHOP + '?page=' + page.toString();
    http.Response response = await http.get(Uri.parse(url), headers: headers);
    print(url);
    switch (response.statusCode) {
      case 200:
        List<InfoShop> infoShops = [];
        if (response.statusCode == 200) {
          var body = jsonDecode(response.body);
          print(response.body);
          for (var item in body['data']) {
            infoShops.add(InfoShop.fromJson(item));
          }
        }
        return infoShops;

        break;
      case 404:
        throw ResourceNotFound('infoShops');
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
