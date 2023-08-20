part of 'cart_bloc.dart';

abstract class CartEvent extends Equatable {
  const CartEvent();

  @override
  List<Object> get props => [];
}

class CartStarted extends CartEvent {}

class AddProductToCart extends CartEvent {
  final int productId;
  const AddProductToCart({required this.productId});
}

class AddToCart extends CartEvent {
  final ProductInCartEntity product;
  final int index;
  const AddToCart(this.product, this.index);
}

class RemoveFromCart extends CartEvent {
  final int id;

  const RemoveFromCart(this.id);
}

class IncrementCount extends CartEvent {
  final ProductInCartEntity productInCartEntity;
  final int quantity;

  const IncrementCount(this.productInCartEntity, this.quantity);
}

class DecrementCount extends CartEvent {
  final ProductInCartEntity productInCartEntity;
  final int quantity;
  const DecrementCount(this.productInCartEntity, this.quantity);
}
