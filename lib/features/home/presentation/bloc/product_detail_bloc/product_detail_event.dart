import 'package:equatable/equatable.dart';

abstract class ProductDetailEvent extends Equatable {
  const ProductDetailEvent();

  @override
  List<Object> get props => [];
}

class GetProductDetailData extends ProductDetailEvent {
  final int idProduct;
  const GetProductDetailData(this.idProduct);
}
