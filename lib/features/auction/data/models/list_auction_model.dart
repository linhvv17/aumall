import '../../../shopping/data/models/products_model.dart';
import '../../domain/entities/list_auction_entity.dart';

class ListAuctionModel extends ListAuctionEntity {
  const ListAuctionModel(super.listAuction);

  factory ListAuctionModel.fromJson(Map<String, dynamic> json) {
    List<ProductAuMallModel> list = List<ProductAuMallModel>.from(
        json['data']['data'].map((x) => ProductAuMallModel.fromJson(x)));
    return ListAuctionModel(list);
  }
}
