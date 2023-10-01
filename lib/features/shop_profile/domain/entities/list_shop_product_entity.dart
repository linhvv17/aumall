import 'package:aumall/features/shop_profile/domain/entities/shop_product_entity.dart';
import 'package:equatable/equatable.dart';


class ListShopProductsEntity {
  final List<ShopProductEntity> shopProductEntities;

  ListShopProductsEntity(this.shopProductEntities);
}
