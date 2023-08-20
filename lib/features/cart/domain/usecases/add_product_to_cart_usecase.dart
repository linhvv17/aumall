import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/usecase/usecase.dart';
import '../repositories/cart_repository.dart';

class AddProductToCartUseCase
    extends BaseUsecase<bool, AddProductToCartUseCaseParams> {
  final CartBaseRepository _cartBaseRepository;
  AddProductToCartUseCase(this._cartBaseRepository);

  @override
  Future<Either<Failure, bool>> call(
      AddProductToCartUseCaseParams params) async {
    final response = await _cartBaseRepository.addProductToCart(
        params.idProduct, params.quantity);
    return response;
  }
}

class AddProductToCartUseCaseParams {
  final int idProduct;
  final int quantity;
  AddProductToCartUseCaseParams(this.quantity, {required this.idProduct});
}
