import 'package:dartz/dartz.dart';
import '../../../../core/error/failure.dart';
import '../../../../core/usecase/usecase.dart';
import '../entities/categories_entity.dart';
import '../entities/list_product_shop_entity.dart';
import '../entities/products_entity.dart';
import '../entities/shop_data_default_entity.dart';
import '../repositories/product_repository.dart';

class GetCategoriesUseCase extends BaseUsecase<CategoriesEntity, NoParams> {
  final ProductRepository productRepository;

  GetCategoriesUseCase(this.productRepository);

  @override
  Future<Either<Failure, CategoriesEntity>> call(NoParams params) async {
    return await productRepository.getCategories();
  }
}
