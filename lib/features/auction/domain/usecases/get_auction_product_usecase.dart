import 'package:aumall/features/auction/domain/entities/product/products_order_by_shop_entity.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/usecase/usecase.dart';
import '../entities/list_auction_entity.dart';
import '../repositories/auction_product_repository.dart';

class GetAuctionProductUseCase
    extends BaseUsecase<List<ProductsOrderByShopEntity>, GetAuctionParams> {
  final AuctionBaseRepository auctionBaseRepository;
  GetAuctionProductUseCase(this.auctionBaseRepository);

  @override
  Future<Either<Failure, List<ProductsOrderByShopEntity>>> call(
      GetAuctionParams params) async {
    final response = await auctionBaseRepository.getAuctionList(params);
    return response;
  }
}
