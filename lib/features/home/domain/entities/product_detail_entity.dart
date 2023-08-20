import 'package:aumall/features/home/data/models/detail_product_response.dart';
import 'package:equatable/equatable.dart';

class ProductDetailEntity extends Equatable {
  final ProductDetailDataModel? productDetailData;
  final ListRelatedProducts? relatedProducts;
  const ProductDetailEntity(this.productDetailData, this.relatedProducts);
  @override
  List<Object?> get props {
    return [productDetailData, relatedProducts];
  }
}
