part of 'products_bloc.dart';

abstract class ProductsEvent extends Equatable {
  const ProductsEvent();

  @override
  List<Object> get props => [];
}

class GetShopDataDefault extends ProductsEvent {
  final GetShopDataDefaultParams getShopDataDefaultParams;
  const GetShopDataDefault(
      this.getShopDataDefaultParams,
      );
}

class GetProductsShop extends ProductsEvent {
  final GetShopDataDefaultParams getShopDataDefaultParams;
  const GetProductsShop(
      this.getShopDataDefaultParams,
      );
}

class GetAllProducts extends ProductsEvent {}

class GetSpecificProduct extends ProductsEvent {
  final String category;
  final String minPrice;
  final String maxPrice;
  final String rate;
  final String keyword;
  const GetSpecificProduct(
    this.category,
    this.minPrice,
    this.maxPrice,
    this.rate,
    this.keyword,
  );
}

class GetFilterSpecificProduct extends ProductsEvent {
  final String category;
  final String minPrice;
  final String maxPrice;
  final String rate;
    final String keyword;
  const GetFilterSpecificProduct(
    this.category,
    this.minPrice,
    this.maxPrice,
    this.rate,
        this.keyword,
  );
}

class ChangeCategory extends ProductsEvent {
  final int index;

  const ChangeCategory(this.index);
}

class OpenSearch extends ProductsEvent {}
