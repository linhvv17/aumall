import 'package:equatable/equatable.dart';


abstract class HomeEvent extends Equatable {
  const HomeEvent();

  @override
  List<Object> get props => [];
}

class GetDataHome extends HomeEvent {

}
class GetBannerData extends HomeEvent {

}

class GetListProductHomeData extends HomeEvent {

}