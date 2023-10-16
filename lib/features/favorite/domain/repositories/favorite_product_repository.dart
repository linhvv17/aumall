import 'package:aumall/core/error/failure.dart';
import 'package:aumall/features/favorite/domain/entities/product/products_order_by_shop_entity.dart';
import 'package:dartz/dartz.dart';
abstract class FavoriteBaseRepository {
  Future<Either<Failure, List<ProductsOrderByShopEntity>>> getFavoriteList();
  Future<Either<Failure, bool>> removeFavoriteProduct(int idProduct);
  Future<Either<Failure, bool>> addFavoriteProduct(int idProduct);
}

class GetFavoriteParams {
  final int id;
  GetFavoriteParams({required this.id});
}
