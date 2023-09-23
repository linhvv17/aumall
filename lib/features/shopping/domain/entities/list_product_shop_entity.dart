import 'package:aumall/features/home/data/models/banner_model.dart';
import 'package:aumall/features/shopping/domain/entities/products_entity.dart';
import 'package:equatable/equatable.dart';

class ListProductShopEntity extends Equatable {
  final List<ProductAuMallEntity> listProductAuMall;
  const ListProductShopEntity(this.listProductAuMall);
  @override
  List<Object?> get props => [];
}
