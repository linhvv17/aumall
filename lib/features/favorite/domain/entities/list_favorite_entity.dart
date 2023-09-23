import 'package:aumall/features/home/data/models/banner_model.dart';
import 'package:aumall/features/shopping/domain/entities/products_entity.dart';
import 'package:equatable/equatable.dart';

class ListFavoriteEntity extends Equatable {
  final List<ProductAuMallEntity> listFavorite;
  const ListFavoriteEntity(this.listFavorite);
  @override
  List<Object?> get props => [];
}
