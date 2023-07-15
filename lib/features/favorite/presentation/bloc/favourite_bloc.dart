import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../../../../core/usecase/usecase.dart';
import '../../../shop/domain/entities/products_entity.dart';
import '../../domain/entities/list_favorite_entity.dart';
import '../../domain/usecases/add_favorite_product_usecase.dart';
import '../../domain/usecases/get_favorite_product_usecase.dart';
import '../../domain/usecases/remove_favorite_product_usecase.dart';

part 'favourite_event.dart';
part 'favourite_state.dart';

class FavouriteBloc extends Bloc<FavoriteEvent, FavouriteState> {
  List<ProductSimpleEntity> favouriteList = [];
  final GetFavoriteProductUseCase getFavoriteProductUseCase;
  final AddFavoriteProductUseCase  addFavoriteProductUseCase;
  final RemoveFavoriteProductUseCase  removeFavoriteProductUseCase;

  FavouriteBloc(this.getFavoriteProductUseCase, this.removeFavoriteProductUseCase, this.addFavoriteProductUseCase) : super(FavouriteInitial()) {
    on<AddToFavorite>((event, emit) async {
      print('click FavouriteBloc AddToFavorite');
      emit(FavouriteInitial());
      // if (!event.isFavourite) {
      //   // event.product.isFavourite = true;
      //   favouriteList.add(event.product);
      //   emit(AddToFavouriteState());
      //   // emit(FavouriteLoaded(favouriteList));
      //
      // } else {
      //   if (event.isFavourite) {
      //     // event.product.isFavourite = false;
      //     favouriteList.remove(event.product);
      //     emit(RemoveFromFavoriteState());
      //     // emit(FavouriteLoaded(favouriteList));
      //   }
      // }


      final failureOrSuccess = await addFavoriteProductUseCase(AddFavoriteProductUseCaseParams(idProduct: event.product.id!));
      failureOrSuccess.fold(
              (failure) => emit(FavouriteDataErrorState(failure.message)),
          // (success) => emit(HomeStateDataLoaded(success)),
              (success) => emit(AddFavoriteSuccess(success))
      );


    });
    on<GetListFavoriteProduct>((event, emit) async {
      emit(FavouriteDataLoading());
      final failureOrSuccess = await getFavoriteProductUseCase(NoParams());
      failureOrSuccess.fold(
              (failure) => emit(FavouriteDataErrorState(failure.message)),
          // (success) => emit(HomeStateDataLoaded(success)),
              (success) => emit(FavouriteDataLoaded(success))
      );
    });

    on<RemoveFavoriteProduct>((event, emit) async {
      print('click FavouriteBloc RemoveFavoriteProduct');
      emit(FavouriteDataLoading());
      final failureOrSuccess = await removeFavoriteProductUseCase(RemoveFavoriteProductUseCaseParams(idProduct: event.productId));
      failureOrSuccess.fold(
              (failure) => emit(FavouriteDataErrorState(failure.message)),
          // (success) => emit(HomeStateDataLoaded(success)),
              (success) => emit(RemoveFavoriteSuccess(success))
      );
    });
  }
}
