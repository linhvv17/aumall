import 'package:aumall/features/shopping/data/models/product/products_order_by_shop_model.dart';
import 'package:aumall/features/shopping/domain/entities/product/info_shopping_entity.dart';

class InfoShoppingModel extends InfoShoppingEntity {
  InfoShoppingModel(super.productsOrderByShopEntity);

  factory InfoShoppingModel.fromJson(Map<String, dynamic> json) => InfoShoppingModel(
    ProductsOrderByShopModel.fromJson(json)
  );
}