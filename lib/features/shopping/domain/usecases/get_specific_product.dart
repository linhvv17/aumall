import 'package:dartz/dartz.dart';
import '../../../../core/error/failure.dart';
import '../../../../core/usecase/usecase.dart';
import '../entities/list_product_shop_entity.dart';
import '../entities/product/products_order_by_shop_entity.dart';
import '../repositories/product_repository.dart';

class GetProductByFilterUseCase extends BaseUsecase<List<ProductsOrderByShopEntity>,
    GetProductByFilterUseCaseParams> {
  final ProductRepository productRepository;

  GetProductByFilterUseCase(this.productRepository);
  @override
  Future<Either<Failure, List<ProductsOrderByShopEntity>>> call(
      GetProductByFilterUseCaseParams params) async {
    return await productRepository
        .getProductByFilter(GetProductByFilterUseCaseParams(
      params.minPrice,
      params.maxPrice,
      params.rate,
      params.categoryId,
    ));
  }
}

class GetProductByFilterUseCaseParams {
  final String minPrice;
  final String maxPrice;
  final String rate;
  final String categoryId;
  GetProductByFilterUseCaseParams(
    this.minPrice,
    this.maxPrice,
    this.rate,
    this.categoryId,
  );
}
