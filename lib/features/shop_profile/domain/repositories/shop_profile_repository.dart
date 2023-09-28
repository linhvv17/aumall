import 'package:aumall/core/error/failure.dart';
import 'package:aumall/features/home/domain/entities/banner_entity.dart';
import 'package:aumall/features/home/domain/usecases/get_product_detail_usecase.dart';
import 'package:dartz/dartz.dart';

import '../entities/shop_profile_entity.dart';

abstract class ShopProfileBaseRepository {
  Future<Either<Failure, ShopProfileEntity>> getShopProfile(
      GetShopProfileParams getShopProfileParams);
}

class GetShopProfileParams {
  final int shopId;
  GetShopProfileParams({required this.shopId});
}

