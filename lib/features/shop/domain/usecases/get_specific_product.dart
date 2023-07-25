import 'package:dartz/dartz.dart';
import '../../../../core/error/failure.dart';
import '../../../../core/usecase/usecase.dart';
import '../entities/list_product_shop_entity.dart';
import '../repositories/product_repository.dart';

class GetProductByFilterUseCase
    extends BaseUsecase<ListProductShopEntity, GetProductByFilterUseCaseParams> {
  final ProductRepository productRepository;

  GetProductByFilterUseCase(this.productRepository);
  @override
  Future<Either<Failure, ListProductShopEntity>> call(
      GetProductByFilterUseCaseParams params) async {
    return await productRepository.getProductByFilter(GetProductByFilterUseCaseParams(
        params.minPrice,
        params.maxPrice,
        params.rate));
  }
}

class GetProductByFilterUseCaseParams {
  final String minPrice;
  final String maxPrice;
  final String rate;
  GetProductByFilterUseCaseParams(
      this.minPrice, this.maxPrice, this.rate,);
}
