import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';

import '../../../../core/error/error_handler.dart';
import '../../../../core/error/failure.dart';
import '../../../../core/network/network_info.dart';
import '../../../../core/utilities/strings.dart';

import '../../../../generated/l10n.dart';
import '../../domin/entities/login_entity.dart';
import '../../domin/repositories/login_repository.dart';
import '../datasources/login_datasource.dart';

class LoginRepositoryImpl implements LoginBaseRepository {
  final LoginDatasource loginDatasource;
  final NetworkInfo networkInfo;

  LoginRepositoryImpl(this.loginDatasource, this.networkInfo);

  @override
  Future<Either<Failure, LoginEntity>> login(LoginParams params) async {
    if (await networkInfo.isConnected) {
      try {
        print('aaaaaaaaaaaaaaa');
        final response = await loginDatasource.login(params);
        print('aaaaaaaaaaaaaaa ${response.message}');
        return right(response);
      } catch (error) {
        if (kDebugMode) {
          print(error);
        }
        print('bbbbbbbbbbbb');
        return left(ErrorHandler.handle(error).failure);
      }
    } else {
      return  Left(OfflineFailure(S.current.noInternetError));
    }
  }
}
