import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/usecase/usecase.dart';
import '../entities/auction_session_info_entity.dart';
import '../entities/list_auction_entity.dart';
import '../repositories/auction_product_repository.dart';

class GetAuctionSessionInfoUseCase
    extends BaseUsecase<AuctionSessionInfoEntity, GetAuctionSessionInfoParams> {
  final AuctionBaseRepository auctionBaseRepository;
  GetAuctionSessionInfoUseCase(this.auctionBaseRepository);

  @override
  Future<Either<Failure, AuctionSessionInfoEntity>> call(
      GetAuctionSessionInfoParams params) async {
    final response = await auctionBaseRepository.getAuctionSessionInfo(params);
    return response;
  }
}
