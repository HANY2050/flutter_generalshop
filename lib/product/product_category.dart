import 'package:generalshops/exceptions/exceptions.dart';

class ProductCategory {
  int category_id;
  String category_name;
  String image;

  ProductCategory(
    this.category_id,
    this.category_name,
    this.image,
  );

  ProductCategory.fromJson(Map<String, dynamic> jsonObject) {
    assert(jsonObject['category_id'] != null, 'Category   ID is null');
    assert(jsonObject['category_name'] != null, 'Category Name is null');
    assert(jsonObject['image'] != null, 'Category Image is null');

    if (jsonObject['category_id'] == null) {
      throw PropertyIsRequired('Category ID');
    }
    if (jsonObject['category_name'] == null) {
      throw PropertyIsRequired('Category Name');
    }
    if (jsonObject['image'] == null) {
      throw PropertyIsRequired('Category Image');
    }
    this.category_id = jsonObject['category_id'];
    this.category_name = jsonObject['category_name'];
    this.image = jsonObject['image'];
  }
}
