import 'package:aumall/core/error/error_handler.dart';
import 'package:aumall/core/error/failure.dart';
import 'package:aumall/core/network/network_info.dart';
import 'package:aumall/features/auction/domain/entities/auction_session_info_entity.dart';
import 'package:aumall/generated/l10n.dart';
import 'package:dartz/dartz.dart';

import '../../domain/entities/list_auction_entity.dart';
import '../../domain/repositories/auction_product_repository.dart';
import '../datasources/auction_datasource.dart';

class AuctionRepositoryImpl extends AuctionBaseRepository {
  final NetworkInfo networkInfo;
  final AuctionDatasource auctionDatasource;
  AuctionRepositoryImpl(this.networkInfo, this.auctionDatasource);

  @override
  Future<Either<Failure, ListAuctionEntity>> getAuctionList(GetAuctionParams getAuctionParams)  async {
    if(await networkInfo.isConnected){
      try {
        final data = await auctionDatasource.getListAuction(getAuctionParams);
        print("AuctionRepositoryImpl getAuctionList() try ${data}");
        return right(data);
      } catch(error) {
        print("AuctionRepositoryImpl getAuctionList() catch ${error}");
        return Left(ErrorHandler.handle(error).failure);
      }
    } else{
      return Left(OfflineFailure(S.current.noInternetError));
    }
  }

  @override
  Future<Either<Failure, bool>> removeAuctionProduct(int idProduct) async {
    if(await networkInfo.isConnected){
      try {
        final data = await auctionDatasource.removeAuctionProduct(idProduct);
        print("AuctionRepositoryImpl getAuctionList() try ${data}");
        return right(data);
      } catch(error) {
        print("AuctionRepositoryImpl getAuctionList() catch ${error}");
        return Left(ErrorHandler.handle(error).failure);
      }
    } else{
      return Left(OfflineFailure(S.current.noInternetError));
    }
  }

  @override
  Future<Either<Failure, bool>> addAuctionProduct(int idProduct) async {
    if(await networkInfo.isConnected){
      try {
        final data = await auctionDatasource.addAuctionProduct(idProduct);
        print("AuctionRepositoryImpl getAuctionList() try ${data}");
        return right(data);
      } catch(error) {
        print("AuctionRepositoryImpl getAuctionList() catch ${error}");
        return Left(ErrorHandler.handle(error).failure);
      }
    } else{
      return Left(OfflineFailure(S.current.noInternetError));
    }
  }

  @override
  Future<Either<Failure, AuctionSessionInfoEntity>> getAuctionSessionInfo(GetAuctionSessionInfoParams getAuctionSessionInfoParams) async {
    if(await networkInfo.isConnected){
      try {
        final data = await auctionDatasource.getAuctionSessionInfo(getAuctionSessionInfoParams);
        print("AuctionRepositoryImpl getAuctionSessionInfo() try ${data}");
        return right(data);
      } catch(error) {
        print("AuctionRepositoryImpl getAuctionSessionInfo() catch ${error}");
        return Left(ErrorHandler.handle(error).failure);
      }
    } else{
      return Left(OfflineFailure(S.current.noInternetError));
    }
  }

  @override
  Future<Either<Failure, bool>> actionAuction(int idProduct, String price) async {
    if(await networkInfo.isConnected){
      try {
        final data = await auctionDatasource.actionAuction(idProduct, price);
        print("AuctionRepositoryImpl actionAuction() try ${data}");
        return right(data);
      } catch(error) {
        print("AuctionRepositoryImpl actionAuction() catch ${error}");
        return Left(ErrorHandler.handle(error).failure);
      }
    } else{
      return Left(OfflineFailure(S.current.noInternetError));
    }
  }
}