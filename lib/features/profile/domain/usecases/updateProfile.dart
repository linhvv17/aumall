import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/usecase/usecase.dart';
import '../entities/profile_entity.dart';
import '../repositories/profile_repository.dart';

class UpdateUserDetailUsecase
    implements BaseUsecase<ProfileEntity, UpdateProfileUsecaseParams> {
  final ProfileRepository profileRepository;

  UpdateUserDetailUsecase(this.profileRepository);
  @override
  Future<Either<Failure, ProfileEntity>> call(
      UpdateProfileUsecaseParams params) async {
    return await profileRepository.updateProfile(
        UpdateProfileParams(
            params.fullName,
            params.name,
            params.mobile,
            params.avatar,
            params.dateOfBirth,
            params.address
        ));
  }
}

class UpdateProfileUsecaseParams {
  final String fullName;
  final String name;
  final String mobile;
  final String avatar;
  final String dateOfBirth;
  final String address;

  UpdateProfileUsecaseParams(this.name, this.avatar, this.fullName, this.mobile, this.dateOfBirth, this.address);
}
