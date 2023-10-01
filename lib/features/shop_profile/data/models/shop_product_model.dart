import 'package:aumall/features/shop_profile/domain/entities/shop_profile_entity.dart';

import '../../domain/entities/shop_product_entity.dart';

class ShopProductModel extends ShopProductEntity {
  const ShopProductModel(super.id, super.title, super.description,
      super.thumbnailUrl, super.price);

  factory ShopProductModel.fromJson(Map<String, dynamic> json) {
    return ShopProductModel(
        json['id'],
        json['title'].toString(),
        json['description'].toString(),
        json['thumbnail_url'].toString(),
        json['price'].toString()
    );
  }

}
