import 'package:aumall/features/cart/domain/entities/list_product_in_cart_entity.dart';
import 'package:aumall/features/cart/domain/repositories/cart_repository.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/usecase/usecase.dart';

class GetProductInCartUseCase
    extends BaseUsecase<ListProductInCartEntity, NoParams> {
  final CartBaseRepository cartBaseRepository;
  GetProductInCartUseCase(this.cartBaseRepository);

  @override
  Future<Either<Failure, ListProductInCartEntity>> call(NoParams params) async {
    final response = await cartBaseRepository.getProductInCartList();
    return response;
  }
}
