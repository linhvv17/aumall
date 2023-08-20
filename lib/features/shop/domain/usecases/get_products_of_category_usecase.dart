import 'package:dartz/dartz.dart';
import '../../../../core/error/failure.dart';
import '../../../../core/usecase/usecase.dart';
import '../entities/categories_entity.dart';
import '../entities/list_product_shop_entity.dart';
import '../entities/products_entity.dart';
import '../entities/shop_data_default_entity.dart';
import '../repositories/product_repository.dart';

class GetProductsOfCategoryUseCase extends BaseUsecase<ListProductShopEntity,
    GetProductsOfCategoryUseCaseParams> {
  final ProductRepository productRepository;

  GetProductsOfCategoryUseCase(this.productRepository);

  @override
  Future<Either<Failure, ListProductShopEntity>> call(
      GetProductsOfCategoryUseCaseParams params) async {
    return await productRepository.getProductsOfCategory(params);
  }
}
