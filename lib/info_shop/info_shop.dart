import 'package:generalshops/exceptions/exceptions.dart';

class InfoShop {
  int info_shop_id;
  /* String info_shop_user_id;*/
  String info_shop_shop_name;
  String info_shop_image_profile;

  InfoShop(
    this.info_shop_id,
    /* this.info_shop_user_id,*/
    this.info_shop_shop_name,
    this.info_shop_image_profile,
  );

  InfoShop.fromJson(Map<String, dynamic> jsonObject) {
    assert(jsonObject['info_shop_id'] != null, 'Shop   ID is null');
    /*  assert(jsonObject['info_shop_user_id'] != null, 'Shop User ID is null');*/
    assert(jsonObject['info_shop_shop_name'] != null, 'Shop name is null');
    assert(jsonObject['info_shop_image_profile'] != null, 'Image is null');

    if (jsonObject['info_shop_id'] == null) {
      throw PropertyIsRequired('Shop ID');
    }
    if (jsonObject['info_shop_user_id'] == null) {
      throw PropertyIsRequired('Shop UserID');
    }
    if (jsonObject['info_shop_shop_name'] == null) {
      throw PropertyIsRequired('Shop name');
    }
    if (jsonObject['info_shop_image_profile'] == null) {
      throw PropertyIsRequired('Shop Image');
    }
    this.info_shop_id = jsonObject['info_shop_id'];
    /*this.info_shop_user_id = jsonObject['info_shop_user_id'];*/
    this.info_shop_shop_name = jsonObject['info_shop_shop_name'];
    this.info_shop_image_profile = jsonObject['info_shop_image_profile'];
  }
}
