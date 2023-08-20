import 'package:aumall/core/error/failure.dart';
import 'package:aumall/features/home/domain/entities/banner_entity.dart';
import 'package:aumall/features/home/domain/usecases/get_product_detail_usecase.dart';
import 'package:dartz/dartz.dart';

import '../entities/list_favorite_entity.dart';

abstract class FavoriteBaseRepository {
  Future<Either<Failure, ListFavoriteEntity>> getFavoriteList();
  Future<Either<Failure, bool>> removeFavoriteProduct(int idProduct);
  Future<Either<Failure, bool>> addFavoriteProduct(int idProduct);
}

class GetFavoriteParams {
  final int id;
  GetFavoriteParams({required this.id});
}
