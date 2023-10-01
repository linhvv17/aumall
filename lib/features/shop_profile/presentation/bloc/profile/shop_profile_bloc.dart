import 'package:aumall/features/auction/domain/usecases/action_auction_usecase.dart';
import 'package:aumall/features/shop_profile/domain/entities/shop_profile_entity.dart';
import 'package:aumall/features/shop_profile/domain/usecases/get_shop_product_usecase.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../../../../shopping/domain/entities/products_entity.dart';
import '../../../domain/entities/shop_product_entity.dart';
import '../../../domain/repositories/shop_profile_repository.dart';
import '../../../domain/usecases/get_shop_profile_usecase.dart';

part 'shop_profile_event.dart';
part 'shop_profile_state.dart';

class ShopProfileBloc extends Bloc<ShopProfileEvent, ShopProfileState> {
  List<ProductSimpleEntity> favouriteList = [];
  final GetShopProfileUseCase getShopProfileUseCase;
  final GetShopProductUseCase getShopProductUseCase;


  ShopProfileBloc(this.getShopProfileUseCase, this.getShopProductUseCase, )
      : super(ShopProfileInitial()) {
    on<GetShopProfile>((event, emit) async {
      emit(ShopProfileDataLoading());
      final failureOrSuccess = await getShopProfileUseCase(
          GetShopProfileParams( shopId: event.shopId,));
      failureOrSuccess.fold(
          (failure) => emit(ShopProfileDataErrorState(failure.message)),
          (success) => emit(ShopProfileDataLoaded(success)));
    });

  }
}
