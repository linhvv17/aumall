import 'package:aumall/features/favorite/domain/entities/product/shop_entity.dart';
import 'package:equatable/equatable.dart';

class ShopModel extends ShopEntity {
  const ShopModel(super.id, super.user_id, super.name, super.banner,
      super.image, super.created_at, super.banner_url, super.image_url);

  factory ShopModel.fromJson(Map<String, dynamic> json) => ShopModel(
        json['id'],
        json['user_id'],
        json['name'],
        json['banner'],
        json['image'],
        json['created_at'].toString(),
        json['banner_url'],
        json['image_url'],
      );
}
