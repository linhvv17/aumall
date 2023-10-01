import 'package:aumall/features/shop_profile/domain/entities/shop_product_entity.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/usecase/usecase.dart';
import '../entities/list_shop_product_entity.dart';
import '../entities/shop_profile_entity.dart';
import '../repositories/shop_profile_repository.dart';

class GetShopProductUseCase
    extends BaseUsecase<List<ListShopProductsEntity>, GetShopProductParams> {
  final ShopProfileBaseRepository shopProfileBaseRepository;
  GetShopProductUseCase(this.shopProfileBaseRepository);

  @override
  Future<Either<Failure, List<ListShopProductsEntity>>> call(
      GetShopProductParams params) async {
    final response = await shopProfileBaseRepository.getShopProduct(params);
    return response;
  }
}
