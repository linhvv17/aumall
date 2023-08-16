import 'package:aumall/features/auction/domain/usecases/action_auction_usecase.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../../../../core/usecase/usecase.dart';
import '../../../shop/domain/entities/products_entity.dart';
import '../../domain/entities/auction_session_info_entity.dart';
import '../../domain/entities/list_auction_entity.dart';
import '../../domain/repositories/auction_product_repository.dart';
import '../../domain/usecases/add_auction_product_usecase.dart';
import '../../domain/usecases/get_auction_product_usecase.dart';
import '../../domain/usecases/get_auction_session_info_usecase.dart';
import '../../domain/usecases/remove_auction_product_usecase.dart';

part 'auction_event.dart';
part 'auction_state.dart';

class AuctionBloc extends Bloc<AuctionEvent, AuctionState> {
  List<ProductSimpleEntity> favouriteList = [];
  final GetAuctionProductUseCase getAuctionProductUseCase;
  final GetAuctionSessionInfoUseCase  getAuctionSessionInfoUseCase;
  final ActionAuctionUseCase  actionAuctionUseCase;

  AuctionBloc(this.getAuctionProductUseCase, this.getAuctionSessionInfoUseCase, this.actionAuctionUseCase) : super(AuctionInitial()) {
    on<GetListAuctionProduct>((event, emit) async {
      emit(AuctionDataLoading());
      final failureOrSuccess = await getAuctionProductUseCase(GetAuctionParams( typeAuction: event.typeAuction));
      failureOrSuccess.fold(
              (failure) => emit(AuctionDataErrorState(failure.message)),
          // (success) => emit(HomeStateDataLoaded(success)),
              (success) => emit(AuctionDataLoaded(success))
      );
    });

    on<GetInfoAuctionSession>((event, emit) async {
      emit(GetInfoAuctionSessionLoading());
      final failureOrSuccess = await getAuctionSessionInfoUseCase(GetAuctionSessionInfoParams( productAuctionId: event.productId));
      failureOrSuccess.fold(
              (failure) => emit(AuctionDataErrorState(failure.message)),
          // (success) => emit(HomeStateDataLoaded(success)),
              (success) => emit(AuctionSessionInfoDataLoaded(success))
      );
    }) ;

    on<ActionAuction>((event, emit) async {
      emit(GetInfoAuctionSessionLoading());
      final failureOrSuccess = await actionAuctionUseCase(ActionAuctionProductUseCaseParams(idProduct: event.productId, price: event.price));
      failureOrSuccess.fold(
              (failure) => emit(AuctionDataErrorState(failure.message)),
          // (success) => emit(HomeStateDataLoaded(success)),
              (success) => emit(ActionAuctionSuccess(success))
      );
    }) ;
  }
}
