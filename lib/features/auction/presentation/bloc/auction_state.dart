part of 'auction_bloc.dart';

abstract class AuctionState extends Equatable {
  const AuctionState();
  
  @override
  List<Object> get props => [];
}

class AuctionInitial extends AuctionState {}
class AuctionDataLoading extends AuctionState {}
class AuctionDataErrorState extends AuctionState {
  final String message;

  const AuctionDataErrorState(this.message);
}
class AuctionDataLoaded extends AuctionState {
  final ListAuctionEntity listAuctionEntity;
  const AuctionDataLoaded(this.listAuctionEntity);
}

class AddToAuctionState extends AuctionState {}

class RemoveFromFavoriteState extends AuctionState {

}
class RemoveAuctionSuccess extends AuctionState {
  final bool isSuccess;
  const RemoveAuctionSuccess(this.isSuccess);
}
class AddAuctionSuccess extends AuctionState {
  final bool isSuccess;
  const AddAuctionSuccess(this.isSuccess);
}