import 'package:dartz/dartz.dart';
import '../../../../core/error/failure.dart';
import '../../../../core/usecase/usecase.dart';
import '../entities/response_entity.dart';
import '../repositories/product_repository.dart';

class SendReviewUseCase extends BaseUsecase<ResponseEntity, SendReviewUseCaseParams> {
  final ProductRepository productRepository;

  SendReviewUseCase(this.productRepository);
  @override
  Future<Either<Failure, ResponseEntity>> call(SendReviewUseCaseParams params) async {
    return await productRepository.sendReview(SendReviewParams(params.productId, params.comment, params.rating));
  }
}

class SendReviewUseCaseParams {
  final String productId;
  final String comment;
  final num rating;

  SendReviewUseCaseParams(this.productId, this.comment, this.rating);
}
