import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/usecase/usecase.dart';
import '../repositories/cart_repository.dart';


class UpdateProductInCartUseCase extends BaseUsecase<bool, UpdateProductInCartUseCaseParams>{
  final CartBaseRepository _cartBaseRepository;
  UpdateProductInCartUseCase(this._cartBaseRepository);

  @override
  Future<Either<Failure, bool>> call(UpdateProductInCartUseCaseParams params) async {
    final response =  await _cartBaseRepository.updateProductToCart(params.idProduct, params.quantity);
    return response;
  }
}

class UpdateProductInCartUseCaseParams {
  final int idProduct;
  final int quantity;
  UpdateProductInCartUseCaseParams(this.quantity, {required this.idProduct});
}