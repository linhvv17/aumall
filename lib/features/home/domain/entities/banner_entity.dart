import 'package:aumall/features/home/data/models/banner_model.dart';
import 'package:equatable/equatable.dart';

class BannerEntity extends Equatable{
  final List<ImageEntity> images;

  const BannerEntity(this.images);
  @override
  List<Object?> get props => [];

}