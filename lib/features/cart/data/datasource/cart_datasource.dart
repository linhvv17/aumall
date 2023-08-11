
import '../../../../core/network/api_provider.dart';
import '../models/product_in_cart_model.dart';

abstract class CartDatasource {
  Future<ProductInCartModel> getCartData();

}

class CartDatasourceImpl implements CartDatasource {
  final APIProvider apiProvider;

  CartDatasourceImpl(this.apiProvider);

  @override
  Future<ProductInCartModel> getCartData() {

  }

}






