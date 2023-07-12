import 'package:equatable/equatable.dart';

import '../../data/models/product_detail_model.dart';

class ProductDetailEntity extends Equatable{
  final ProductDetailData? productDetailData;
  final ListRelatedProducts? relatedProducts;
  const ProductDetailEntity( this.productDetailData, this.relatedProducts);
  @override
  List<Object?> get props {
    return [
      productDetailData,
      relatedProducts
    ];
  }

}

