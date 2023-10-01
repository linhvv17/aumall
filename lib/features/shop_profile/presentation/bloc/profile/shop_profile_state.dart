part of 'shop_profile_bloc.dart';

abstract class ShopProfileState extends Equatable {
  const ShopProfileState();

  @override
  List<Object> get props => [];
}

class ShopProfileInitial extends ShopProfileState {}


class ShopProfileDataLoading extends ShopProfileState {}


class ShopProfileDataLoaded extends ShopProfileState {
  final ShopProfileEntity shopProfileEntity;
  const ShopProfileDataLoaded(this.shopProfileEntity);
}

class ShopProfileDataErrorState extends ShopProfileState {
  final String message;

  const ShopProfileDataErrorState(this.message);
}


