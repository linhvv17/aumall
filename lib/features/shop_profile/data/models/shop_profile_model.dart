import 'package:aumall/features/shop_profile/domain/entities/shop_profile_entity.dart';

class ShopProfileModel extends ShopProfileEntity {
  const ShopProfileModel(
      super.id,
      super.userId,
      super.name,
      super.address,
      super.contact,
      super.description,
      super.banner,
      super.image,
      super.bannerUrl,
      super.imageUrl);

  factory ShopProfileModel.fromJson(Map<String, dynamic> json) =>
      ShopProfileModel(
        json['id'],
        json['user_id'],
        json['name'].toString(),
        json['address'].toString(),
        json['contact'].toString(),
        json['description'].toString(),
        json['banner'].toString(),
        json['image'].toString(),
        json['banner_url'].toString(),
        json['image_url'].toString(),
      );
}
