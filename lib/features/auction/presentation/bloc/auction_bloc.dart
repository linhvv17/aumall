import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../../../../core/usecase/usecase.dart';
import '../../../shop/domain/entities/products_entity.dart';
import '../../domain/entities/list_auction_entity.dart';
import '../../domain/repositories/auction_product_repository.dart';
import '../../domain/usecases/add_auction_product_usecase.dart';
import '../../domain/usecases/get_auction_product_usecase.dart';
import '../../domain/usecases/remove_auction_product_usecase.dart';

part 'auction_event.dart';
part 'auction_state.dart';

class AuctionBloc extends Bloc<AuctionEvent, AuctionState> {
  List<ProductSimpleEntity> favouriteList = [];
  final GetAuctionProductUseCase getAuctionProductUseCase;
  final AddAuctionProductUseCase  addAuctionProductUseCase;
  final RemoveAuctionProductUseCase  removeAuctionProductUseCase;

  AuctionBloc(this.getAuctionProductUseCase, this.addAuctionProductUseCase, this.removeAuctionProductUseCase) : super(AuctionInitial()) {
    on<AddToAuction>((event, emit) async {
      print('click FavouriteBloc AddToFavorite');
      emit(AuctionInitial());
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


      final failureOrSuccess = await addAuctionProductUseCase(AddAuctionProductUseCaseParams(idProduct: event.product.id!));
      failureOrSuccess.fold(
              (failure) => emit(AuctionDataErrorState(failure.message)),
          // (success) => emit(HomeStateDataLoaded(success)),
              (success) => emit(AddAuctionSuccess(success))
      );


    });

    on<GetListAuctionProduct>((event, emit) async {
      emit(AuctionDataLoading());
      final failureOrSuccess = await getAuctionProductUseCase(GetAuctionParams( typeAuction: event.typeAuction));
      failureOrSuccess.fold(
              (failure) => emit(AuctionDataErrorState(failure.message)),
          // (success) => emit(HomeStateDataLoaded(success)),
              (success) => emit(AuctionDataLoaded(success))
      );
    });

    on<RemoveAuctionProduct>((event, emit) async {
      print('click FavouriteBloc RemoveFavoriteProduct');
      emit(AuctionDataLoading());
      final failureOrSuccess = await removeAuctionProductUseCase(RemoveAuctionProductUseCaseParams(idProduct: event.productId));
      failureOrSuccess.fold(
              (failure) => emit(AuctionDataErrorState(failure.message)),
          // (success) => emit(HomeStateDataLoaded(success)),
              (success) => emit(RemoveAuctionSuccess(success))
      );
    });
  }
}
