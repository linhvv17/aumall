import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/usecase/usecase.dart';
import '../entities/list_favorite_entity.dart';
import '../repositories/favorite_product_repository.dart';

class AddFavoriteProductUseCase
    extends BaseUsecase<bool, AddFavoriteProductUseCaseParams> {
  final FavoriteBaseRepository favoriteBaseRepository;
  AddFavoriteProductUseCase(this.favoriteBaseRepository);

  @override
  Future<Either<Failure, bool>> call(
      AddFavoriteProductUseCaseParams params) async {
    final response =
        await favoriteBaseRepository.addFavoriteProduct(params.idProduct);
    return response;
  }
}

class AddFavoriteProductUseCaseParams {
  final int idProduct;
  AddFavoriteProductUseCaseParams({required this.idProduct});
}
