import 'package:aumall/features/favorite/domain/entities/product/products_order_by_shop_entity.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/usecase/usecase.dart';
import '../entities/list_favorite_entity.dart';
import '../repositories/favorite_product_repository.dart';

class GetFavoriteProductUseCase
    extends BaseUsecase<List<ProductsOrderByShopEntity>, NoParams> {
  final FavoriteBaseRepository favoriteBaseRepository;
  GetFavoriteProductUseCase(this.favoriteBaseRepository);

  @override
  Future<Either<Failure, List<ProductsOrderByShopEntity>>> call(NoParams params) async {
    final response = await favoriteBaseRepository.getFavoriteList();
    return response;
  }
}
