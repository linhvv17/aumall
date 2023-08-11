import 'package:aumall/core/error/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:aumall/core/usecase/usecase.dart';
import 'package:aumall/features/shop/domain/entities/reviews_entity.dart';
import '../../../home/domain/entities/product_detail_entity.dart';
import '../entities/product_in_cart_entity.dart';
import '../repositories/cart_repository.dart';

class GetCartUseCase
    extends BaseUsecase<ProductInCartEntity, NoParams> {
  final CartRepository cartRepository;

  GetCartUseCase(this.cartRepository);

  @override
  Future<Either<Failure, ProductInCartEntity>> call(NoParams params) async {
    return await cartRepository.getCartData();
  }

}

class GetReviewsUseCaseParams {
  final String productId;

  GetReviewsUseCaseParams(this.productId);
}
