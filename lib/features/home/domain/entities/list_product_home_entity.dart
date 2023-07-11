import 'package:aumall/features/home/data/models/banner_model.dart';
import 'package:aumall/features/shop/domain/entities/products_entity.dart';
import 'package:equatable/equatable.dart';

import '../../data/models/list_product_home_model.dart';

class ListProductHomeEntity extends Equatable{
  final ListProductHomeData listProductHomeData;
  const ListProductHomeEntity(this.listProductHomeData);
  @override
  List<Object?> get props => [];

}