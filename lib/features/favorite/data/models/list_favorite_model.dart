import 'package:aumall/features/favorite/domain/entities/list_favorite_entity.dart';

import '../../../shopping/data/models/products_model.dart';

class ListFavoriteModel extends ListFavoriteEntity {
  const ListFavoriteModel(super.listFavorite);

  factory ListFavoriteModel.fromJson(Map<String, dynamic> json) {
    List<ProductAuMallModel> list = List<ProductAuMallModel>.from(
        json['data']['data'].map((x) => ProductAuMallModel.fromJson(x)));
    return ListFavoriteModel(list);
  }
}
