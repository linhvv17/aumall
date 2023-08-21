import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../entities/login_entity.dart';

abstract class LoginBaseRepository {
  Future<Either<Failure, LoginEntity>> login(LoginParams params);
}

class LoginParams {
  final String email;
  final String password;
  final String deviceToken;
  final int tokenType;

  LoginParams({
    required this.email,
    required this.password,
    required this.deviceToken,
    required this.tokenType,
  });
}
