import 'package:aumall/features/shopping/data/models/product/product_model.dart';
import 'package:aumall/features/shopping/data/models/product/shop_model.dart';
import 'package:aumall/features/shopping/domain/entities/product/products_order_by_shop_entity.dart';

class ProductsOrderByShopModel extends ProductsOrderByShopEntity {
  ProductsOrderByShopModel(super.shopEntity, super.products);

  factory ProductsOrderByShopModel.fromJson(Map<String, dynamic> json) {
    return ProductsOrderByShopModel(
      ShopModel.fromJson(json),
      List<ProductModel>.from(
          json['products'].map((x) => ProductModel.fromJson(x))),
    );
  }


}
