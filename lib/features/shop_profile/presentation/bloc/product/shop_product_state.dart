

import 'package:equatable/equatable.dart';

import '../../../domain/entities/list_shop_product_entity.dart';
import '../../../domain/entities/shop_product_entity.dart';

abstract class ShopProductState extends Equatable {
  const ShopProductState();

  @override
  List<Object> get props => [];
}

class ShopProductInitial extends ShopProductState {}

class ShopProductDataLoading extends ShopProductState {}

class ShopProductDataLoaded extends ShopProductState {
  final List<ListShopProductsEntity> shopProductEntities;
  const ShopProductDataLoaded(this.shopProductEntities);
}


class ShopProductDataErrorState extends ShopProductState {
  final String message;

  const ShopProductDataErrorState(this.message);
}

