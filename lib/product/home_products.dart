import 'dart:async';

import 'package:generalshops/api/products_api.dart';
import 'package:generalshops/contracts/contracts.dart';
import 'package:generalshops/product/product.dart';

class HomeProductBloc implements Disposable {
  List<Product> products;
  ProductsApi productsApi;
  final StreamController<List<Product>> _productsController =
      StreamController<List<Product>>.broadcast();
  final StreamController<int> _categoryController =
      StreamController<int>.broadcast();

  Stream<List<Product>> get productsStream => _productsController.stream;
  StreamSink<int> get fetchProducts => _categoryController.sink;
  Stream<int> get category => _categoryController.stream;
  int categoryID;

  HomeProductBloc() {
    this.products = [];
    productsApi = ProductsApi();
    _productsController.add(this.products);
    _categoryController.add(this.categoryID);
    _categoryController.stream.listen(_fetchCategoriesFromApi);
  }

  Future<void> _fetchCategoriesFromApi(int category) async {
    this.products = await productsApi.fetchProductsByCategory(category);
    _productsController.add(this.products);
  }

  @override
  void dispose() {
    _productsController.close();
    _categoryController.close();
  }
}
