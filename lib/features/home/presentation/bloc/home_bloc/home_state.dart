
import 'package:aumall/features/home/domain/entities/banner_entity.dart';
import 'package:equatable/equatable.dart';



abstract class HomeLoadState extends Equatable{
  const HomeLoadState();
  @override
  List<Object> get props => [];
}
class HomeStateInitial extends HomeLoadState{

}

class HomeStateLoading extends HomeLoadState {}

class HomeErrorState extends HomeLoadState {
  final String message;

  const HomeErrorState(this.message);
}


class HomeStateDataLoaded extends HomeLoadState{
  final BannerEntity bannerEntity;
  const HomeStateDataLoaded(this.bannerEntity);
}