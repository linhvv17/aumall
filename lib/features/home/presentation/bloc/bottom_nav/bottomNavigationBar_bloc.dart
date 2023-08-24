import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
part 'bottomNavigationBar_event.dart';
part 'bottomNavigationBar_state.dart';

class BottomNavigationBarBloc
    extends Bloc<BottomNavigationBarEvent, BottomNavigationBarState> {
  BottomNavigationBarBloc() : super(HomeState()) {
    on<LoadHome>((event, emit) => emit(HomeState()));
    on<LoadShop>((event, emit) => emit(ShopState()));
    on<LoadAuction>((event, emit) => emit(AuctionSelectState()));
    // on<LoadBag>((event, emit) => emit(BagState()));
    on<LoadNotification>((event, emit) => emit(NotifiState()));
    on<LoadFavorite>((event, emit) => emit(FavoriteState()));
    on<LoadProfile>((event, emit) => emit(ProfilePageState()));
  }
}
