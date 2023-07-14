import 'package:aumall/features/favorite/domain/entities/list_favorite_entity.dart';

import '../../../shop/data/models/products_model.dart';

class ListFavoriteModel extends ListFavoriteEntity {
  const ListFavoriteModel(super.listFavorite);

  factory ListFavoriteModel.fromJson(Map<String, dynamic> json) {
    print("ListFavoriteModel.fromJson json${json}");
    print("ListFavoriteModel.fromJson json data ${json['data']}");

    List<ProductAuMallModel> list
    = List<ProductAuMallModel>.from(
        json['data']['data'].map((x) => ProductAuMallModel.fromJson(x)));

    print("ListFavoriteModel.fromJson json data List<ProductFavoriteModel> ${list}");
    print("ListFavoriteModel.fromJson json data List<ProductFavoriteModel> ${list.length}");
    return ListFavoriteModel(
        list
    );
  }

}