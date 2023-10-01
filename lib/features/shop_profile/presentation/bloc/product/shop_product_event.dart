import 'package:equatable/equatable.dart';

abstract class ShopProductEvent extends Equatable {
  const ShopProductEvent();

  @override
  List<Object> get props => [];
}

class ShopProductEventInitial extends ShopProductEvent {

}

class GetShopProduct extends ShopProductEvent {
  final int shopId;
  const GetShopProduct(this.shopId);
}

