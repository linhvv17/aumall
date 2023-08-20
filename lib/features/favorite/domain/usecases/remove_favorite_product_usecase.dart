import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/usecase/usecase.dart';
import '../entities/list_favorite_entity.dart';
import '../repositories/favorite_product_repository.dart';

class RemoveFavoriteProductUseCase
    extends BaseUsecase<bool, RemoveFavoriteProductUseCaseParams> {
  final FavoriteBaseRepository favoriteBaseRepository;
  RemoveFavoriteProductUseCase(this.favoriteBaseRepository);

  @override
  Future<Either<Failure, bool>> call(
      RemoveFavoriteProductUseCaseParams params) async {
    final response =
        await favoriteBaseRepository.removeFavoriteProduct(params.idProduct);
    return response;
  }
}

class RemoveFavoriteProductUseCaseParams {
  final int idProduct;
  RemoveFavoriteProductUseCaseParams({required this.idProduct});
}
