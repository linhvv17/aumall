import '../../../../core/local/shared_preference.dart';
import '../../../../core/network/api_provider.dart';
import '../../../../core/utilities/endpoints.dart';
import '../models/list_product_in_cart_model.dart';

abstract class CartDatasource {
  Future<ListProductInCartModel> getListProductInCart();
  Future<bool> removeProductInCart(int idProduct);
  Future<bool> addProductToCart(int idProduct, int quantity);
  Future<bool> updateProductToCart(int idProduct, int quantity);
}

class CartDatasourceImpl implements CartDatasource {
  final APIProvider apiProvider;
  CartDatasourceImpl(this.apiProvider);
  @override
  Future<ListProductInCartModel> getListProductInCart() async {
    final response = await apiProvider.get(
        endPoint: cartDetailProductsAuMall,
        token:
            PreferenceHelper.getDataFromSharedPreference(key: 'token') ?? '');
    return ListProductInCartModel.fromJson(response.data);
  }

  @override
  Future<bool> removeProductInCart(int idProduct) async {
    final response = await apiProvider.post(
      endPoint: "$removeProductsInCartAuMall/$idProduct",
      token: PreferenceHelper.getDataFromSharedPreference(key: 'token') ?? '',
    );

    return response.statusCode == 200 ? true : false;
  }

  @override
  Future<bool> addProductToCart(int idProduct, int quantity) async {
    final dataSend = <String, dynamic>{
      "product_id": idProduct,
      "quantity": quantity
    };
    final response = await apiProvider.post(
        endPoint: cartProductsAuMall,
        token: PreferenceHelper.getDataFromSharedPreference(key: 'token') ?? '',
        data: dataSend);

    return response.statusCode == 200 ? true : false;
  }

  @override
  Future<bool> updateProductToCart(int idProduct, int quantity) async {
    final dataSend = <String, dynamic>{
      "product_id": idProduct,
      "quantity": quantity,
      "type": 1
    };
    final response = await apiProvider.post(
        endPoint: cartProductsAuMall,
        token: PreferenceHelper.getDataFromSharedPreference(key: 'token') ?? '',
        data: dataSend);

    return response.statusCode == 200 ? true : false;
  }
}
