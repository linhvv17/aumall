import 'package:aumall/core/error/failure.dart';
import 'package:aumall/features/home/domain/entities/banner_entity.dart';
import 'package:dartz/dartz.dart';

import '../entities/list_product_home_entity.dart';

abstract class HomeBaseRepository {
  Future<Either<Failure, BannerEntity>> getBannerAds();
  Future<Either<Failure, ListProductHomeEntity>> getListProductHome();
}