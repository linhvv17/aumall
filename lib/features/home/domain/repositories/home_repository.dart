import 'package:aumall/core/error/failure.dart';
import 'package:aumall/features/home/domain/entities/banner_entity.dart';
import 'package:dartz/dartz.dart';

abstract class HomeBaseRepository {
  Future<Either<Failure, BannerEntity>> getBannerAds();
}