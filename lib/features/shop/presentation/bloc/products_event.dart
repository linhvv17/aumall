part of 'products_bloc.dart';

abstract class ProductsEvent extends Equatable {
  const ProductsEvent();
  @override
  List<Object> get props => [];
}

class GetAllProducts extends ProductsEvent {}

class GetShopDataDefault extends ProductsEvent {
  const GetShopDataDefault();
}


class GetProductsByFilter extends ProductsEvent {
  final String minPrice;
  final String maxPrice;
  final String rate;
  const GetProductsByFilter(
    this.minPrice,
    this.maxPrice,
    this.rate,
  );
}


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


//search products
class SearchProduct extends ProductsEvent {
  final String keyword;
  const SearchProduct(this.keyword);
}
//change tab category
class ChangeCategory extends ProductsEvent {
  final int index;
  final int categoryId;

  const ChangeCategory( this.index, this.categoryId);
}

//get by type products
class GetProductsByType extends ProductsEvent {
  final String key;
  const GetProductsByType(this.key);
}

class OpenSearch extends ProductsEvent {

}
