import '../../../shopping/data/models/products_model.dart';
import '../../domain/entities/list_auction_entity.dart';

class ListAuctionModel extends ListAuctionEntity {
  const ListAuctionModel(super.listAuction);

  factory ListAuctionModel.fromJson(Map<String, dynamic> json) {
    print("ListAuctionModel.fromJson json${json}");
    print("ListAuctionModel.fromJson json data ${json['data']}");

    List<ProductAuMallModel> list = List<ProductAuMallModel>.from(
        json['data']['data'].map((x) => ProductAuMallModel.fromJson(x)));

    print(
        "ListAuctionModel.fromJson json data List<ProductAuctionModel> ${list}");
    print(
        "ListAuctionModel.fromJson json data List<ProductAuctionModel> ${list.length}");
    return ListAuctionModel(list);
  }
}
