import 'package:aumall/core/error/error_handler.dart';
import 'package:aumall/core/error/failure.dart';
import 'package:aumall/core/network/network_info.dart';
import 'package:aumall/features/favorite/data/datasources/favorite_datasource.dart';
import 'package:aumall/features/favorite/domain/entities/list_favorite_entity.dart';
import 'package:aumall/features/favorite/domain/entities/product/products_order_by_shop_entity.dart';
import 'package:aumall/features/favorite/domain/repositories/favorite_product_repository.dart';
import 'package:aumall/generated/l10n.dart';
import 'package:dartz/dartz.dart';

class FavoriteRepositoryImpl extends FavoriteBaseRepository {
  final NetworkInfo networkInfo;
  final FavoriteDatasource favoriteDatasource;
  FavoriteRepositoryImpl(this.networkInfo, this.favoriteDatasource);

  @override
  Future<Either<Failure, List<ProductsOrderByShopEntity>>> getFavoriteList() async {
    if (await networkInfo.isConnected) {
      try {
        final data = await favoriteDatasource.getListFavorite();
        print("FavoriteRepositoryImpl getFavoriteList() try ${data}");
        return right(data);
      } catch (error) {
        print("FavoriteRepositoryImpl getFavoriteList() catch ${error}");
        return Left(ErrorHandler.handle(error).failure);
      }
    } else {
      return Left(OfflineFailure(S.current.noInternetError));
    }
  }

  @override
  Future<Either<Failure, bool>> removeFavoriteProduct(int idProduct) async {
    if (await networkInfo.isConnected) {
      try {
        final data = await favoriteDatasource.removeFavoriteProduct(idProduct);
        print("FavoriteRepositoryImpl getFavoriteList() try ${data}");
        return right(data);
      } catch (error) {
        print("FavoriteRepositoryImpl getFavoriteList() catch ${error}");
        return Left(ErrorHandler.handle(error).failure);
      }
    } else {
      return Left(OfflineFailure(S.current.noInternetError));
    }
  }

  @override
  Future<Either<Failure, bool>> addFavoriteProduct(int idProduct) async {
    if (await networkInfo.isConnected) {
      try {
        final data = await favoriteDatasource.addFavoriteProduct(idProduct);
        print("FavoriteRepositoryImpl getFavoriteList() try ${data}");
        return right(data);
      } catch (error) {
        print("FavoriteRepositoryImpl getFavoriteList() catch ${error}");
        return Left(ErrorHandler.handle(error).failure);
      }
    } else {
      return Left(OfflineFailure(S.current.noInternetError));
    }
  }
}
