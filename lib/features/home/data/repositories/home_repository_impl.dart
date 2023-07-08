import 'package:aumall/core/error/failure.dart';
import 'package:aumall/core/network/network_info.dart';
import 'package:aumall/features/home/data/datasources/home_datasources.dart';
import 'package:aumall/features/home/domain/entities/banner_entity.dart';
import 'package:aumall/features/home/domain/repositories/home_repository.dart';
import 'package:aumall/generated/l10n.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/error/error_handler.dart';

class HomeRepositoryImpl extends HomeBaseRepository {
  final NetworkInfo networkInfo;
  final HomeDatasource homeDatasource;

  HomeRepositoryImpl(this.networkInfo, this.homeDatasource);
  @override
  Future<Either<Failure, BannerEntity>> getBannerAds() async {
    if (await networkInfo.isConnected) {
      try {
        final data = await homeDatasource.getBannerAds();
        return right(data);
      } catch (error) {
        return left(ErrorHandler.handle(error).failure);
      }
    } else {
      return  Left(OfflineFailure(S.current.noInternetError));
    }
  }

}