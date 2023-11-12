
import 'package:aumall/features/cart/domain/entities/shop_item_cart_entity.dart';
import 'list_product_in_cart_entity.dart';

class ProductsInCartOrderByShopEntity {
  final ShopItemCartEntity shopEntity;
  final List<ProductInCartEntity> products;

  ProductsInCartOrderByShopEntity(this.shopEntity, this.products);
}
