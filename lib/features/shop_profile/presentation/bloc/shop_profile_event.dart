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

class ActionShopProfile extends ShopProfileEvent {
  final int productId;
  final String price;
  const ActionShopProfile(this.productId, this.price);
}

class RemoveShopProfileProduct extends ShopProfileEvent {
  final int productId;
  const RemoveShopProfileProduct(this.productId);
}

class GetListShopProfileProduct extends ShopProfileEvent {
  final int typeShopProfile;
  const GetListShopProfileProduct(this.typeShopProfile);
}

class AddToShopProfile extends ShopProfileEvent {
  final bool isFavourite;
  final ProductAuMallEntity product;
  const AddToShopProfile({
    required this.isFavourite,
    required this.product,
  });
}
