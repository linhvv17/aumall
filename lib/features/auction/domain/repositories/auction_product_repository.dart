import 'package:aumall/core/error/failure.dart';
import 'package:aumall/features/home/domain/entities/banner_entity.dart';
import 'package:aumall/features/home/domain/usecases/get_product_detail_usecase.dart';
import 'package:dartz/dartz.dart';

import '../entities/auction_session_info_entity.dart';
import '../entities/list_auction_entity.dart';


abstract class AuctionBaseRepository {
  Future<Either<Failure, ListAuctionEntity>> getAuctionList(GetAuctionParams getAuctionParams);
  Future<Either<Failure, AuctionSessionInfoEntity>> getAuctionSessionInfo(GetAuctionSessionInfoParams getAuctionSessionInfoParams);
  Future<Either<Failure, bool>> removeAuctionProduct(int idProduct);
  Future<Either<Failure, bool>> addAuctionProduct(int idProduct);
}

class GetAuctionParams {
  final int typeAuction;
  GetAuctionParams({required this.typeAuction});
}
class GetAuctionSessionInfoParams {
  final int productAuctionId;
  GetAuctionSessionInfoParams({required this.productAuctionId});
}