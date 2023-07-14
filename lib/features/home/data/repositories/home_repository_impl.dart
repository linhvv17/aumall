import 'package:aumall/core/error/failure.dart';
import 'package:aumall/core/network/network_info.dart';
import 'package:aumall/features/home/data/datasources/home_datasources.dart';
import 'package:aumall/features/home/domain/entities/banner_entity.dart';
import 'package:aumall/features/home/domain/entities/home_data_entity.dart';
import 'package:aumall/features/home/domain/entities/list_product_home_entity.dart';
import 'package:aumall/features/home/domain/entities/product_detail_entity.dart';
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

  @override
  Future<Either<Failure, ListProductHomeEntity>> getListProductHome() async {
    if (await networkInfo.isConnected) {
      print('getListProductHome: ');
      try {
        final data = await homeDatasource.getListProductHome();
        print('getListProductHome ${data}');
        print('getListProductHome ${data.listProductHomeData.newProducts?.length}');
        return right(data);
      } catch (error) {
        print('getListProductHome: catch: ${error.toString()}');
        return left(ErrorHandler.handle(error).failure);
      }
    } else {
      return  Left(OfflineFailure(S.current.noInternetError));
    }
  }

  @override
  Future<Either<Failure, ProductDetailEntity>> getProductDetail(GetProductDetailParams getProductDetailParams) async {
    if (await networkInfo.isConnected) {
      try {
        final data = await homeDatasource.getProductDetail(getProductDetailParams);
        print('getProductDetail try}');
        print('getProductDetail ${data}');
        print('getProductDetail ${data.productDetailData}');
        return right(data);
      } catch (error) {
        print('getProductDetail catch');
        print(error.toString());
        return left(ErrorHandler.handle(error).failure);
      }
    } else {
      return  Left(OfflineFailure(S.current.noInternetError));
    }
  }

  @override
  Future<Either<Failure, HomeDataEntity>> getHomeData() async  {
    if (await networkInfo.isConnected) {
      try {
        final data = await homeDatasource.getHomeData();
        print('getProductDetail try}');
        print('getProductDetail ${data}');
        // print('getProductDetail ${data.images}');
        return right(data);
      } catch (error) {
        print('getProductDetail catch');
        print(error.toString());
        return left(ErrorHandler.handle(error).failure);
      }
    } else {
      return  Left(OfflineFailure(S.current.noInternetError));
    }
  }

}