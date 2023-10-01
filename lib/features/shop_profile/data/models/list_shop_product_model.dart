import 'package:aumall/features/shop_profile/data/models/shop_product_model.dart';
import 'package:aumall/features/shop_profile/domain/entities/list_shop_product_entity.dart';

class ListShopProductsModel extends ListShopProductsEntity {

  ListShopProductsModel(super.shopProductEntities);

  factory ListShopProductsModel.fromJson(Map<String, dynamic> json) {
    return ListShopProductsModel(
      List<ShopProductModel>.from(
          json['products'].map((x) => ShopProductModel.fromJson(x))),
    );
  }
}

