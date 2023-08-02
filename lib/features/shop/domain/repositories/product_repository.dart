import 'package:dartz/dartz.dart';
import 'package:aumall/features/shop/domain/entities/reviews_entity.dart';
import '../../../../core/error/failure.dart';
import '../../../home/domain/entities/product_detail_entity.dart';
import '../entities/categories_entity.dart';
import '../entities/list_product_shop_entity.dart';
import '../entities/products_entity.dart';
import '../entities/response_entity.dart';
import '../entities/shop_data_default_entity.dart';
import '../usecases/get_specific_product.dart';

abstract class ProductRepository {
  Future<Either<Failure, ListProductShopEntity>> getListProductByCategory(
      GetShopDataDefaultParams getShopDataDefaultParams
      );
  Future<Either<Failure, CategoriesEntity>> getShopDefaultData(
      // GetShopDataDefaultParams getShopDataDefaultParams
      );
  Future<Either<Failure, ProductsEntity>> getAllProducts();
  Future<Either<Failure, ListProductShopEntity>> getProductByFilter(
      GetProductByFilterUseCaseParams params);
  Future<Either<Failure, ResponseEntity>> sendReview(SendReviewParams params);
  Future<Either<Failure, GetReviewsEntity>> getReviews(GetReviewsParams params);

  Future<Either<Failure, ShopDataDefaultEntity>> getShopDataDefault();
  Future<Either<Failure, ListProductShopEntity>> changeCategory(ChangeCategoryUseCaseParams changeCategoryUseCaseParams);
  Future<Either<Failure, ListProductShopEntity>> searchProducts(SearchProductsUseCaseParams searchProductsUseCaseParams);
  Future<Either<Failure, ListProductShopEntity>> getProductsByType(GetProductsByTypeUseCaseParams getProductsByTypeUseCaseParams);
}


class GetShopDataDefaultParams {
  final String categoryId;
  final String minPrice;
  final String maxPrice;
  final String rate;
  final String keyword;
  GetShopDataDefaultParams(
      this.categoryId, this.minPrice, this.maxPrice, this.rate, this.keyword);
}


class GetProductParams {
  final String category;
  final String minPrice;
  final String maxPrice;
  final String rate;
  final String keyword;
  GetProductParams(
      this.category, this.minPrice, this.maxPrice, this.rate, this.keyword);
}

class SendReviewParams {
  final String productId;
  final String comment;
  final num rating;

  SendReviewParams(this.productId, this.comment, this.rating);
}

class SearchProductsUseCaseParams {
  final String keyWord;

  SearchProductsUseCaseParams(this.keyWord);
}
class GetProductsByTypeUseCaseParams {
  final String keyWord;

  GetProductsByTypeUseCaseParams(this.keyWord);
}

class GetReviewsParams {
  final String productId;

  GetReviewsParams(this.productId);
}

class ChangeCategoryUseCaseParams {
  final int categoryId;

  ChangeCategoryUseCaseParams(this.categoryId,);
}
