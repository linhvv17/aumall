import 'package:aumall/features/home/data/models/banner_model.dart';
import 'package:aumall/features/home/domain/entities/banner_entity.dart';
import 'package:aumall/features/home/domain/entities/list_product_home_entity.dart';
import 'package:equatable/equatable.dart';

import '../../data/models/list_product_home_model.dart';

class HomeDataEntity extends Equatable {
  final BannerEntity bannerEntity;
  final ListProductHomeEntity listProductHomeEntity;
  const HomeDataEntity(this.bannerEntity, this.listProductHomeEntity);
  @override
  List<Object?> get props => [];
}
