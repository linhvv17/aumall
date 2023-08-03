// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'auction_bloc.dart';

abstract class AuctionEvent extends Equatable {
  const AuctionEvent();

  @override
  List<Object> get props => [];
}


class RemoveAuctionProduct extends AuctionEvent{
  final int productId;
  const RemoveAuctionProduct(this.productId);

}
class GetListAuctionProduct extends AuctionEvent{
  final int typeAuction;
  const GetListAuctionProduct(this.typeAuction);

}

class AddToAuction extends AuctionEvent {
  final bool isFavourite;
  final ProductAuMallEntity product;
  const AddToAuction({
    required this.isFavourite,
    required this.product,
  });
}
