import 'package:aumall/features/shopping/domain/entities/product/product_entity.dart';
import 'package:aumall/features/shopping/domain/entities/product/shop_entity.dart';

class ProductsOrderByShopEntity {
  final ShopEntity shopEntity;
  final List<ProductEntity> products;

  ProductsOrderByShopEntity(this.shopEntity, this.products);
}
