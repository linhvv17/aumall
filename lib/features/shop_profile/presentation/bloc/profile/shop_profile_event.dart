// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'shop_profile_bloc.dart';

abstract class ShopProfileEvent extends Equatable {
  const ShopProfileEvent();

  @override
  List<Object> get props => [];
}

class ShopProfileEventInitial extends ShopProfileEvent {

}
class GetShopProfile extends ShopProfileEvent {
  final int shopId;
  const GetShopProfile(this.shopId);
}


