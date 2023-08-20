import 'package:aumall/core/error/failure.dart';
import 'package:aumall/core/usecase/usecase.dart';
import 'package:aumall/features/home/domain/entities/banner_entity.dart';
import 'package:aumall/features/home/domain/repositories/home_repository.dart';
import 'package:dartz/dartz.dart';

import '../entities/home_data_entity.dart';

class GetHomeDataUseCase extends BaseUsecase<HomeDataEntity, NoParams> {
  final HomeBaseRepository homeRepository;
  GetHomeDataUseCase(this.homeRepository);

  @override
  Future<Either<Failure, HomeDataEntity>> call(NoParams params) async {
    final response = await homeRepository.getHomeData();
    return response;
  }
}
