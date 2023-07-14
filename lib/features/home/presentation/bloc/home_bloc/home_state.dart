import 'package:aumall/features/home/data/models/list_product_home_model.dart';
import 'package:aumall/features/home/domain/entities/banner_entity.dart';
import 'package:aumall/features/home/domain/entities/list_product_home_entity.dart';
import 'package:equatable/equatable.dart';

abstract class HomeLoadState extends Equatable {
  const HomeLoadState();

  @override
  List<Object> get props => [];
}

class HomeStateInitial extends HomeLoadState {

}

class HomeStateLoading extends HomeLoadState {

}
class HomeStateGetDataSuccess extends HomeLoadState {
  BannerEntity? bannerEntity;
  ListProductHomeEntity? listProductHomeEntity;

  HomeStateGetDataSuccess(this.bannerEntity,  this.listProductHomeEntity);
}

class HomeStateLoadedFullData extends HomeLoadState {
  BannerEntity? bannerEntity;
  ListProductHomeEntity? listProductHomeEntity;

  HomeStateLoadedFullData(this.bannerEntity,  this.listProductHomeEntity);

  // HomeStateLoadedFullData copyWith({
  //   BannerEntity? bannerEntity,
  //   ListProductHomeEntity? listProductHomeEntity,
  // }) {
  //   return HomeStateLoadedFullData(
  //       bannerEntity ?? this.bannerEntity,
  //       listProductHomeEntity?? this.listProductHomeEntity
  //   );
  // }

}

class HomeErrorState extends HomeLoadState {
  final String message;

  const HomeErrorState(this.message);
}

class HomeStateDataLoaded extends HomeLoadState {
  final BannerEntity bannerEntity;

  const HomeStateDataLoaded(this.bannerEntity);
}

class HomeStateLoadListProductLoading extends HomeLoadState {}

class HomeStateLoadListProductDataLoaded extends HomeLoadState {
  final ListProductHomeEntity listProductHomeEntity;

  const HomeStateLoadListProductDataLoaded(this.listProductHomeEntity);
}
