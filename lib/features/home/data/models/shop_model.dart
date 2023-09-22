import 'package:aumall/features/home/domain/entities/shop_entity.dart';

class ShopModel extends ShopEntity {
  const ShopModel({
    super.id, super.name, super.user_id, super.banner, super.image, super.created_at, super.banner_url, super.image_url,
} );

  factory ShopModel.fromJson(Map<String, dynamic> json){
    return ShopModel(
        id : json["id"],
        name : json["name"] ?? '',
        user_id : json["user_id"],
        banner : json["banner"]?? '',
        image : json["image"]?? '',
        created_at : json["created_at"]?? '',
        banner_url : json["banner_url"]?? '',
        image_url : json["image_url"]?? ''
    );
  }
}