// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'favourite_bloc.dart';

abstract class FavoriteEvent extends Equatable {
  const FavoriteEvent();

  @override
  List<Object> get props => [];
}

class RemoveFavoriteProduct extends FavoriteEvent {
  final int productId;
  const RemoveFavoriteProduct(this.productId);
}

class GetListFavoriteProduct extends FavoriteEvent {}

class AddToFavorite extends FavoriteEvent {
  final bool isFavourite;
  final ProductAuMallEntity product;
  const AddToFavorite({
    required this.isFavourite,
    required this.product,
  });
}
