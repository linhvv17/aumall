import 'package:aumall/features/cart/data/models/cart_product_model.dart';
import 'package:aumall/features/cart/domain/entities/list_product_in_cart_entity.dart';
import 'package:aumall/features/cart/domain/usecases/add_product_to_cart_usecase.dart';
import 'package:aumall/features/cart/domain/usecases/get_product_in_cart_usecase.dart';
import 'package:aumall/features/cart/domain/usecases/remove_product_in_cart_usecase.dart';
import 'package:aumall/features/cart/domain/usecases/update_product_in_cart_usecase.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:aumall/features/shop/domain/entities/products_entity.dart';
import '../../../../core/local/shared_preference.dart';
import '../../../../core/usecase/usecase.dart';
import '../../data/models/cart_model.dart';

part 'cart_event.dart';
part 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  List<Map<String, dynamic>> orderItems = [];
  num totalAmount = 0;
  num totalNumberItems = 0;

  List<ProductSimpleEntity> cartList = [];
  final GetProductInCartUseCase getProductInCartUseCase;
  final AddProductToCartUseCase addProductToCartUseCase;
  final RemoveProductInCartUseCase removeProductInCartUseCase;
  final UpdateProductInCartUseCase updateProductInCartUseCase;

  // final Box<CartProduct> itemBox = Hive.box<CartProduct>("product-cahce");
  // final Box<CartProductModel> itemBoxCartProduct = Hive.box<CartProductModel>("product-cache");
  // String nameProductCache = PreferenceHelper.getDataFromSharedPreference(key: "keyUser");

  // final Box<CartProductModel> itemBoxCartProduct = Hive.box<CartProductModel>(
  //     PreferenceHelper.getDataFromSharedPreference(key: "keyUser")
  // );

  CartBloc(this.getProductInCartUseCase, this.addProductToCartUseCase,
      this.removeProductInCartUseCase, this.updateProductInCartUseCase)
      : super(CartInitial()) {
    on<CartStarted>((event, emit) async {
      emit(CartLoading());
      final failureOrSuccess = await getProductInCartUseCase(NoParams());
      failureOrSuccess.fold(
          (failure) => emit(CartDataErrorState(failure.message)),
          (success) => emit(CartDataLoaded(success)));
    });

    on<AddProductToCart>((event, emit) async {
      final failureOrSuccess = await addProductToCartUseCase(
          AddProductToCartUseCaseParams(1, idProduct: event.productId));
      failureOrSuccess.fold(
          (failure) => emit(CartDataErrorState(failure.message)),
          (success) => emit(AddToCartSuccess(success)));
    });

    on<RemoveFromCart>((event, emit) async {
      emit(CartLoading());
      final failureOrSuccess = await removeProductInCartUseCase(
          RemoveFavoriteProductUseCaseParams(idProduct: event.id));
      failureOrSuccess.fold(
          (failure) => emit(CartDataErrorState(failure.message)),
          (success) => emit(RemoveProductInCartSuccess(success)));
    });

    on<IncrementCount>((event, emit) async {
      event.productInCartEntity.quantity++;
      final failureOrSuccess = await updateProductInCartUseCase(
          UpdateProductInCartUseCaseParams(event.quantity,
              idProduct: event.productInCartEntity.productId));
      failureOrSuccess.fold(
          (failure) => emit(CartDataErrorState(failure.message)),
          (success) => emit(UpdateProductInCartSuccess(success)));
    });
    on<DecrementCount>((event, emit) async {
      event.productInCartEntity.quantity--;
      final failureOrSuccess = await updateProductInCartUseCase(
          UpdateProductInCartUseCaseParams(event.quantity,
              idProduct: event.productInCartEntity.id));
      failureOrSuccess.fold(
          (failure) => emit(CartDataErrorState(failure.message)),
          // (success) => emit(HomeStateDataLoaded(success)),
          (success) => emit(UpdateProductInCartSuccess(success)));
    });
  }
}
