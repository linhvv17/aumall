import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/usecase/usecase.dart';
import '../entities/profile_entity.dart';
import '../repositories/profile_repository.dart';

class UpdatePasswordUseCase
    extends BaseUsecase<ProfileEntity, UpdatePasswordUseCaseParams> {
  final ProfileRepository profileRepository;

  UpdatePasswordUseCase(this.profileRepository);
  @override
  Future<Either<Failure, ProfileEntity>> call(
      UpdatePasswordUseCaseParams params) async {
    return await profileRepository.updatePassword(UpdatePassParnms(
        params.oldPassword, params.newPassword, params.confirmPassword));
  }
}

class UpdatePasswordUseCaseParams {
  final String oldPassword;
  final String newPassword;
  final String confirmPassword;

  UpdatePasswordUseCaseParams(
      this.oldPassword, this.newPassword, this.confirmPassword);
}
