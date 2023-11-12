
import '../../domain/entities/shop_item_cart_entity.dart';

class ShopItemCartModel extends ShopItemCartEntity {
  const ShopItemCartModel(super.id, super.user_id, super.name, super.banner,
      super.image, super.created_at, super.banner_url, super.image_url);

  factory ShopItemCartModel.fromJson(Map<String, dynamic> json) => ShopItemCartModel(
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
