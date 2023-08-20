import 'package:aumall/features/profile/domain/entities/address_entity.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/usecase/usecase.dart';
import '../entities/profile_entity.dart';
import '../repositories/profile_repository.dart';

class GetAddressListUseCase
    implements BaseUsecase<List<AddressEntity>, NoParams> {
  final ProfileRepository profileRepository;

  GetAddressListUseCase(this.profileRepository);
  @override
  Future<Either<Failure, List<AddressEntity>>> call(NoParams params) async {
    return await profileRepository.getAddressList();
  }
}
