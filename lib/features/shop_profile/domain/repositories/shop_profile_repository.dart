import 'package:aumall/core/error/failure.dart';
import 'package:aumall/features/home/domain/entities/banner_entity.dart';
import 'package:aumall/features/home/domain/usecases/get_product_detail_usecase.dart';
import 'package:dartz/dartz.dart';

import '../entities/list_shop_product_entity.dart';
import '../entities/shop_product_entity.dart';
import '../entities/shop_profile_entity.dart';

abstract class ShopProfileBaseRepository {
  Future<Either<Failure, ShopProfileEntity>> getShopProfile(
      GetShopProfileParams getShopProfileParams);
  Future<Either<Failure, List<ListShopProductsEntity>>> getShopProduct(
      GetShopProductParams getShopProfileParams);
}

class GetShopProfileParams {
  final int shopId;
  GetShopProfileParams({required this.shopId});
}

class GetShopProductParams {
  final int shopId;
  GetShopProductParams({required this.shopId});
}

