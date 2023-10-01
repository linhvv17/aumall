import 'package:aumall/core/error/error_handler.dart';
import 'package:aumall/core/error/failure.dart';
import 'package:aumall/core/network/network_info.dart';
import 'package:aumall/features/shop_profile/domain/entities/shop_profile_entity.dart';
import 'package:aumall/generated/l10n.dart';
import 'package:dartz/dartz.dart';
import '../../domain/entities/list_shop_product_entity.dart';
import '../../domain/entities/shop_product_entity.dart';
import '../../domain/repositories/shop_profile_repository.dart';
import '../datasources/shop_profile_datasource.dart';

class ShopProfileRepositoryImpl extends ShopProfileBaseRepository {
  final NetworkInfo networkInfo;
  final ShopProfileDatasource auctionDatasource;
  ShopProfileRepositoryImpl(this.networkInfo, this.auctionDatasource);


  @override
  Future<Either<Failure, ShopProfileEntity>> getShopProfile(GetShopProfileParams getShopProfileParams) async{
    if (await networkInfo.isConnected) {
      try {
        final data = await auctionDatasource.getShopProfile(getShopProfileParams);
        print("ShopProfileRepositoryImpl getShopProfile() try ${data}");
        return right(data);
      } catch (error) {
        print("ShopProfileRepositoryImpl getShopProfile() catch ${error}");
        return Left(ErrorHandler.handle(error).failure);
      }
    } else {
      return Left(OfflineFailure(S.current.noInternetError));
    }
  }

  @override
  Future<Either<Failure, List<ListShopProductsEntity>>> getShopProduct(GetShopProductParams getShopProductParams) async{
    if (await networkInfo.isConnected) {
      try {
        final data = await auctionDatasource.getShopProduct(getShopProductParams);
        print("ShopProfileRepositoryImpl getShopProduct() try ${data}");
        return right(data);
      } catch (error) {
        print("ShopProfileRepositoryImpl getShopProduct() catch ${error}");
        return Left(ErrorHandler.handle(error).failure);
      }
    } else {
      return Left(OfflineFailure(S.current.noInternetError));
    }
  }
}
