import 'package:aumall/features/shop/domain/entities/categories_entity.dart';
import 'package:aumall/features/shop/domain/repositories/product_repository.dart';
import 'package:aumall/features/shop/domain/usecases/get_products_shop_usecase.dart';
import 'package:aumall/features/shop/domain/usecases/search_products_usecase.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import '../../../../core/usecase/usecase.dart';
import '../../domain/entities/list_product_shop_entity.dart';
import '../../domain/entities/products_entity.dart';
import '../../domain/entities/shop_data_default_entity.dart';
import '../../domain/usecases/change_category_usecase.dart';
import '../../domain/usecases/get_all_products_usecase.dart';
import '../../domain/usecases/get_products_by_type_usecase.dart';
import '../../domain/usecases/get_shop_data_default_usecase.dart';
import '../../domain/usecases/get_specific_product.dart';
part 'products_event.dart';
part 'products_state.dart';

class ProductsBloc extends Bloc<ProductsEvent, ProductsState> {
  List<CategoryEntity> categoriesEntity = [];
  late CategoriesEntity categoriesEntityModel;
  int current = 0;
  RangeValues priceSelectRange = const RangeValues(200, 400);
  double rateValue = 0;
  bool searchFolded = true;
  final GetAllProductsUseCase getAllProductsUseCase;
  final GetProductByFilterUseCase getProductByFilterUseCase;
  final GetShopDataDefaultUseCase getShopDataDefaultUseCase;
  final GetProductsShopUseCase getProductsShopUseCase;
  final ChangeCategoryUseCase changeCategoryUseCase;
  final SearchProductsUseCase searchProductsUseCase;
  final GetProductsByTypeUseCase getProductsByTypeUseCase;
  ProductsBloc(
      this.getAllProductsUseCase,
      this.getProductByFilterUseCase,
      this.getShopDataDefaultUseCase,
      this.getProductsShopUseCase,
      this.changeCategoryUseCase,
      this.searchProductsUseCase, this.getProductsByTypeUseCase)
      : super(AllProductsLoadingState()) {

    on<GetShopDataDefault>((event, emit) async {
      current = 0;
      final failureOrSuccess = await getShopDataDefaultUseCase(
          NoParams()
      );
      failureOrSuccess.fold(
              (failure) => emit(AllProductsErrorState(failure.message)),
              (success) {
                categoriesEntity = success.categoriesEntity.categories;
                // emit(GetShopDataDefaultSuccessState(success));
                categoriesEntityModel = success.categoriesEntity;
                emit(ProductsStateDataLoaded(
                  categoriesEntity: success.categoriesEntity,
                  listProductAuMall: success.listProductAuMall
                ));
              });

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
            print('ChangeCategory ChangCategorySuccessState $current');
            // emit(ChangCategorySuccessState(success));
            emit(ProductsLoadingState());

            emit(const ProductsStateDataLoaded()
                .copyWith(
              categoriesEntity: categoriesEntityModel,
                listProductAuMall: success));
          });
    });


    on<SearchProduct>((event, emit) async {
      // emit(ChangeCategoryState());
      final failureOrSuccess = await searchProductsUseCase(
          SearchProductsUseCaseParams(event.keyword)
      );

      failureOrSuccess.fold(
              (failure) => emit(AllProductsErrorState(failure.message)),
              (success) {
            // current = event.index;
            print('ChangeCategory ChangCategorySuccessState $current');
            // emit(ChangCategorySuccessState(success));
            emit(ProductsLoadingState());
            emit(const ProductsSearchStateDataLoaded()
                .copyWith(
                listProductAuMall: success));
          });
    });

    on<GetProductsByType>((event, emit) async {
      // emit(ChangeCategoryState());
      final failureOrSuccess = await getProductsByTypeUseCase(
          GetProductsByTypeUseCaseParams(event.key)
      );

      failureOrSuccess.fold(
              (failure) => emit(AllProductsErrorState(failure.message)),
              (success) {
            // current = event.index;
            print('ChangeCategory ChangCategorySuccessState $current');
            // emit(ChangCategorySuccessState(success));
            emit(ProductsLoadingState());
            emit(const ProductsStateDataLoaded()
                .copyWith(
                listProductAuMall: success));
          });
    });



    on<GetProductsByFilter>((event, emit) async {
      emit(SpecificProductsLoadingState());
      final failureOrSuccess = await getProductByFilterUseCase(
        GetProductByFilterUseCaseParams( event.minPrice, event.maxPrice,event.rate, ),
      );
      failureOrSuccess.fold(
          (failure) => emit(SpecificProductsErrorState(failure.message)),
          // (success) => emit(SpecificProductsLoadedState(success))
          (success) {
            emit(ProductsLoadingState());
            emit(const ProductsSearchStateDataLoaded()
                .copyWith(
                listProductAuMall: success));
          }
      );
    });


    on<OpenSearch>((event, emit) {
      searchFolded = !searchFolded;
      emit(OpenSearchState());
    });
  }
}
