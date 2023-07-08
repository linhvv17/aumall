import 'package:aumall/core/error/failure.dart';
import 'package:aumall/core/usecase/usecase.dart';
import 'package:aumall/features/home/domain/entities/banner_entity.dart';
import 'package:aumall/features/home/domain/repositories/home_repository.dart';
import 'package:dartz/dartz.dart';

class GetBannerUseCase extends BaseUsecase<BannerEntity, NoParams>{
  final HomeBaseRepository homeRepository;
  GetBannerUseCase(this.homeRepository);

  @override
  Future<Either<Failure, BannerEntity>> call(NoParams params) async {
    final response =  await homeRepository.getBannerAds();
    return response;
  }
}