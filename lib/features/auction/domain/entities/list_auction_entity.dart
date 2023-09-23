import 'package:aumall/features/home/data/models/banner_model.dart';
import 'package:aumall/features/shopping/domain/entities/products_entity.dart';
import 'package:equatable/equatable.dart';

class ListAuctionEntity extends Equatable {
  final List<ProductAuMallEntity> listAuction;
  const ListAuctionEntity(this.listAuction);
  @override
  List<Object?> get props => [];
}
