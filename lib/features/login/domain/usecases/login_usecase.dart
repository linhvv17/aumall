import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/usecase/usecase.dart';
import '../entities/login_entity.dart';
import '../repositories/login_repository.dart';

class LoginUseCase extends BaseUsecase<LoginEntity, LoginUseCaseParams> {
  final LoginBaseRepository loginBaseRepository;

  LoginUseCase(this.loginBaseRepository);

  @override
  Future<Either<Failure, LoginEntity>> call(params) async {
    return await loginBaseRepository
        .login(LoginParams(email: params.email, password: params.password));
  }
}

class LoginUseCaseParams {
  final String email;
  final String password;

  LoginUseCaseParams({required this.email, required this.password});
}
