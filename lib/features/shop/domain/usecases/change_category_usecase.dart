import 'package:dartz/dartz.dart';
import '../../../../core/error/failure.dart';
import '../../../../core/usecase/usecase.dart';
import '../entities/categories_entity.dart';
import '../entities/list_product_shop_entity.dart';
import '../entities/products_entity.dart';
import '../entities/shop_data_default_entity.dart';
import '../repositories/product_repository.dart';

class ChangeCategoryUseCase
    extends BaseUsecase<ListProductShopEntity, ChangeCategoryUseCaseParams> {
  final ProductRepository productRepository;

  ChangeCategoryUseCase(this.productRepository);

  @override
  Future<Either<Failure, ListProductShopEntity>> call(
      ChangeCategoryUseCaseParams params) async {
    return await productRepository.changeCategory(params);
  }
}
