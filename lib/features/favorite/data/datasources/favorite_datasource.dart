import '../../../../core/local/shared_preference.dart';
import '../../../../core/network/api_provider.dart';
import '../../../../core/utilities/endpoints.dart';
import '../models/list_favorite_model.dart';

abstract class FavoriteDatasource {
  Future<ListFavoriteModel> getListFavorite();
  Future<bool> removeFavoriteProduct(int idProduct);
  Future<bool> addFavoriteProduct(int idProduct);
}

class FavoriteDatasourceImpl implements FavoriteDatasource{
  final APIProvider apiProvider;
  FavoriteDatasourceImpl(this.apiProvider);
  @override
  Future<ListFavoriteModel> getListFavorite() async{
    final response = await apiProvider.get(
        endPoint: favoriteProductsAuMall,
        token: PreferenceHelper.getDataFromSharedPreference(key: 'token') ?? '');
    return ListFavoriteModel.fromJson(
        response.data
    );
  }

  @override
  Future<bool> removeFavoriteProduct(int idProduct) async {
    final dataSend = <String, dynamic> {
      "product_id": idProduct,
       "type" : 2
    };
    final response = await apiProvider.post(
        endPoint: favoriteProductsAuMall,
        token: PreferenceHelper.getDataFromSharedPreference(key: 'token') ?? '',
      data: dataSend
    );

    return response.statusCode == 200 ? true : false ;
  }

  @override
  Future<bool> addFavoriteProduct(int idProduct) async {
    final dataSend = <String, dynamic> {
      "product_id": idProduct,
      "type" : 1
    };
    final response = await apiProvider.post(
        endPoint: favoriteProductsAuMall,
        token: PreferenceHelper.getDataFromSharedPreference(key: 'token') ?? '',
        data: dataSend
    );

    return response.statusCode == 200 ? true : false ;
  }

}