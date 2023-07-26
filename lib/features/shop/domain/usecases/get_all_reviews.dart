import 'package:aumall/core/error/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:aumall/core/usecase/usecase.dart';
import 'package:aumall/features/shop/domain/entities/reviews_entity.dart';
import '../repositories/product_repository.dart';

class GetReviewsUseCase
    extends BaseUsecase<GetReviewsEntity, GetReviewsUseCaseParams> {
  final ProductRepository productRepository;

  GetReviewsUseCase(this.productRepository);
  @override
  Future<Either<Failure, GetReviewsEntity>> call(
      GetReviewsUseCaseParams params) async {
    return await productRepository.getReviews(GetReviewsParams(params.productId));
  }
}

class GetReviewsUseCaseParams {
  final String productId;

  GetReviewsUseCaseParams(this.productId);
}
