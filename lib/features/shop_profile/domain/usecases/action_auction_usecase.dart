import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/usecase/usecase.dart';
import '../entities/list_auction_entity.dart';
import '../repositories/auction_product_repository.dart';

class ActionAuctionUseCase
    extends BaseUsecase<bool, ActionAuctionProductUseCaseParams> {
  final AuctionBaseRepository auctionBaseRepository;
  ActionAuctionUseCase(this.auctionBaseRepository);

  @override
  Future<Either<Failure, bool>> call(
      ActionAuctionProductUseCaseParams params) async {
    final response = await auctionBaseRepository.actionAuction(
        params.idProduct, params.price);
    return response;
  }
}

class ActionAuctionProductUseCaseParams {
  final int idProduct;
  final String price;
  ActionAuctionProductUseCaseParams(
      {required this.idProduct, required this.price});
}
