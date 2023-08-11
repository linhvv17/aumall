import 'package:dartz/dartz.dart';
import '../../../../core/error/failure.dart';
import '../entities/product_in_cart_entity.dart';


abstract class CartRepository {

  Future<Either<Failure, ProductInCartEntity>> getCartData();
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
