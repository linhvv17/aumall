import 'package:aumall/features/shop/domain/entities/categories_entity.dart';
import 'package:aumall/features/shop/domain/repositories/product_repository.dart';
import 'package:aumall/features/shop/domain/usecases/get_products_shop_usecase.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import '../../../../core/usecase/usecase.dart';
import '../../domain/entities/list_product_shop_entity.dart';
import '../../domain/entities/products_entity.dart';
import '../../domain/entities/shop_data_default_entity.dart';
import '../../domain/usecases/change_category_usecase.dart';
import '../../domain/usecases/get_all_products_usecase.dart';
import '../../domain/usecases/get_shop_data_default_usecase.dart';
import '../../domain/usecases/get_specific_product.dart';
part 'products_event.dart';
part 'products_state.dart';

class ProductsBloc extends Bloc<ProductsEvent, ProductsState> {
  List<CategoryEntity> categoriesEntity = [];
  int current = 0;
  RangeValues priceSelectRange = const RangeValues(200, 400);
  double rateValue = 0;
  bool searchFolded = true;
  final GetAllProductsUsecase getAllProductsUseCase;
  final GetSpecificProductUseCase getSpecificProductUseCase;
  final GetShopDataDefaultUseCase getShopDataDefaultUseCase;
  final GetProductsShopUseCase getProductsShopUseCase;
  final ChangeCategoryUseCase changeCategoryUseCase;
  ProductsBloc(
      this.getAllProductsUseCase,
      this.getSpecificProductUseCase,
      this.getShopDataDefaultUseCase,
      this.getProductsShopUseCase,
      this.changeCategoryUseCase)
      : super(AllProductsLoadingState()) {
    on<GetProductsShop>((event, emit) async {
      emit(ProductsLoadingState());
      final failureOrSuccess = await getProductsShopUseCase(event.getShopDataDefaultParams);

      failureOrSuccess.fold(
              (failure) => emit(AllProductsErrorState(failure.message)),
              (success) => emit(GetProductsShopLoadedState(success)));

    });

    on<GetShopDataDefault>((event, emit) async {
      final failureOrSuccess = await getShopDataDefaultUseCase(
          NoParams()
      );

      failureOrSuccess.fold(
              (failure) => emit(AllProductsErrorState(failure.message)),
              (success) {
                categoriesEntity = success.categoriesEntity.categories;
                emit(GetShopDataDefaultSuccessState(success));
              });

    });
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
    on<ChangeCategory>((event, emit) async {
      // emit(ChangeCategoryState());

      final failureOrSuccess = await changeCategoryUseCase(
          ChangeCategoryUseCaseParams(event.categoryId)
      );

      failureOrSuccess.fold(
              (failure) => emit(AllProductsErrorState(failure.message)),
              (success) {
                current = event.index;
                categoriesEntity = categoriesEntity;
                print('ChangeCategory ChangCategorySuccessState $current');
                emit(ChangCategorySuccessState(success));
              });
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
