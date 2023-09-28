import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/usecase/usecase.dart';
import '../entities/shop_profile_entity.dart';
import '../repositories/shop_profile_repository.dart';

class GetShopProfileUseCase
    extends BaseUsecase<ShopProfileEntity, GetShopProfileParams> {
  final ShopProfileBaseRepository shopProfileBaseRepository;
  GetShopProfileUseCase(this.shopProfileBaseRepository);

  @override
  Future<Either<Failure, ShopProfileEntity>> call(
      GetShopProfileParams params) async {
    final response = await shopProfileBaseRepository.getShopProfile(params);
    return response;
  }
}
