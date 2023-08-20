import 'package:aumall/features/shop/domain/entities/categories_entity.dart';
import 'package:aumall/features/shop/domain/entities/list_product_shop_entity.dart';
import 'package:aumall/features/shop/domain/entities/products_entity.dart';
import 'package:equatable/equatable.dart';

class ShopDataDefaultEntity extends Equatable {
  final CategoriesEntity categoriesEntity;
  final ListProductShopEntity listProductAuMall;

  const ShopDataDefaultEntity(this.categoriesEntity, this.listProductAuMall);

  @override
  List<Object?> get props => [categoriesEntity, listProductAuMall];
}
