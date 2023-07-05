import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import '../../../../core/usecase/usecase.dart';
import '../../domain/entities/products_entity.dart';
import '../../domain/usecases/getAllProducts_usecase.dart';
import '../../domain/usecases/getSpecificProduct.dart';
part 'products_event.dart';
part 'products_state.dart';

class ProductsBloc extends Bloc<ProductsEvent, ProductsState> {
  List<String> categories = [
    "Watches",
    "Cars",
    "Clothes",
    "Shoes",
    "Electronics",
    "Smartphones",
    "Camera",
    "Sports",
    "Books",
  ];
  int current = 0;
  RangeValues priceSelectRange = const RangeValues(200, 400);
  double rateValue = 0;
  bool searchFolded = true;
  final GetAllProductsUsecase getAllProductsUseCase;
  final GetSpecificProductUseCase getSpecificProductUseCase;
  ProductsBloc(this.getAllProductsUseCase, this.getSpecificProductUseCase)
      : super(
          AllProductsLoadingState(),
        ) {
    on<GetAllProducts>((event, emit) async {
      final failureOrSuccess = await getAllProductsUseCase(NoParams());

      failureOrSuccess.fold(
          (failure) => emit(AllProductsErrorState(failure.message)),
          (success) => emit(AllProductsLoadedState(success)));
    });
    on<GetSpecificProduct>((event, emit) async {
      emit(SpecificProductsLoadingState());
      final failureOrSuccess = await getSpecificProductUseCase(
        GetProductUseCaseParams(event.category, event.minPrice, event.maxPrice,
            event.rate, event.keyword),
      );
      failureOrSuccess.fold(
          (failure) => emit(SpecificProductsErrorState(failure.message)),
          (success) => emit(SpecificProductsLoadedState(success)));
    });
    on<ChangeCategory>((event, emit) {
      current = event.index;
      emit(ChangeCategoryState());
    });
    on<GetFilterSpecificProduct>((event, emit) async {
      emit(FilterProductsLoadingState());
      final failureOrSuccess = await getSpecificProductUseCase(
        GetProductUseCaseParams(event.category, event.minPrice, event.maxPrice,
            event.rate, event.keyword),
      );

      failureOrSuccess.fold(
          (failure) => emit(ProductsErrorState(failure.message)),
          (success) => emit(FilterProductsLoadedState(success)));
    });
    on<OpenSearch>((event, emit) {
      searchFolded = !searchFolded;
      emit(OpenSearchState());
    });
  }
}
