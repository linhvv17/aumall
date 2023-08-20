import 'package:aumall/core/error/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:aumall/core/usecase/usecase.dart';
import 'package:aumall/features/payment/domain/entities/auth_request_entity.dart';
import 'package:aumall/features/payment/domain/repositories/payment_repository.dart';

class RequestAuthUsecase
    implements BaseUsecase<AuthRequestEntity, RequestAuthUseCaseParams> {
  final PaymentRepository paymentRepository;

  RequestAuthUsecase(this.paymentRepository);
  @override
  Future<Either<Failure, AuthRequestEntity>> call(
      RequestAuthUseCaseParams params) async {
    return await paymentRepository
        .requestAuth(RequestAuthParams(params.apiKey));
  }
}

class RequestAuthUseCaseParams {
  final String apiKey;

  RequestAuthUseCaseParams(this.apiKey);
}
