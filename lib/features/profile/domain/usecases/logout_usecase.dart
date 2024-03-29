import 'dart:io';

import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/usecase/usecase.dart';
import '../entities/profile_entity.dart';
import '../repositories/profile_repository.dart';

class LogOutUseCase
    implements BaseUsecase<bool, NoParams> {
  final ProfileRepository profileRepository;

  LogOutUseCase(this.profileRepository);
  @override
  Future<Either<Failure, bool>> call(
      NoParams params) async {
    return await profileRepository.logOut();
  }
}

