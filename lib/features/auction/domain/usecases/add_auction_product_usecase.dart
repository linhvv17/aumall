import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/usecase/usecase.dart';
import '../entities/list_auction_entity.dart';
import '../repositories/auction_product_repository.dart';

class AddAuctionProductUseCase extends BaseUsecase<bool, AddAuctionProductUseCaseParams>{
  final AuctionBaseRepository auctionBaseRepository;
  AddAuctionProductUseCase(this.auctionBaseRepository);

  @override
  Future<Either<Failure, bool>> call(AddAuctionProductUseCaseParams params) async {
    final response =  await auctionBaseRepository.addAuctionProduct(params.idProduct);
    return response;
  }
}

class AddAuctionProductUseCaseParams {
  final int idProduct;
  AddAuctionProductUseCaseParams({required this.idProduct});
}