
import 'package:aumall/features/cart/data/models/shop_item_cart_model.dart';

import '../../domain/entities/products_in_cart_order_by_shop_entity.dart';
import 'list_product_in_cart_model.dart';

class ProductsInCartOrderByShopModel extends ProductsInCartOrderByShopEntity {
  ProductsInCartOrderByShopModel(super.shopEntity, super.products);

  factory ProductsInCartOrderByShopModel.fromJson(Map<String, dynamic> json) {
    return ProductsInCartOrderByShopModel(
      ShopItemCartModel.fromJson(json),
      List<ProductInCartModel>.from(
          json['order_details'].map((x) => ProductInCartModel.fromJson(x))),
    );
  }


}
