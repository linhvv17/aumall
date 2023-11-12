import 'package:aumall/features/cart/domain/entities/list_product_in_cart_entity.dart';
import 'package:aumall/features/cart/domain/repositories/cart_repository.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/usecase/usecase.dart';
import '../entities/products_in_cart_order_by_shop_entity.dart';

class GetProductInCartUseCase
    extends BaseUsecase<List<ProductsInCartOrderByShopEntity>, NoParams> {
  final CartBaseRepository cartBaseRepository;
  GetProductInCartUseCase(this.cartBaseRepository);

  @override
  Future<Either<Failure, List<ProductsInCartOrderByShopEntity>>> call(NoParams params) async {
    final response = await cartBaseRepository.getProductInCartList();
    return response;
  }
}
