import 'package:aumall/features/shop_profile/domain/usecases/get_shop_product_usecase.dart';
import 'package:aumall/features/shop_profile/presentation/bloc/product/shop_product_event.dart';
import 'package:aumall/features/shop_profile/presentation/bloc/product/shop_product_state.dart';
import 'package:bloc/bloc.dart';

import '../../../domain/repositories/shop_profile_repository.dart';

class ShopProductBloc extends Bloc<ShopProductEvent, ShopProductState> {
  final GetShopProductUseCase getShopProductUseCase;


  ShopProductBloc(this.getShopProductUseCase, )
      : super(ShopProductInitial()) {
    on<GetShopProduct>((event, emit) async {
      emit(ShopProductDataLoading());
      final failureOrSuccess = await getShopProductUseCase(
          GetShopProductParams( shopId: event.shopId,));
      failureOrSuccess.fold(
          (failure) => emit(ShopProductDataErrorState(failure.message)),
          (success) => emit(ShopProductDataLoaded(success)));
    });
  }
}
