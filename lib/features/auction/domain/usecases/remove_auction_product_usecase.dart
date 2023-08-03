import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/usecase/usecase.dart';
import '../entities/list_auction_entity.dart';
import '../repositories/auction_product_repository.dart';

class RemoveAuctionProductUseCase extends BaseUsecase<bool, RemoveAuctionProductUseCaseParams>{
  final AuctionBaseRepository auctionBaseRepository;
  RemoveAuctionProductUseCase(this.auctionBaseRepository);

  @override
  Future<Either<Failure, bool>> call(RemoveAuctionProductUseCaseParams params) async {
    final response =  await auctionBaseRepository.removeAuctionProduct(params.idProduct);
    return response;
  }
}

class RemoveAuctionProductUseCaseParams {
  final int idProduct;
  RemoveAuctionProductUseCaseParams({required this.idProduct});
}