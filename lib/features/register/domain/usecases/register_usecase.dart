import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/usecase/usecase.dart';
import '../entities/register_entity.dart';
import '../repositories/register_repository.dart';

class RegisterUseCase
    extends BaseUsecase<RegisterEntity, RegisterUseCaseParams> {
  final RegisterBaseRepository registerBaseRepository;

  RegisterUseCase(this.registerBaseRepository);

  @override
  Future<Either<Failure, RegisterEntity>> call(params) async {
    return await registerBaseRepository.register(RegisterParams(
        name: params.name,
        email: params.email,
        password: params.password,
        ));
  }
}

class RegisterUseCaseParams {
  final String name;
  final String email;
  final String password;
  

  RegisterUseCaseParams(
      {required this.name,
      required this.email,
      required this.password,
  });
}
