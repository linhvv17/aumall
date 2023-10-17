import 'package:aumall/features/auction/data/models/auction_session_info_model.dart';

import '../../../../core/local/shared_preference.dart';
import '../../../../core/network/api_provider.dart';
import '../../../../core/utilities/endpoints.dart';
import '../../../auction/data/models/product/products_order_by_shop_model.dart';
import '../../domain/repositories/auction_product_repository.dart';
import '../models/list_auction_model.dart';

abstract class AuctionDatasource {
  Future<List<ProductsOrderByShopModel>> getListAuction(GetAuctionParams getAuctionParams);
  Future<AuctionSessionInfoModel> getAuctionSessionInfo(
      GetAuctionSessionInfoParams getAuctionSessionInfoParams);
  Future<bool> removeAuctionProduct(int idProduct);
  Future<bool> addAuctionProduct(int idProduct);
  Future<bool> actionAuction(int idProduct, String price);
}

class AuctionDatasourceImpl implements AuctionDatasource {
  final APIProvider apiProvider;
  AuctionDatasourceImpl(this.apiProvider);
  @override
  Future<List<ProductsOrderByShopModel>> getListAuction(
      GetAuctionParams getAuctionParams) async {
    final response = await apiProvider.get(
        endPoint: auctionProductsAuMall,
        token: PreferenceHelper.getDataFromSharedPreference(key: 'token') ?? '',
        query: <String, dynamic>{
          'status': '1',
          'auction_type': getAuctionParams.typeAuction,
        });
    List<ProductsOrderByShopModel> listProductsOrderByShopModel =
    List<ProductsOrderByShopModel>.from(
        response.data['data']['data'].map((x) => ProductsOrderByShopModel.fromJson(x)));
    return listProductsOrderByShopModel;
  }

  @override
  Future<bool> removeAuctionProduct(int idProduct) async {
    final dataSend = <String, dynamic>{"product_id": idProduct, "type": 2};
    final response = await apiProvider.post(
        endPoint: allProductsAuMall,
        token: PreferenceHelper.getDataFromSharedPreference(key: 'token') ?? '',
        data: dataSend);

    return response.statusCode == 200 ? true : false;
  }

  @override
  Future<bool> addAuctionProduct(int idProduct) async {
    final dataSend = <String, dynamic>{"product_id": idProduct, "type": 1};
    final response = await apiProvider.post(
        endPoint: allProductsAuMall,
        token: PreferenceHelper.getDataFromSharedPreference(key: 'token') ?? '',
        data: dataSend);

    return response.statusCode == 200 ? true : false;
  }

  @override
  Future<AuctionSessionInfoModel> getAuctionSessionInfo(
      GetAuctionSessionInfoParams getAuctionSessionInfoParams) async {
    final response = await apiProvider.get(
        endPoint: userAuctionProductsAuMall,
        token: PreferenceHelper.getDataFromSharedPreference(key: 'token') ?? '',
        query: <String, dynamic>{
          'status': '1',
          'product_id': getAuctionSessionInfoParams.productAuctionId,
        });
    return AuctionSessionInfoModel.fromJson(response.data['data']);
  }

  @override
  Future<bool> actionAuction(int idProduct, String price) async {
    final dataSend = <String, dynamic>{
      "product_id": idProduct,
      "price": double.parse(price).toInt()
      // "price" : 2925000000
    };
    final response = await apiProvider.post(
        endPoint: submitAuctionAuMall,
        token: PreferenceHelper.getDataFromSharedPreference(key: 'token') ?? '',
        data: dataSend);

    return response.statusCode == 200 ? true : false;
  }
}
