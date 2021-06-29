import 'package:generalshops/exceptions/exceptions.dart';
import 'package:generalshops/review/reviewer.dart';

class ProductReview {
  int review_id;
  String review, stars;

  Reviewer reviewer;

  ProductReview(this.review_id, this.stars, this.review, this.reviewer);

  ProductReview.fromJson(Map<String, dynamic> jsonObject) {
    assert(jsonObject['review_id'] != null, 'Product Reviewer  ID is null');
    assert(jsonObject['stars'] != null, 'Product Reviewer Stars is null');
    assert(jsonObject['review'] != null, 'Product Reviewer Review is null');
    assert(jsonObject['reviewer'] != null, 'Product Reviewer Reviewer is null');

    if (jsonObject['review_id'] == null) {
      throw PropertyIsRequired('Product Reviewer ID');
    }
    if (jsonObject['stars'] == null) {
      throw PropertyIsRequired('Product Reviewer Stars');
    }
    if (jsonObject['review'] == null) {
      throw PropertyIsRequired('Product Reviewer Review');
    }
    if (jsonObject['reviewer'] == null) {
      throw PropertyIsRequired('Product Reviewer  Reviewer');
    }

    this.review_id = jsonObject['review_id'];
    this.stars = jsonObject['stars'];
    this.review = jsonObject['review'];
    //this.reviewer = jsonObject['reviewer'];
    this.reviewer = Reviewer.fromJson(jsonObject['reviewer']);
  }
}
