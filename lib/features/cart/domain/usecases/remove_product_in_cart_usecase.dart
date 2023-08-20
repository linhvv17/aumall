import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/usecase/usecase.dart';
import '../repositories/cart_repository.dart';

class RemoveProductInCartUseCase
    extends BaseUsecase<bool, RemoveFavoriteProductUseCaseParams> {
  final CartBaseRepository cartBaseRepository;
  RemoveProductInCartUseCase(this.cartBaseRepository);

  @override
  Future<Either<Failure, bool>> call(
      RemoveFavoriteProductUseCaseParams params) async {
    final response =
        await cartBaseRepository.removeProductInCart(params.idProduct);
    return response;
  }
}

class RemoveFavoriteProductUseCaseParams {
  final int idProduct;
  RemoveFavoriteProductUseCaseParams({required this.idProduct});
}
