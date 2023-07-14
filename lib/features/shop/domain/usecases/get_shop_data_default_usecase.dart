import 'package:dartz/dartz.dart';
import '../../../../core/error/failure.dart';
import '../../../../core/usecase/usecase.dart';
import '../entities/categories_entity.dart';
import '../entities/products_entity.dart';
import '../repositories/product_repository.dart';

class GetShopDataDefaultUseCase extends BaseUsecase<CategoriesEntity,GetShopDataDefaultParams > {
  final ProductRepository productRepository;

  GetShopDataDefaultUseCase(this.productRepository);
  
  @override
  Future<Either<Failure, CategoriesEntity>> call(GetShopDataDefaultParams params) async {
   return await productRepository.getShopDefaultData(params);
  }
}
