import 'package:aumall/features/profile/domain/entities/address_entity.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/usecase/usecase.dart';
import '../entities/profile_entity.dart';
import '../repositories/profile_repository.dart';

class AddAddressUseCase implements BaseUsecase<bool, AddAddressParams> {
  final ProfileRepository profileRepository;

  AddAddressUseCase(this.profileRepository);
  @override
  Future<Either<Failure, bool>> call(AddAddressParams addAddressParams) async {
    return await profileRepository.addAddress(addAddressParams);
  }
}
