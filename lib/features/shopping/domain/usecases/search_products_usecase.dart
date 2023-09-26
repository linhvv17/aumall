import 'package:dartz/dartz.dart';
import '../../../../core/error/failure.dart';
import '../../../../core/usecase/usecase.dart';
import '../entities/categories_entity.dart';
import '../entities/list_product_shop_entity.dart';
import '../entities/product/products_order_by_shop_entity.dart';
import '../entities/products_entity.dart';
import '../entities/shop_data_default_entity.dart';
import '../repositories/product_repository.dart';

class SearchProductsUseCase
    extends BaseUsecase<List<ProductsOrderByShopEntity>, SearchProductsUseCaseParams> {
  final ProductRepository productRepository;

  SearchProductsUseCase(this.productRepository);

  @override
  Future<Either<Failure, List<ProductsOrderByShopEntity>>> call(
      SearchProductsUseCaseParams params) async {
    return await productRepository.searchProducts(params);
  }
}
