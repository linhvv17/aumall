import 'package:aumall/features/home/data/models/list_product_home_model.dart';
import 'package:aumall/features/home/domain/entities/banner_entity.dart';
import 'package:aumall/features/home/domain/entities/list_product_home_entity.dart';
import 'package:aumall/features/home/domain/entities/product_detail_entity.dart';
import 'package:equatable/equatable.dart';

abstract class ProductDetailState extends Equatable {
  const ProductDetailState();

  @override
  List<Object> get props => [];
}

class ProductDetailInitial extends ProductDetailState {

}

class GetInfoAuctionLoading extends ProductDetailState {

}
class ProductDetailLoading extends ProductDetailState {

}

class ProductDetailLoaded extends ProductDetailState {
  final ProductDetailEntity productDetailEntity;
  const ProductDetailLoaded(this.productDetailEntity);

}

class ProductDetailErrorState extends ProductDetailState {
  final String message;

  const ProductDetailErrorState(this.message);
}


