import 'package:aumall/core/error/error_handler.dart';
import 'package:aumall/core/error/failure.dart';
import 'package:aumall/core/network/network_info.dart';
import 'package:aumall/features/cart/data/datasource/cart_datasource.dart';
import 'package:aumall/features/cart/domain/entities/list_product_in_cart_entity.dart';
import 'package:aumall/features/cart/domain/repositories/cart_repository.dart';
import 'package:aumall/features/favorite/data/datasources/favorite_datasource.dart';
import 'package:aumall/features/favorite/domain/entities/list_favorite_entity.dart';
import 'package:aumall/features/favorite/domain/repositories/favorite_product_repository.dart';
import 'package:aumall/generated/l10n.dart';
import 'package:dartz/dartz.dart';

class CartRepositoryImpl extends CartBaseRepository {
  final NetworkInfo networkInfo;
  final CartDatasource cartDatasource;
  CartRepositoryImpl(this.networkInfo, this.cartDatasource);

  @override
  Future<Either<Failure, bool>> addProductToCart(
      int idProduct, int quantity) async {
    if (await networkInfo.isConnected) {
      try {
        final data = await cartDatasource.addProductToCart(idProduct, quantity);
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
  Future<Either<Failure, ListProductInCartEntity>>
      getProductInCartList() async {
    if (await networkInfo.isConnected) {
      try {
        final data = await cartDatasource.getListProductInCart();
        print("CartRepositoryImpl getProductInCartList() try ${data}");
        return right(data);
      } catch (error) {
        print("CartRepositoryImpl getProductInCartList() catch ${error}");
        return Left(ErrorHandler.handle(error).failure);
      }
    } else {
      return Left(OfflineFailure(S.current.noInternetError));
    }
  }

  @override
  Future<Either<Failure, bool>> removeProductInCart(int idProduct) async {
    if (await networkInfo.isConnected) {
      try {
        final data = await cartDatasource.removeProductInCart(idProduct);
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
  Future<Either<Failure, bool>> updateProductToCart(
      int idProduct, int quantity) async {
    if (await networkInfo.isConnected) {
      try {
        final data =
            await cartDatasource.updateProductToCart(idProduct, quantity);
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
