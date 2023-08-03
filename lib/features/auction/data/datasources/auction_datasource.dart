import '../../../../core/local/shared_preference.dart';
import '../../../../core/network/api_provider.dart';
import '../../../../core/utilities/endpoints.dart';
import '../../domain/repositories/auction_product_repository.dart';
import '../models/list_auction_model.dart';

abstract class AuctionDatasource {
  Future<ListAuctionModel> getListAuction(GetAuctionParams getAuctionParams);
  Future<bool> removeAuctionProduct(int idProduct);
  Future<bool> addAuctionProduct(int idProduct);
}

class AuctionDatasourceImpl implements AuctionDatasource{
  final APIProvider apiProvider;
  AuctionDatasourceImpl(this.apiProvider);
  @override
  Future<ListAuctionModel> getListAuction(GetAuctionParams getAuctionParams) async{
    final response = await apiProvider.get(
        endPoint: auctionProductsAuMall,
        token: PreferenceHelper.getDataFromSharedPreference(key: 'token') ?? '',
        query: <String, dynamic> {
          'status': '1',
          'auction_type': getAuctionParams.typeAuction,
        }
    );
    return ListAuctionModel.fromJson(
        response.data
    );
  }

  @override
  Future<bool> removeAuctionProduct(int idProduct) async {
    final dataSend = <String, dynamic> {
      "product_id": idProduct,
       "type" : 2
    };
    final response = await apiProvider.post(
        endPoint: allProductsAuMall,
        token: PreferenceHelper.getDataFromSharedPreference(key: 'token') ?? '',
      data: dataSend
    );

    return response.statusCode == 200 ? true : false ;
  }

  @override
  Future<bool> addAuctionProduct(int idProduct) async {
    final dataSend = <String, dynamic> {
      "product_id": idProduct,
      "type" : 1
    };
    final response = await apiProvider.post(
        endPoint: allProductsAuMall,
        token: PreferenceHelper.getDataFromSharedPreference(key: 'token') ?? '',
        data: dataSend
    );

    return response.statusCode == 200 ? true : false ;
  }

}