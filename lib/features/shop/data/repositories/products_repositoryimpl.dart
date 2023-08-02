import 'package:aumall/features/home/domain/entities/product_detail_entity.dart';
import 'package:aumall/features/shop/domain/entities/categories_entity.dart';
import 'package:aumall/features/shop/domain/entities/shop_data_default_entity.dart';
import 'package:aumall/features/shop/domain/usecases/get_specific_product.dart';
import 'package:dartz/dartz.dart';
import 'package:aumall/features/shop/domain/entities/reviews_entity.dart';
import '../../../../core/error/error_handler.dart';
import '../../../../core/error/failure.dart';
import '../../../../core/network/network_info.dart';
import '../../../../core/utilities/strings.dart';
import '../../../../generated/l10n.dart';
import '../../domain/entities/list_product_shop_entity.dart';
import '../../domain/entities/products_entity.dart';
import '../../domain/entities/response_entity.dart';
import '../../domain/repositories/product_repository.dart';
import '../datasources/products_datasource.dart';

class ProductsRepositoryImpl implements ProductRepository {
  final NetworkInfo networkInfo;
  final ProductsDatasource productsDatasource;

  ProductsRepositoryImpl(this.networkInfo, this.productsDatasource);
  @override
  Future<Either<Failure, ProductsEntity>> getAllProducts() async {
    if (await networkInfo.isConnected) {
      try {
        // final data = await productsDatasource.getAllProducts();
        // final dataCheck = productsDatasource.getAllProductsAuMall();
        final data = await productsDatasource.getAllProductsFromTxt();
        return right(data);
      } catch (error) {
        return left(ErrorHandler.handle(error).failure);
      }
    } else {
      return  Left(OfflineFailure(S.current.noInternetError));
    }
  }


  @override
  Future<Either<Failure, ResponseEntity>> sendReview(
      SendReviewParams params) async {
    if (await networkInfo.isConnected) {
      try {
        final data = await productsDatasource.sendReview(params);
        return right(data);
      } catch (error) {
        print(error);
        return left(ErrorHandler.handle(error).failure);
      }
    } else {
      return left( OfflineFailure(S.current.noInternetError));
    }
  }

  @override
  Future<Either<Failure, GetReviewsEntity>> getReviews(
      GetReviewsParams params) async {
    if (await networkInfo.isConnected) {
      try {
        final data = await productsDatasource.getReviews(params);
        return right(data);
      } catch (error) {
        print(error);
        return left(ErrorHandler.handle(error).failure);
      }
    } else {
      return left( OfflineFailure(S.current.noInternetError));
    }
  }

  @override
  Future<Either<Failure, CategoriesEntity>> getShopDefaultData() async  {
    if (await networkInfo.isConnected) {
      try {
        // print('getShopDefaultData: ${getShopDataDefaultParams.categoryId}');
        final data = await productsDatasource.getShopDefaultData();
        // final data = await productsDatasource.getSpecificProductFromTxt(params);
        return right(data);
      } catch (error) {
        return left(ErrorHandler.handle(error).failure);
      }
    } else {
      return left( OfflineFailure(S.current.noInternetError));
    }
  }

  @override
  Future<Either<Failure, ListProductShopEntity>> getListProductByCategory(GetShopDataDefaultParams getShopDataDefaultParams) async {
    if (await networkInfo.isConnected) {
      try {
        print('getListProductByCategory: ${getShopDataDefaultParams.categoryId}');
        final data = await productsDatasource.getListProductByCategory(getShopDataDefaultParams);
        // final data = await productsDatasource.getSpecificProductFromTxt(params);
        return right(data);
      } catch (error) {
        return left(ErrorHandler.handle(error).failure);
      }
    } else {
      return left( OfflineFailure(S.current.noInternetError));
    }
  }

  @override
  Future<Either<Failure, ShopDataDefaultEntity>> getShopDataDefault() async {
    if (await networkInfo.isConnected) {
      try {
        final data = await productsDatasource.getShopDataDefault();
        return right(data);
      } catch (error) {
        return left(ErrorHandler.handle(error).failure);
      }
    } else {
      return left( OfflineFailure(S.current.noInternetError));
    }
  }

  @override
  Future<Either<Failure, ListProductShopEntity>> changeCategory(ChangeCategoryUseCaseParams changeCategoryUseCaseParams) async {
    if (await networkInfo.isConnected) {
      try {
        final data = await productsDatasource.changCategory(changeCategoryUseCaseParams);
        return right(data);
      } catch (error) {
        return left(ErrorHandler.handle(error).failure);
      }
    } else {
      return left( OfflineFailure(S.current.noInternetError));
    }
  }

  @override
  Future<Either<Failure, ListProductShopEntity>> searchProducts(SearchProductsUseCaseParams searchProductsUseCaseParams)async {
    if (await networkInfo.isConnected) {
      try {
        final data = await productsDatasource.searchProducts(searchProductsUseCaseParams);
        return right(data);
      } catch (error) {
        return left(ErrorHandler.handle(error).failure);
      }
    } else {
      return left( OfflineFailure(S.current.noInternetError));
    }
  }

  @override
  Future<Either<Failure, ListProductShopEntity>> getProductByFilter(GetProductByFilterUseCaseParams params) async {
    if (await networkInfo.isConnected) {
      try {
        final data = await productsDatasource.getProductsByFilter(params);
        return right(data);
      } catch (error) {
        return left(ErrorHandler.handle(error).failure);
      }
    } else {
      return left( OfflineFailure(S.current.noInternetError));
    }
  }

  @override
  Future<Either<Failure, ListProductShopEntity>> getProductsByType(GetProductsByTypeUseCaseParams getProductsByTypeUseCaseParams) async {
    if (await networkInfo.isConnected) {
      try {
        final data = await productsDatasource.getProductsByType(getProductsByTypeUseCaseParams);
        return right(data);
      } catch (error) {
        return left(ErrorHandler.handle(error).failure);
      }
    } else {
      return left( OfflineFailure(S.current.noInternetError));
    }
  }


}
