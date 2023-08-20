part of 'products_bloc.dart';

abstract class ProductsState extends Equatable {
  const ProductsState();

  @override
  List<Object> get props => [];
}

class GetProductsShopLoadedState extends ProductsState {
  final ListProductShopEntity listProductShopEntity;

  const GetProductsShopLoadedState(
    this.listProductShopEntity,
  );

  @override
  List<Object> get props => [listProductShopEntity];
}

class ProductsSearchStateDataLoaded extends ProductsState {
  final ListProductShopEntity listProductAuMall;

  const ProductsSearchStateDataLoaded(
      {this.listProductAuMall = const ListProductShopEntity([])});

  ProductsSearchStateDataLoaded copyWith(
      {ListProductShopEntity? listProductAuMall}) {
    return ProductsSearchStateDataLoaded(
        listProductAuMall: listProductAuMall ?? this.listProductAuMall);
  }

  @override
  List<Object> get props => [listProductAuMall];
}

class ProductsStateDataLoaded extends ProductsState {
  final CategoriesEntity categoriesEntity;
  final ListProductShopEntity listProductAuMall;

  const ProductsStateDataLoaded(
      {this.categoriesEntity = const CategoriesEntity([]),
      this.listProductAuMall = const ListProductShopEntity([])});

  ProductsStateDataLoaded copyWith(
      {CategoriesEntity? categoriesEntity,
      ListProductShopEntity? listProductAuMall}) {
    return ProductsStateDataLoaded(
        categoriesEntity: categoriesEntity ?? this.categoriesEntity,
        listProductAuMall: listProductAuMall ?? this.listProductAuMall);
  }

  @override
  List<Object> get props => [categoriesEntity, listProductAuMall];
}

class GetShopDefaultDataLoadedState extends ProductsState {
  final CategoriesEntity categoriesEntity;

  const GetShopDefaultDataLoadedState(
    this.categoriesEntity,
  );
}

class AllProductsLoadingState extends ProductsState {}

class AllProductsLoadedState extends ProductsState {
  final ProductsEntity data;

  const AllProductsLoadedState(
    this.data,
  );
}

class AllProductsErrorState extends ProductsState {
  final String message;

  const AllProductsErrorState(this.message);
}

class ProductsLoadingState extends ProductsState {}

class ProductsLoadedState extends ProductsState {
  final ProductsEntity data;

  const ProductsLoadedState(
    this.data,
  );
}

class FilterProductsLoadingState extends ProductsState {}

class FilterProductsLoadedState extends ProductsState {
  final ProductsEntity data;

  const FilterProductsLoadedState(
    this.data,
  );
}

class ProductsErrorState extends ProductsState {
  final String message;

  const ProductsErrorState(this.message);
}

class SpecificProductsLoadingState extends ProductsState {}

class SpecificProductsLoadedState extends ProductsState {
  final ProductsEntity data;

  const SpecificProductsLoadedState(this.data);
}

class SpecificProductsErrorState extends ProductsState {
  final String message;

  const SpecificProductsErrorState(this.message);
}

class ChangeCategoryState extends ProductsState {}

class OpenSearchInitialState extends ProductsState {}

class OpenSearchState extends ProductsState {}

class ShopLoadDataErrorState extends ProductsState {
  final String message;
  const ShopLoadDataErrorState(this.message);
}

class ShopLoadingData extends ProductsState {
  const ShopLoadingData();
}

class ShopLoadingDataProducts extends ProductsState {
  const ShopLoadingDataProducts();
}

class ShopLoadListCategoriesSuccess extends ProductsState {
  final CategoriesEntity categoriesEntity;
  const ShopLoadListCategoriesSuccess(this.categoriesEntity);
}

class ShopLoadProductsSuccessWithFilter extends ProductsState {
  final ListProductShopEntity listProductShopEntity;
  const ShopLoadProductsSuccessWithFilter(this.listProductShopEntity);
}

class ChangCategorySuccessState extends ProductsState {
  final ListProductShopEntity listProductAuMall;

  const ChangCategorySuccessState(this.listProductAuMall);

  @override
  List<Object> get props => [listProductAuMall];
}

class GetProductsByTypeSuccessState extends ProductsState {
  final ListProductShopEntity listProductAuMall;

  const GetProductsByTypeSuccessState(this.listProductAuMall);

  @override
  List<Object> get props => [listProductAuMall];
}

class GetShopDataDefaultSuccessState extends ProductsState {
  final ShopDataDefaultEntity shopDataDefaultEntity;
  const GetShopDataDefaultSuccessState(
    this.shopDataDefaultEntity,
  );
}
