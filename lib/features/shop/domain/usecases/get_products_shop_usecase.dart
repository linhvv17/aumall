import 'package:dartz/dartz.dart';
import '../../../../core/error/failure.dart';
import '../../../../core/usecase/usecase.dart';
import '../entities/categories_entity.dart';
import '../entities/list_product_shop_entity.dart';
import '../entities/products_entity.dart';
import '../repositories/product_repository.dart';

class GetProductsShopUseCase extends BaseUsecase<ListProductShopEntity,GetShopDataDefaultParams > {
  final ProductRepository productRepository;

  GetProductsShopUseCase(this.productRepository);
  
  @override
  Future<Either<Failure, ListProductShopEntity>> call(GetShopDataDefaultParams params) async {
   return await productRepository.getListProductByCategory(params);
  }
}
