import 'package:aumall/features/favorite/domain/entities/list_favorite_entity.dart';

import '../../../shop/data/models/products_model.dart';
import '../../domain/entities/list_product_shop_entity.dart';

class ListShopProductsModel extends ListProductShopEntity {
  const ListShopProductsModel(super.listProductAuMall);

  factory ListShopProductsModel.fromJson(Map<String, dynamic> json) {
    print("ListShopProductsModel.fromJson json${json}");
    print("ListShopProductsModel.fromJson json data ${json['data']}");

    List<ProductAuMallModel> list = List<ProductAuMallModel>.from(
        json['data']['data'].map((x) => ProductAuMallModel.fromJson(x)));

    print(
        "ListShopProductsModel.fromJson json data List<ProductAuMallModel> ${list}");
    print(
        "ListShopProductsModel.fromJson json data List<ProductAuMallModel> ${list.length}");
    return ListShopProductsModel(list);
  }
}
