import 'package:aumall/features/favorite/domain/entities/list_favorite_entity.dart';
import 'package:aumall/features/home/data/models/detail_product_response.dart';

import '../../../shop/data/models/products_model.dart';
import '../../domain/entities/list_product_shop_entity.dart';

class ListShopProductsModel extends ListProductShopEntity {
  const ListShopProductsModel(super.listProductAuMall);

  factory ListShopProductsModel.fromJson(Map<String, dynamic> json) {
    print("ListShopProductsModel.fromJson json${json}");
    print("ListShopProductsModel.fromJson json data ${json['data']}");

    List<ProductAuMallModel> list = List<ProductAuMallModel>.from(
        json['data']['data'].map((x) => ProductAuMallModel.fromJson(x)));

    // Shop shop = Shop.fromJson(json['data']['data']['user']['shop']);
    print(
        "ListShopProductsModel.fromJson json shop shop shop shop shop ${json['data']['data']}");
    print(
        "ListShopProductsModel.fromJson json data List<ProductAuMallModel> ${list}");
    print(
        "ListShopProductsModel.fromJson json data List<ProductAuMallModel> ${list.length}");
    return ListShopProductsModel(list);
  }
}
