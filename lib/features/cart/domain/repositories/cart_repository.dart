import 'package:aumall/core/error/failure.dart';
import 'package:dartz/dartz.dart';
import '../entities/list_product_in_cart_entity.dart';
import '../entities/products_in_cart_order_by_shop_entity.dart';

abstract class CartBaseRepository {
  Future<Either<Failure, List<ProductsInCartOrderByShopEntity>>> getProductInCartList();
  Future<Either<Failure, bool>> removeProductInCart(int idProduct);
  Future<Either<Failure, bool>> addProductToCart(int idProduct, int quantity);
  Future<Either<Failure, bool>> updateProductToCart(
      int idProduct, int quantity);
}

class GetFavoriteParams {
  final int id;
  GetFavoriteParams({required this.id});
}
