part of 'favourite_bloc.dart';

abstract class FavouriteState extends Equatable {
  const FavouriteState();
  
  @override
  List<Object> get props => [];
}

class FavouriteInitial extends FavouriteState {}
class FavouriteDataLoading extends FavouriteState {}
class FavouriteDataErrorState extends FavouriteState {
  final String message;

  const FavouriteDataErrorState(this.message);
}
class FavouriteDataLoaded extends FavouriteState {
  final ListFavoriteEntity listFavoriteEntity;
  const FavouriteDataLoaded(this.listFavoriteEntity);
}

class AddToFavouriteState extends FavouriteState {}

class RemoveFromFavoriteState extends FavouriteState {

}
class RemoveFavoriteSuccess extends FavouriteState {
  final bool isSuccess;
  const RemoveFavoriteSuccess(this.isSuccess);
}
class AddFavoriteSuccess extends FavouriteState {
  final bool isSuccess;
  const AddFavoriteSuccess(this.isSuccess);
}