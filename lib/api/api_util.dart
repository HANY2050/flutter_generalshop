import 'package:connectivity/connectivity.dart';
import 'package:generalshops/exceptions/exceptions.dart';

class ApiUtl {
  //local url
  // static const String MAIN_API_URL = "http://127.0.0.1:8000/api/";
  static const String MAIN_API_URL = "http://shop.myadeentrading.com/api/";

  static const String AUTH_REGISTER = MAIN_API_URL + 'auth/register';

  static const String AUTH_LOGIN = MAIN_API_URL + 'auth/login';

  static const String PRODUCTS = MAIN_API_URL + 'products';

  static const String CART = ApiUtl.MAIN_API_URL + 'carts';

  static const String REMOVE_FROM_CART = ApiUtl.MAIN_API_URL + 'carts';

  static const String DELETE_ALL_CART = ApiUtl.MAIN_API_URL + 'carts';

  static const String DELETE_One_CART = ApiUtl.MAIN_API_URL + 'carts';

  static const SEARCH_PRODUCT = ApiUtl.MAIN_API_URL + 'search';

  static String CATEGORY_PRODUCTS(int id) {
    return MAIN_API_URL + 'categories/' + id.toString() + '/products';
  }

  static const String PRODUCT = MAIN_API_URL + 'products/';

  static const String COUNTRIES = MAIN_API_URL + 'countries';

  static String CITIES(int id) {
    return MAIN_API_URL + 'countries/' + id.toString() + '/cities';
  }

  static String STATES(int id) {
    return MAIN_API_URL + 'countries/' + id.toString() + '/states';
  }

  static const String CATEGORIES = MAIN_API_URL + 'categories';

  static const String INFO_SHOP = MAIN_API_URL + 'infoShop';

  static const String TAGS = MAIN_API_URL + 'tags';
}

Future<void> checkInternet() async {
  var connectivityResult = await (Connectivity().checkConnectivity());
  if (connectivityResult != ConnectivityResult.mobile &&
      connectivityResult != ConnectivityResult.wifi) {
    throw NoInternetConnection();
  }
}
