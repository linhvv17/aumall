import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/usecase/usecase.dart';
import '../entities/list_auction_entity.dart';
import '../repositories/auction_product_repository.dart';

class GetAuctionProductUseCase
    extends BaseUsecase<ListAuctionEntity, GetAuctionParams> {
  final AuctionBaseRepository auctionBaseRepository;
  GetAuctionProductUseCase(this.auctionBaseRepository);

  @override
  Future<Either<Failure, ListAuctionEntity>> call(
      GetAuctionParams params) async {
    final response = await auctionBaseRepository.getAuctionList(params);
    return response;
  }
}
