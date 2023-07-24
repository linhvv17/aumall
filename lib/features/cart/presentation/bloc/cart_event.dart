part of 'cart_bloc.dart';

abstract class CartEvent extends Equatable {
  const CartEvent();

  @override
  List<Object> get props => [];
}

class CartStarted extends CartEvent{
  
}

class AddProductToCart extends CartEvent {
  final ProductAuMallEntity productAuMallEntity;
  final int index;
  const AddProductToCart(this.productAuMallEntity, this.index);
}

class AddToCart extends CartEvent {
  final ProductEntity product;
  final int index;
  const AddToCart(this.product, this.index);
}

class RemoveFromCart extends CartEvent {
  final int id;

  const RemoveFromCart(this.id);
}

class IncrementCount extends CartEvent {
  final CartProductModel cartProduct;
  final int index;

  const IncrementCount(this.cartProduct, this.index);
}

class DecrementCount extends CartEvent {
  final CartProductModel cartProduct;
  final int index;
  const DecrementCount(this.cartProduct, this.index);
}
