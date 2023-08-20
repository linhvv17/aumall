import 'package:aumall/core/error/failure.dart';
import 'package:aumall/features/home/domain/entities/banner_entity.dart';
import 'package:aumall/features/home/domain/usecases/get_product_detail_usecase.dart';
import 'package:dartz/dartz.dart';

import '../entities/home_data_entity.dart';
import '../entities/list_product_home_entity.dart';
import '../entities/product_detail_entity.dart';

abstract class HomeBaseRepository {
  Future<Either<Failure, HomeDataEntity>> getHomeData();
  Future<Either<Failure, BannerEntity>> getBannerAds();
  Future<Either<Failure, ListProductHomeEntity>> getListProductHome();
  Future<Either<Failure, ProductDetailEntity>> getProductDetail(
      GetProductDetailParams getProductDetailParams);
}

class GetProductDetailParams {
  final int id;
  GetProductDetailParams({required this.id});
}
