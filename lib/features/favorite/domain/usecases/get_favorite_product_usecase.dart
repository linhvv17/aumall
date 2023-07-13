import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/usecase/usecase.dart';
import '../entities/list_favorite_entity.dart';
import '../repositories/favorite_product_repository.dart';

class GetFavoriteProductUseCase extends BaseUsecase<ListFavoriteEntity, NoParams>{
  final FavoriteBaseRepository favoriteBaseRepository;
  GetFavoriteProductUseCase(this.favoriteBaseRepository);

  @override
  Future<Either<Failure, ListFavoriteEntity>> call(NoParams params) async {
    final response =  await favoriteBaseRepository.getFavoriteList();
    return response;
  }
}