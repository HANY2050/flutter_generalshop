import 'package:flutter/cupertino.dart';
import 'package:generalshops/product/product.dart';

class Cart1 extends ChangeNotifier {
  List<Product> _products = [];
  int _totalPrice = 0;

  void add(Product products) {
    _products.add(products);
    _totalPrice += products.product_price;
    notifyListeners();
  }

  void remove(Product products) {
    _totalPrice -= products.product_price;
    _products.remove(products);
    notifyListeners();
  }

  int get count {
    return _products.length;
  }

  int get totalPrice {
    return _totalPrice;
  }

  List<Product> get basketItems {
    return _products;
  }
}
